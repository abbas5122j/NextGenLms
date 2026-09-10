import 'dart:convert';
import 'package:http/http.dart' as http;
import 'admin_models.dart';

class AdminApiException implements Exception {
  final String message;
  final int? statusCode;
  const AdminApiException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

/// Flutter talks only to the Admin Gateway.
/// Individual microservice ports must NOT be exposed to the Flutter app.
class AdminApiClient {
  final String gatewayBaseUrl;
  final Future<String?> Function()? accessTokenProvider;
  final http.Client _client;

  AdminApiClient({
    required this.gatewayBaseUrl,
    this.accessTokenProvider,
    http.Client? client,
  }) : _client = client ?? http.Client();

  Uri _uri(String path) {
    final base = gatewayBaseUrl.endsWith('/')
        ? gatewayBaseUrl.substring(0, gatewayBaseUrl.length - 1)
        : gatewayBaseUrl;
    return Uri.parse('$base${path.startsWith('/') ? path : '/$path'}');
  }

  Future<Map<String, String>> _headers() async {
    final token = await accessTokenProvider?.call();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> _request(
    String method,
    String path, {
    Map<String, dynamic>? body,
  }) async {
    final headers = await _headers();
    late http.Response response;

    switch (method) {
      case 'GET':
        response = await _client.get(_uri(path), headers: headers);
        break;
      case 'POST':
        response = await _client.post(
          _uri(path),
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;
      case 'PATCH':
        response = await _client.patch(
          _uri(path),
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;
      default:
        throw const AdminApiException('Unsupported HTTP method.');
    }

    dynamic decoded;
    if (response.body.isNotEmpty) {
      try {
        decoded = jsonDecode(response.body);
      } catch (_) {
        decoded = response.body;
      }
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map
          ? '${decoded['message'] ?? decoded['error'] ?? 'Admin API request failed.'}'
          : 'Admin API request failed (${response.statusCode}).';
      throw AdminApiException(message, statusCode: response.statusCode);
    }

    return decoded;
  }

  Future<AdminOverview> getOverview() async {
    final data = await _request('GET', '/api/admin/analytics/overview');
    return AdminOverview.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<AdminTenant>> getTenants() async {
    final data = await _request('GET', '/api/admin/tenants');
    final list = data is Map ? data['items'] : data;
    return (list as List)
        .map((e) => AdminTenant.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<AdminTenant> setTenantStatus(String id, String status) async {
    final data = await _request(
      'PATCH',
      '/api/admin/tenants/$id/status',
      body: {'status': status},
    );
    return AdminTenant.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AdminTenant> updateTenantQuota(
    String id, {
    required int studentLimit,
    required int instructorLimit,
    required int pmLimit,
  }) async {
    final data = await _request(
      'PATCH',
      '/api/admin/tenants/$id/quota',
      body: {
        'student_limit': studentLimit,
        'instructor_limit': instructorLimit,
        'pm_limit': pmLimit,
      },
    );
    return AdminTenant.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AdminInfraConfig> getInfra() async {
    final data = await _request('GET', '/api/admin/infra/config');
    return AdminInfraConfig.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AdminInfraConfig> saveInfra(AdminInfraConfig config) async {
    final data = await _request(
      'PATCH',
      '/api/admin/infra/config',
      body: {
        'ai_provider': config.aiProvider,
        'ai_enabled': config.aiEnabled,
        'compiler_enabled': config.compilerEnabled,
        'python_timeout': config.pythonTimeout,
        'python_memory': config.pythonMemory,
        'cpp_timeout': config.cppTimeout,
        'cpp_memory': config.cppMemory,
        'java_timeout': config.javaTimeout,
        'java_memory': config.javaMemory,
        'web_timeout': config.webTimeout,
        'web_memory': config.webMemory,
      },
    );
    return AdminInfraConfig.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<AdminQuestion>> getQuestions() async {
    final data = await _request('GET', '/api/admin/cms/questions');
    final list = data is Map ? data['items'] : data;
    return (list as List)
        .map((e) => AdminQuestion.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<AdminQuestion> createQuestion({
    required String type,
    required String title,
    required String difficulty,
    required String topic,
    required String details,
    required String boilerplate,
  }) async {
    final data = await _request(
      'POST',
      '/api/admin/cms/questions',
      body: {
        'type': type,
        'title': title,
        'difficulty': difficulty,
        'topic': topic,
        'details': details,
        'boilerplate': boilerplate,
      },
    );
    return AdminQuestion.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AdminQuestion> setQuestionPublished(String id, bool published) async {
    final data = await _request(
      'PATCH',
      '/api/admin/cms/questions/$id/publish',
      body: {'published': published},
    );
    return AdminQuestion.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<AdminPortalCode> generatePortalCode({
    required String tenantId,
    required int maxUses,
    required String expiresAt,
  }) async {
    final data = await _request(
      'POST',
      '/api/admin/portal-codes',
      body: {
        'tenant_id': tenantId,
        'max_uses': maxUses,
        'expires_at': expiresAt,
      },
    );
    return AdminPortalCode.fromJson(Map<String, dynamic>.from(data as Map));
  }

  Future<List<AdminPortalCode>> getPortalCodes() async {
    final data = await _request('GET', '/api/admin/portal-codes');
    final list = data is Map ? data['items'] : data;
    return (list as List)
        .map((e) => AdminPortalCode.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> dispose() async => _client.close();
}
