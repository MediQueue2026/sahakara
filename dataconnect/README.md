# Firebase backend (Data Connect + Auth)

The app has no custom server. Firebase is the backend:

- **Firebase Data Connect**: a PostgreSQL database (Cloud SQL) that you
  define in GraphQL and that the app reaches through generated, typed Dart code.
- **Firebase Auth**: email/password for owners, maids and staff using the
  admin panel (no email verification).

```
dataconnect/
  dataconnect.yaml        Service config: region, Cloud SQL instance
  schema/schema.gql       All 21 tables + enums (becomes the Postgres schema)
  connector/
    connector.yaml        Generates the Dart SDK into app/lib/dataconnect_generated
    queries.gql           Every read the app can do, with its access rule
    mutations.gql         Every write the app can do, with its access rule
  seed_data.gql           Starter trilingual task library (run manually)
```

## How access control works

Clients can only run the named operations in `connector/`, not arbitrary
queries. Each operation is its own access rule:

- `@auth(level: USER)` means only a signed-in user can call it.
- `where` filters built on `auth.uid` limit rows to the caller's own
  household. For example, `HouseholdMembers` returns nothing unless the
  caller is an active member of that household.
- Owner-only writes (`SaveContract`, `AddHouseholdMember`, …) are
  `@transaction`s. Their first step is a `@check` that the caller owns the
  household, so the write never happens if the check fails.
- Admin operations use `@auth(expr: "auth.token.is_staff == true")`.

Adding a feature means adding an operation to `connector/` and then
regenerating the SDK (see below).

## Local development (no cloud project needed)

From the repo root:

```bash
firebase emulators:start
```

This runs the Auth and Data Connect emulators. The UI is at
http://localhost:4000, where you can see the accounts that have signed up.
Load the starter tasks by opening `seed_data.gql` in VS Code
(Firebase Data Connect extension) and clicking **Run (local)**.

Then run the app with `USE_EMULATORS` set (see `app/README.md`).

## After changing the schema or operations

```bash
firebase dataconnect:sdk:generate
```

This validates everything and rewrites `app/lib/dataconnect_generated/`.
Never edit the generated code by hand. The VS Code extension also
regenerates automatically on save while the emulator is running.

## Deploying to the real project (`sahakara-f78dd`)

1. **Blaze plan.** Data Connect runs on Cloud SQL, which needs billing
   enabled (Firebase console → Upgrade). New projects get a free Cloud SQL
   trial.
2. **Enable Auth providers.** In Firebase console → Authentication → Sign-in
   method, turn on **Email/Password**.
3. **Deploy the schema and connector:**

   ```bash
   firebase deploy --only dataconnect
   ```

   The first deploy creates the Cloud SQL instance and database named in
   `dataconnect.yaml` (region `asia-southeast1`) and migrates the schema.
4. **Seed** by opening `seed_data.gql` and clicking **Run (production)**.

## Creating a staff (admin panel) account

The admin panel is for your own team, not a household. It signs in with an
email/password account that has the `is_staff` custom claim.

1. Firebase console → Authentication → Users → **Add user**, with an email
   and password.
2. Set the claim with the Admin SDK. Custom claims can't be set from the
   console. Download a service-account key (Project settings → Service
   accounts), then:

   ```bash
   npm install firebase-admin
   GOOGLE_APPLICATION_CREDENTIALS=key.json node -e "
     const admin = require('firebase-admin');
     admin.initializeApp();
     admin.auth().getUserByEmail('you@example.com')
       .then(u => admin.auth().setCustomUserClaims(u.uid, { is_staff: true }))
       .then(() => console.log('done'));
   "
   ```

   Never commit the key file.
3. Sign in to the admin panel with that email and password.

## Design rules (keep following these)

- **Ledger rows are append-only.** No operation updates or deletes a
  `LedgerEntry`. Fix mistakes with a new `correction` entry so payment
  history stays trustworthy.
- **Contracts don't get edited for a raise.** `SaveContract` sets `endDate`
  on the old contract and inserts a new one, so past months still calculate
  at the old rate.
- **Everything hangs off `HouseholdMember`, not `User`,** for tasks,
  attendance and pay. That's what lets one maid work across several
  households (Phase 3).
