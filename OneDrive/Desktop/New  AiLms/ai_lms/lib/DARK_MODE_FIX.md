# Admin Dark Mode Fix

This version fixes Admin dark mode end-to-end.

## Replace
Copy `lib/admin/` into your project.

Replace your `lib/screens/auth_wrapper.dart` with the included `auth_wrapper_updated.dart` if you are using the provided Admin role routing.

## Why it was broken
The Admin route was passing `isDarkMode: false` and `onToggleDarkMode: () {}`. The shell therefore could never change mode. The Admin screens also had several hard-coded light surfaces.

## After replacement
Run:
```
flutter clean
flutter pub get
flutter run -d windows
```
Then select **Admin** and use the moon button in the top bar. The sidebar, header, page cards, inputs, tables, badges and content surfaces will switch to the dark palette.
