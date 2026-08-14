# AGENTS

Guidance for AI coding agents in this Flutter repository.

## Scope
- Keep changes small and localized.
- Prefer updating existing files over adding new abstractions.
- Run validation after edits: `flutter analyze` and targeted `flutter test`.

## Project Map
- Entry point: [lib/main.dart](lib/main.dart)
- Task feature root: [lib/features/tasks](lib/features/tasks)
- State source of truth: [lib/features/tasks/presentation/providers/todo_provider.dart](lib/features/tasks/presentation/providers/todo_provider.dart)
- Data model: [lib/features/tasks/data/models/todo_model.dart](lib/features/tasks/data/models/todo_model.dart)
- Current high-level docs: [README.md](README.md)

## Build And Test Commands
- `flutter pub get`
- `flutter run`
- `flutter analyze`
- `flutter test`
- `dart run flutter_launcher_icons`

## Conventions To Preserve
- State management uses `provider` (`context.watch` for reads, `context.read` for actions).
- Todos are persisted as JSON in SharedPreferences key `saved_todos`.
- Priority values are string-based: `All`, `Low`, `Medium`, `High`.

## Theme And Color Rules (Important)
When implementing or refactoring UI colors, centralize colors into one file:
- Create/use [lib/core/theme/app_color.dart](lib/core/theme/app_color.dart).
- Define one class (`AppColor` or `AppColors`) with semantic tokens, not raw widget-specific names.
- Keep both light and dark mode colors in this same file.
- Do not scatter hex values across widgets; replace direct literals with tokens from `app_color.dart`.

Recommended structure for [lib/core/theme/app_color.dart](lib/core/theme/app_color.dart):
- `static const` shared brand/accent colors.
- `static const` light palette tokens (background, surface, textPrimary, textSecondary, border, success, warning, error).
- `static const` dark palette tokens with the same semantic token names.
- Optional helpers returning token sets by brightness.

## Known Pitfalls
- App theme exists, but many widgets still use hardcoded colors; global ThemeData may appear ineffective.
- [lib/features/tasks/presentation/widgets/dialogs/setting_dialog.dart](lib/features/tasks/presentation/widgets/dialogs/setting_dialog.dart) has appearance UI that is not wired to app-wide theme state.
- [test/widget_test.dart](test/widget_test.dart) is a template test and may not match current app behavior.

## Do Not
- Do not change package IDs or platform metadata unless explicitly requested.
- Do not add routing abstractions unless navigation work is requested.
