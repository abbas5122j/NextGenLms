# Admin Dark Mode — End-to-End Fix

The Admin section now has a real theme state and every Admin page reads the active dark flag.

## 1. Copy Admin files
Replace your project's `lib/admin/` with the `lib/admin/` in this package.

## 2. Fix AuthWrapper
Replace your Admin-routing `lib/screens/auth_wrapper.dart` with `auth_wrapper_updated.dart` from this package, or make these two changes:

```dart
bool _adminDarkMode = false;
```

and:

```dart
AdminSectionScreen(
  isDarkMode: _adminDarkMode,
  onToggleDarkMode: () {
    setState(() {
      _adminDarkMode = !_adminDarkMode;
    });
  },
  // ...
)
```

## 3. Clean and run

```bash
flutter clean
flutter pub get
flutter run -d windows
```

## Result

The moon button in the Admin top bar now switches:
- entire Admin background
- sidebar
- top bar
- search field
- active navigation row
- cards/panels
- form inputs
- dropdowns
- tables
- CMS registry
- quota controls
- compiler panels
- portal-code table
- typography/secondary text

The Admin page stays in dark mode while navigating between the five Admin sections.
