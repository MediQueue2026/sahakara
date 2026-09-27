# Supabase backend

This app has no custom server — Supabase *is* the backend (Postgres database,
phone OTP auth, storage, realtime). `migrations/` and `seed/` are plain SQL
you run against your own Supabase project.

## 1. Create a project

1. Go to [supabase.com](https://supabase.com), sign up/in, and click **New project**.
2. Pick an org, name it (e.g. `sahakara`), set a database password (save it),
   and choose a region close to Sri Lanka (e.g. `ap-south-1`).
3. Wait ~2 minutes for it to provision.

## 2. Enable phone OTP login

Project → **Authentication → Sign In / Providers → Phone**. Turn it on and
configure an SMS provider (Twilio, MessageBird, etc. — Supabase needs one of
these to actually send OTP codes; pick any, you can start with a trial
account for development).

## 3. Run the schema

Project → **SQL Editor → New query**. Paste and run, in order:

1. `migrations/0001_init.sql` — all 21 tables.
2. `migrations/0002_rls.sql` — row-level security so each household only
   sees its own data.
3. `migrations/0003_admin_policies.sql` — lets staff accounts (the admin
   panel) curate `task_library` and `holidays`, and view all households.
4. `seed/task_library.sql` — a starter set of trilingual tasks.

(If you install the [Supabase CLI](https://supabase.com/docs/guides/cli)
later, `supabase db push` will run everything in `migrations/` for you
instead of pasting it manually.)

## 4. Get your API keys

Project → **Settings → API**. You need:

- **Project URL** (`https://xxxx.supabase.co`)
- **anon public key**

Put these in:

- `mobile/.env` (copy from `mobile/.env.example`)
- `admin/.env` (copy from `admin/.env.example`)

Never commit `.env` files or the **service_role** key — the service role key
bypasses row-level security entirely and belongs only in server-side/admin
tooling you fully trust, never in the mobile app or the browser.

## 5. Create an admin-panel (staff) login

The admin panel (`admin/`) is for your own team, not a household, so it signs
in with a plain email/password Supabase auth user rather than phone OTP.

1. Project → **Authentication → Users → Add user** — create one with an
   email and password for yourself.
2. Mark it as staff so the RLS policies in `0003_admin_policies.sql` let it
   manage `task_library` and `holidays`. Run in the SQL Editor (this needs
   the `service_role`, which the SQL Editor already uses):

   ```sql
   update auth.users
   set raw_app_meta_data = raw_app_meta_data || '{"is_staff": true}'
   where email = 'you@example.com';
   ```

3. Sign in at the admin panel with that email/password.

## Schema overview

21 tables in 6 groups — see [`migrations/0001_init.sql`](migrations/0001_init.sql)
for the exact columns:

| Group | Tables |
|---|---|
| Users & households | `users`, `households`, `household_members`, `contracts` |
| Tasks | `task_library`, `task_templates`, `tasks`, `task_logs` |
| Rewards | `stars`, `badges` |
| Attendance & leave | `attendance`, `leave_requests`, `holidays` |
| Payments | `ledger_entries`, `advances`, `payslips`, `disputes` |
| Household & admin | `messages`, `shopping_items`, `documents`, `subscriptions` |

Design rules baked into the schema (keep following these in app code too):

- **Ledger rows are append-only.** Never `UPDATE`/`DELETE` a `ledger_entries`
  row — fix mistakes with a new `correction` entry so payment history stays
  trustworthy.
- **Contracts don't get edited for a raise.** Set `end_date` on the old
  contract and insert a new one, so past months still calculate at the old
  rate.
- **Everything hangs off `household_members`, not `users`,** for tasks,
  attendance and pay — that's what lets one maid work across several
  households (Phase 3).
