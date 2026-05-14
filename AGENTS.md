# Agent guide — weather_app

This document orients automated assistants and contributors to the Flutter codebase layout and conventions.

## Stack

- **Flutter** (see `pubspec.yaml` for pinned SDK / Flutter versions).
- **State**: `bloc` / `flutter_bloc`, `hooked_bloc`, `flutter_hooks`.
- **DI**: `get_it` + `injectable` (`lib/injectable/`).
- **HTTP**: `dio` + `retrofit` (API clients in `lib/data/**/data_source/`).
- **Routing**: `go_router` (`lib/presentation/router/`).
- **Logging**: `fimber_io`.
- **i18n**: `intl` / `intl_utils` — generated `Strings` in `lib/generated/l10n.dart` (do not hand-edit generated intl files under `lib/generated/`).

## Architecture (high level)

Clean-style layering with **package imports** only (`always_use_package_imports` in `analysis_options.yaml`).

| Layer | Path | Responsibility |
|--------|------|------------------|
| **Domain** | `lib/domain/` | `abstract interface class` contracts (`*Service`, `*UseCase`, stores), domain models under `model/`, no Flutter UI imports. |
| **Data** | `lib/data/` | Implementations (`*Impl`), DTOs (`*_dto.dart`), Retrofit data sources, `store` / `data_source` for persistence and APIs. Map DTO → domain in data layer (e.g. `toDomain()` on DTOs). |
| **Presentation** | `lib/presentation/` | Pages, cubits, widgets, router. Cubits depend on domain use cases / services via constructor injection. |

Supporting code: `lib/style/`, `lib/utils/`, `lib/extensions/`, `lib/networking_config/`.

## Dependency injection

- Entry: `lib/injectable/injectable.dart` — `configureDependencies(environment)` calls generated `$initGetIt`.
- Generated registration: `lib/injectable/injectable.config.dart` (**generated** — run codegen after changing `@injectable` / `@LazySingleton` / etc.).
- Environments: `Environment` from injectable, plus `StagingEnvironment` where used (`lib/main.dart`).
- Tests: `registerOverride<T>` in `injectable.dart` swaps implementations for mocks.

## Code generation

Regenerate when changing:

- `@JsonSerializable` / `json_annotation` models (`*.g.dart`),
- `retrofit` clients (`*.g.dart` on data sources),
- `injectable` registrations (`injectable.config.dart`),
- Mockito `@GenerateMocks` (`*.mocks.dart` in tests).

Typical command (from project root):

```bash
dart run build_runner build --delete-conflicting-outputs
```

Strings / ARB: follow existing `flutter_intl` / `intl_utils` project config in `pubspec.yaml`.

## Tests

- **Unit**: `test/unit_tests/` mirrors `lib/` (domain, data, presentation cubits, interceptors).
- **Widget**: `test/widget_tests/` with shared bootstrap under `test/widget_tests/utils/`.
- **Integration**: `integration_test/`.
- Mocks: `mockito` with `@GenerateMocks([...])` and `*.mocks.dart` imports; generated mocks are excluded from analyzer edits in `analysis_options.yaml`.

## Linting and style

`analysis_options.yaml` enables strict analyzer modes and many lints (single quotes, trailing commas, `prefer_expression_function_bodies`, etc.). Prefer matching existing file patterns over fighting the linter.

## Generated / hands-off files

Do not manually edit (regenerate instead): `*.g.dart`, `*.mocks.dart`, `lib/generated/**`, `lib/injectable/injectable.config.dart` (unless fixing a one-off merge — prefer codegen).

## Useful entrypoints

- App widget: `lib/weather_app.dart`
- `main.dart`: environment resolution, `configureDependencies`, `runApp`
- Routes enum / paths: `lib/presentation/router/weather_app_routes.dart`

For Cursor-specific agent rules, see `.cursor/rules/*.mdc`.
