# Sahakara — Flutter app

One Flutter codebase, two front doors:

- **Mobile** (Android/iOS) — the owner and maid experience: email sign in /
  sign up, household setup, contracts, the task library.
- **Web** (`flutter run -d chrome`) — the staff admin panel: manage the
  shared task library and holiday calendar, see all households.

`lib/main.dart` picks between them with `kIsWeb` — there's no separate
project to maintain.

## 1. Connect to Firebase

The backend is Firebase Data Connect + Firebase Auth — see
[`../dataconnect/README.md`](../dataconnect/README.md). Generate this app's
Firebase config (once, from this folder):

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=sahakara-f78dd
```

That overwrites the placeholder `lib/firebase_options.dart` and registers the
Android/iOS/web apps in the Firebase project.

## 2. Run it

Against the **local emulators** (no cloud setup needed — start them
with `firebase emulators:start` from the repo root):

```bash
cp env.example.json env.json   # sets USE_EMULATORS=true; gitignored
flutter run --dart-define-from-file=env.json
flutter run -d chrome --dart-define-from-file=env.json   # admin panel
```

Sign up with any email and password — there's no email verification, so
emulator accounts don't need a real inbox. You can see and delete accounts in
the emulator UI (http://localhost:4000 → Authentication). For an admin-panel
login, see "Creating an admin account" in `../dataconnect/README.md`.

Against the **real Firebase project**, just leave out `--dart-define-from-file`.

## Data access

Screens call `AppData` (`lib/core/app_data.dart`), which wraps the typed SDK
generated from `dataconnect/connector/` into `lib/dataconnect_generated/`.
Don't edit the generated folder — change the `.gql` files and run
`firebase dataconnect:sdk:generate` from the repo root.

## Toolchain status

`flutter doctor` on this machine currently shows:

- ✅ Flutter SDK, ✅ Chrome (web) — ready to go for the admin panel.
- ❌ Android SDK — install **Android Studio** to run/build for Android:
  https://developer.android.com/studio (it walks you through installing
  the SDK on first launch).
- ❌ Full Xcode — install **Xcode** from the App Store to run/build for iOS
  (only needed on a Mac, and only for iOS — Android works without it).

Run `flutter doctor` any time to recheck.

## Project layout

```
lib/
  core/            Firebase client, data access, env config, i18n strings, theme
  dataconnect_generated/  Typed Data Connect SDK (generated — don't edit)
  mobile_app.dart  Routes signed-out -> login, no household -> setup, else -> home
  features/
    auth/          Email sign in / sign up
    onboarding/    First-run household creation
    home/          Bottom-nav shell + household tab
    contract/      View/edit a household member's contract
    tasks/         Read-only task library browser
    settings/      Language switch, sign out
    admin/         Web-only staff panel (households, task library, holidays)
```

## What's here vs. what's next

This covers the **Sprint 1 basics** from the project plan: email sign in / sign up,
per-user language (Sinhala/Tamil/English), household creation, adding a maid
by email, contracts, and browsing the task library. Sprints 2–5 (daily task
assignment, attendance, payroll, rewards, offline sync, notifications) build
on top of this schema and structure but aren't implemented yet.
