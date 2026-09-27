# Sahakara — Flutter app

One Flutter codebase, two front doors:

- **Mobile** (Android/iOS) — the owner and maid experience: phone OTP login,
  household setup, contracts, the task library.
- **Web** (`flutter run -d chrome`) — the staff admin panel: manage the
  shared task library and holiday calendar, see all households.

`lib/main.dart` picks between them with `kIsWeb` — there's no separate
project to maintain.

## 1. Set up Supabase first

This app has no backend of its own — see [`../supabase/README.md`](../supabase/README.md)
to create a Supabase project and run the schema. You need its **Project URL**
and **anon/publishable key** before the app will do anything useful.

## 2. Configure credentials

```bash
cp env.example.json env.json
```

Fill in `env.json` with your Supabase URL and anon key (it's gitignored —
never commit it).

## 3. Run it

Mobile, on a simulator/emulator or a connected device:

```bash
flutter run --dart-define-from-file=env.json
```

Admin panel, in a browser:

```bash
flutter run -d chrome --dart-define-from-file=env.json
```

Then sign in with a staff account (see step 5 of the Supabase README to
create one).

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
  core/            Supabase client, env config, i18n strings, theme
  mobile_app.dart  Routes signed-out -> login, no household -> setup, else -> home
  features/
    auth/          Phone OTP login
    onboarding/    First-run household creation
    home/          Bottom-nav shell + household tab
    contract/      View/edit a household member's contract
    tasks/         Read-only task library browser
    settings/      Language switch, sign out
    admin/         Web-only staff panel (households, task library, holidays)
```

## What's here vs. what's next

This covers the **Sprint 1 basics** from the project plan: phone OTP login,
per-user language (Sinhala/Tamil/English), household creation, adding a maid
by phone, contracts, and browsing the task library. Sprints 2–5 (daily task
assignment, attendance, payroll, rewards, offline sync, notifications) build
on top of this schema and structure but aren't implemented yet.
