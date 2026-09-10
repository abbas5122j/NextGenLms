# Build fixes applied

1. Added `AdminGatewayConfig` to `lib/admin/admin_section.dart`, fixing the AuthWrapper error.
2. Fixed `TextEditingController(text=...)` to `TextEditingController(text: ...)` in `admin_infra_screen.dart`.
3. Made `_TenantRow` constructor const so the initial const list compiles.

Your existing AuthWrapper code using:

```dart
final adminApi = AdminGatewayConfig(
  gatewayUrl: 'http://localhost:8080',
).createClient();
```

can remain unchanged.
