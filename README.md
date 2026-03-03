# AutoHub Express

**Auto Parts, Recycling & More** — Mobile app for [autohub.express](https://autohub.express)

## Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter 3.29.2 / Dart 3.7.2 |
| State Management | BLoC |
| DI | get_it + injectable |
| Navigation | go_router |
| Networking | Dio |
| Serialization | freezed + json_serializable |
| Error Handling | fpdart (Either pattern) |
| Linting | very_good_analysis |

## Architecture

Feature-first Clean Architecture — `Presentation → Domain ← Data`

```
lib/
├── core/          # constants, errors, extensions, router, theme, utils
├── features/      # 16 feature modules (see below)
├── shared/        # reusable widgets & services
├── injection.dart # DI setup
└── main.dart      # app entry point
```

## Features

| Module | Scope |
|---|---|
| `splash` | Splash screen, onboarding carousel |
| `auth` | Login, sign up, social auth, guest, biometric |
| `home` | Banners, categories, featured products |
| `search` | YMM / VIN / keyword search, filters |
| `product` | Gallery, pricing, compatibility, reviews |
| `cart` | Cart, checkout, payment |
| `orders` | Order tracking, history, reorder |
| `junk_car` | Vehicle buyback form |
| `premium_club` | Membership, exclusive discounts |
| `blog` | Articles, search, share |
| `contact` | Contact form, FAQ, live chat |
| `services` | Recycling, salvage, inspection info |
| `notifications` | Push notifications, preferences |
| `garage` | Saved vehicles (YMM / VIN) |
| `about` | Company info, trust badges |
| `legal` | Terms, privacy, shipping, refund policies |

## Platform Config

- **Android**: `com.autohubexpress.app` · minSdk 24
- **iOS**: `com.autohubexpress.app` · min iOS 15.0 · portrait only

## Getting Started

```bash
cd auto_hub_app
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Git Workflow

- Branch naming: `feature/`, `fix/`, `chore/`, `refactor/`
- Commits: Conventional Commits (`feat:`, `fix:`, `chore:`)
- No direct pushes to `main`

---

© 2026 AutoHub Express · [hello@autohub.express](mailto:hello@autohub.express) · +1 (609) 758 1919
