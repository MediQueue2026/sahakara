# Firebase backend (Data Connect + Auth)

The app has no custom server. Firebase is the backend:

- **Firebase Data Connect**: a PostgreSQL database (Cloud SQL) that you
  define in GraphQL and that the app reaches through generated, typed Dart code.
- **Firebase Auth**: email/password for owners, maids and staff using the
  admin panel (no email verification).

```
dataconnect/
  dataconnect.yaml        Service config: region, Cloud SQL instance
  schema/schema.gql       All 23 tables + enums (becomes the Postgres schema)
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
- Every `User` row has an `accountType`: `owner`, `maid` or `admin`. Admin
  operations first `@check` that the caller's row is an `admin`, so a signed-in
  owner or maid calling one gets "Admins only". `CreateMyProfile` refuses
  `admin`, so nobody can sign themselves up as one.

Attendance supports leave requests (including half days), check-in/check-out,
and recorded overtime. Payroll supports dated salary-payment schedules,
marking payments paid, and advance requests with owner approval. Approving an
advance creates its advance and ledger records in one transaction. The owner
sees an in-app reminder on the Pay tab when a scheduled payment is due the
following day; reminders are surfaced while using the app and do not require
push-notification delivery.

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

## Creating an admin (admin panel) account

The admin panel is for your own team, not a household. An admin is a normal
email/password login whose `User` row has `accountType = admin`. That can't
be chosen when signing up in the app, only set in the database.

1. Create the login: Firebase console → Authentication → Users → **Add
   user**, with an email and password. (In the emulator: the Auth tab at
   http://localhost:4000.)
2. Give it the admin role, from the repo root:

   ```bash
   firebase dataconnect:sql:shell
   ```

   ```sql
   -- A new admin (no user row yet). The first admin-panel sign-in links it.
   insert into "user" (email, name, account_type, created_at)
   values ('admin@example.com', 'Admin', 'admin', now());

   -- Or promote an account that already has a row:
   update "user" set account_type = 'admin' where email = 'admin@example.com';
   ```

   Use the email in lower case, the way Firebase Auth stores it.
3. Sign in to the admin panel (`flutter run -d chrome`) with that email and
   password.

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
