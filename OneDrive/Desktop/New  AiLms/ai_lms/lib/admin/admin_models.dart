class AdminOverview {
  final int universities;
  final int activeStudents;
  final int instructors;
  final int activeCourses;
  final double monthlyRevenue;
  final double revenueGrowth;
  final double uptime;
  final int activeSubmissions;

  const AdminOverview({
    required this.universities,
    required this.activeStudents,
    required this.instructors,
    required this.activeCourses,
    required this.monthlyRevenue,
    required this.revenueGrowth,
    required this.uptime,
    required this.activeSubmissions,
  });

  factory AdminOverview.fromJson(Map<String, dynamic> json) => AdminOverview(
        universities: _asInt(json['universities']),
        activeStudents: _asInt(json['active_students']),
        instructors: _asInt(json['instructors']),
        activeCourses: _asInt(json['active_courses']),
        monthlyRevenue: _asDouble(json['monthly_revenue']),
        revenueGrowth: _asDouble(json['revenue_growth']),
        uptime: _asDouble(json['uptime']),
        activeSubmissions: _asInt(json['active_submissions']),
      );
}

class AdminTenant {
  final String id;
  final String name;
  final String domain;
  final int students;
  final int studentLimit;
  final int instructorLimit;
  final int pmLimit;
  final String plan;
  final String status;
  final String licenseKey;

  const AdminTenant({
    required this.id,
    required this.name,
    required this.domain,
    required this.students,
    required this.studentLimit,
    required this.instructorLimit,
    required this.pmLimit,
    required this.plan,
    required this.status,
    required this.licenseKey,
  });

  factory AdminTenant.fromJson(Map<String, dynamic> json) => AdminTenant(
        id: '${json['id'] ?? ''}',
        name: '${json['name'] ?? ''}',
        domain: '${json['domain'] ?? ''}',
        students: _asInt(json['students']),
        studentLimit: _asInt(json['student_limit']),
        instructorLimit: _asInt(json['instructor_limit']),
        pmLimit: _asInt(json['pm_limit']),
        plan: '${json['plan'] ?? 'Standard'}',
        status: '${json['status'] ?? 'Pending'}',
        licenseKey: '${json['license_key'] ?? ''}',
      );
}

class AdminInfraConfig {
  final String aiProvider;
  final bool aiEnabled;
  final bool compilerEnabled;
  final int pythonTimeout;
  final int pythonMemory;
  final int cppTimeout;
  final int cppMemory;
  final int javaTimeout;
  final int javaMemory;
  final int webTimeout;
  final int webMemory;

  const AdminInfraConfig({
    required this.aiProvider,
    required this.aiEnabled,
    required this.compilerEnabled,
    required this.pythonTimeout,
    required this.pythonMemory,
    required this.cppTimeout,
    required this.cppMemory,
    required this.javaTimeout,
    required this.javaMemory,
    required this.webTimeout,
    required this.webMemory,
  });

  factory AdminInfraConfig.fromJson(Map<String, dynamic> json) =>
      AdminInfraConfig(
        aiProvider: '${json['ai_provider'] ?? 'Gemini'}',
        aiEnabled: json['ai_enabled'] == true,
        compilerEnabled: json['compiler_enabled'] != false,
        pythonTimeout: _asInt(json['python_timeout'], fallback: 4000),
        pythonMemory: _asInt(json['python_memory'], fallback: 64),
        cppTimeout: _asInt(json['cpp_timeout'], fallback: 5000),
        cppMemory: _asInt(json['cpp_memory'], fallback: 128),
        javaTimeout: _asInt(json['java_timeout'], fallback: 6000),
        javaMemory: _asInt(json['java_memory'], fallback: 256),
        webTimeout: _asInt(json['web_timeout'], fallback: 8000),
        webMemory: _asInt(json['web_memory'], fallback: 512),
      );

  AdminInfraConfig copyWith({
    String? aiProvider,
    bool? aiEnabled,
    bool? compilerEnabled,
    int? pythonTimeout,
    int? pythonMemory,
    int? cppTimeout,
    int? cppMemory,
    int? javaTimeout,
    int? javaMemory,
    int? webTimeout,
    int? webMemory,
  }) =>
      AdminInfraConfig(
        aiProvider: aiProvider ?? this.aiProvider,
        aiEnabled: aiEnabled ?? this.aiEnabled,
        compilerEnabled: compilerEnabled ?? this.compilerEnabled,
        pythonTimeout: pythonTimeout ?? this.pythonTimeout,
        pythonMemory: pythonMemory ?? this.pythonMemory,
        cppTimeout: cppTimeout ?? this.cppTimeout,
        cppMemory: cppMemory ?? this.cppMemory,
        javaTimeout: javaTimeout ?? this.javaTimeout,
        javaMemory: javaMemory ?? this.javaMemory,
        webTimeout: webTimeout ?? this.webTimeout,
        webMemory: webMemory ?? this.webMemory,
      );
}

class AdminQuestion {
  final String id;
  final String type;
  final String title;
  final String difficulty;
  final String topic;
  final String details;
  final String boilerplate;
  final bool published;

  const AdminQuestion({
    required this.id,
    required this.type,
    required this.title,
    required this.difficulty,
    required this.topic,
    required this.details,
    required this.boilerplate,
    required this.published,
  });

  factory AdminQuestion.fromJson(Map<String, dynamic> json) => AdminQuestion(
        id: '${json['id'] ?? ''}',
        type: '${json['type'] ?? 'coding'}',
        title: '${json['title'] ?? ''}',
        difficulty: '${json['difficulty'] ?? 'Medium'}',
        topic: '${json['topic'] ?? 'General'}',
        details: '${json['details'] ?? ''}',
        boilerplate: '${json['boilerplate'] ?? ''}',
        published: json['published'] == true,
      );
}

class AdminPortalCode {
  final String code;
  final String tenantId;
  final String tenantName;
  final int maxUses;
  final int used;
  final String expiresAt;
  final bool active;

  const AdminPortalCode({
    required this.code,
    required this.tenantId,
    required this.tenantName,
    required this.maxUses,
    required this.used,
    required this.expiresAt,
    required this.active,
  });

  factory AdminPortalCode.fromJson(Map<String, dynamic> json) =>
      AdminPortalCode(
        code: '${json['code'] ?? ''}',
        tenantId: '${json['tenant_id'] ?? ''}',
        tenantName: '${json['tenant_name'] ?? ''}',
        maxUses: _asInt(json['max_uses'], fallback: 1),
        used: _asInt(json['used']),
        expiresAt: '${json['expires_at'] ?? ''}',
        active: json['active'] != false,
      );
}

int _asInt(dynamic value, {int fallback = 0}) {
  if (value is int) return value;
  return int.tryParse('$value') ?? fallback;
}

double _asDouble(dynamic value, {double fallback = 0}) {
  if (value is num) return value.toDouble();
  return double.tryParse('$value') ?? fallback;
}
