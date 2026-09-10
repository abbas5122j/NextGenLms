# Next Gen LMS — Exact Admin UI

This package recreates the Admin screens from the supplied reference screenshots in Flutter.

## Screens
1. Global Analytics
2. Tenant & Client Hub
3. Infra & Compiler
4. Master CMS Bank
5. Portal Code Gen

## Visual contract
- 268px desktop sidebar with the Next Gen LMS logo
- 85px top navigation bar
- Search field, dark-mode button, notifications, System Admin profile
- #F4F6FB page background, white cards, coral/red active state, blue selection rail, green status, purple control buttons
- Rounded cards, compact typography, table layouts, floating Sophia assistant
- Responsive desktop/tablet/mobile layouts

## Install
Copy `lib/admin/` into the project and keep `http` in pubspec.yaml if the Admin API client is used:

```yaml
http: ^1.2.2
```

The screens intentionally contain the reference data shown in the screenshots so the UI is visible even when the microservice gateway is not running. The existing `AdminApiClient` remains included for the backend integration layer.
