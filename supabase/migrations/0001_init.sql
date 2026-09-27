-- Sahakara (Housemaid Management App) — initial schema
-- 21 tables in 6 groups: users & households, tasks, rewards, attendance & leave,
-- payments, household & admin. See docs/database-tables.md for the source spec.
--
-- Design rules (keep these in mind when writing app code, not enforced by SQL):
--   1. Never UPDATE or DELETE ledger_entries rows — fix mistakes with a
--      `correction` entry so payment history stays trustworthy.
--   2. On a pay raise, set end_date on the old contract and INSERT a new one
--      rather than editing rate in place, so past months keep the old rate.
--   3. Tasks/attendance/pay all reference a household_members row, not a user
--      directly, so one maid can work across several households.

create extension if not exists "pgcrypto";

-- ── enums ────────────────────────────────────────────────────────────────

create type app_language as enum ('si', 'ta', 'en');
create type member_role as enum ('owner', 'adult', 'maid', 'driver', 'cook', 'gardener');
create type pay_type as enum ('monthly', 'daily', 'hourly', 'per_visit');
create type task_category as enum ('kitchen', 'cleaning', 'laundry', 'cooking', 'other');
create type recurrence_type as enum ('once', 'daily', 'weekly', 'fortnightly', 'monthly', 'quarterly');
create type task_priority as enum ('high', 'medium', 'low');
create type task_status as enum ('pending', 'started', 'done', 'need_help', 'cant_do', 'carried_forward');
create type cant_do_reason as enum ('no_supplies', 'power_cut', 'water_cut', 'sick', 'no_time', 'other');
create type task_log_action as enum ('started', 'done', 'help', 'cant_do');
create type badge_type as enum ('six_months', 'one_year', 'perfect_month');
create type attendance_day_type as enum ('full', 'half', 'late', 'early_leave', 'leave', 'absent', 'holiday');
create type leave_type as enum ('paid', 'unpaid', 'sick');
create type leave_status as enum ('pending', 'approved', 'rejected');
create type holiday_type as enum ('poya', 'public', 'festival');
create type ledger_entry_type as enum ('salary', 'payment', 'advance', 'advance_repay', 'bonus', 'deduction', 'overtime', 'correction');
create type payment_method as enum ('cash', 'bank', 'mobile_wallet');
create type dispute_status as enum ('open', 'resolved');
create type shopping_status as enum ('needed', 'bought');
create type document_type as enum ('nic', 'agency', 'contract', 'other');
create type subscription_plan as enum ('free', 'basic', 'premium');

-- ── users & households ──────────────────────────────────────────────────

create table users (
  id uuid primary key default gen_random_uuid(),
  auth_user_id uuid unique references auth.users (id) on delete cascade,
  phone varchar unique not null,
  name varchar not null,
  language app_language not null default 'en',
  profile_photo varchar,
  created_at timestamptz not null default now()
);

create table households (
  id uuid primary key default gen_random_uuid(),
  name varchar not null,
  address varchar,
  owner_id uuid not null references users (id),
  created_at timestamptz not null default now()
);

create table household_members (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references households (id) on delete cascade,
  user_id uuid not null references users (id),
  role member_role not null,
  active boolean not null default true,
  joined_on date not null default current_date,
  unique (household_id, user_id)
);

create table contracts (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  pay_type pay_type not null,
  rate decimal(12, 2) not null,
  off_days varchar,
  working_hours varchar,
  scope text,
  start_date date not null default current_date,
  end_date date,
  created_at timestamptz not null default now()
);

-- ── tasks ────────────────────────────────────────────────────────────────

create table task_library (
  id uuid primary key default gen_random_uuid(),
  category task_category not null default 'other',
  name_en varchar not null,
  name_si varchar,
  name_ta varchar,
  image_url varchar,
  audio_si varchar,
  audio_ta varchar,
  audio_en varchar
);

create table task_templates (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references households (id) on delete cascade,
  library_id uuid references task_library (id),
  custom_title varchar,
  photo_url varchar,
  done_photo_url varchar,
  recurrence recurrence_type not null default 'once',
  recurrence_day varchar,
  est_minutes int,
  priority task_priority not null default 'medium',
  needs_photo_proof boolean not null default false,
  created_by uuid not null references users (id),
  active boolean not null default true,
  check (library_id is not null or custom_title is not null)
);

create table tasks (
  id uuid primary key default gen_random_uuid(),
  template_id uuid not null references task_templates (id) on delete cascade,
  assigned_to uuid not null references household_members (id),
  due_date date not null,
  sort_order int not null default 0,
  status task_status not null default 'pending',
  cant_do_reason cant_do_reason,
  completed_at timestamptz
);

create table task_logs (
  id uuid primary key default gen_random_uuid(),
  task_id uuid not null references tasks (id) on delete cascade,
  action task_log_action not null,
  proof_photo varchar,
  by_user uuid not null references users (id),
  at timestamptz not null default now()
);

-- ── rewards (positive only — no penalty/demerit table) ─────────────────

create table stars (
  id uuid primary key default gen_random_uuid(),
  task_id uuid references tasks (id) on delete set null,
  member_id uuid not null references household_members (id) on delete cascade,
  given_by uuid not null references users (id),
  voice_note varchar,
  note text,
  at timestamptz not null default now()
);

create table badges (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  badge_type badge_type not null,
  earned_on date not null default current_date
);

-- ── attendance & leave ───────────────────────────────────────────────────

create table attendance (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  day date not null,
  check_in timestamptz,
  check_out timestamptz,
  day_type attendance_day_type not null,
  overtime_hours decimal(4, 2) not null default 0,
  note text,
  unique (member_id, day)
);

create table leave_requests (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  from_date date not null,
  to_date date not null,
  leave_type leave_type not null,
  reason text,
  voice_note varchar,
  status leave_status not null default 'pending',
  decided_by uuid references users (id),
  created_at timestamptz not null default now(),
  check (to_date >= from_date)
);

create table holidays (
  id uuid primary key default gen_random_uuid(),
  date date not null,
  name_en varchar not null,
  name_si varchar,
  name_ta varchar,
  type holiday_type not null
);

-- ── payments ─────────────────────────────────────────────────────────────

create table advances (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  amount decimal(12, 2) not null,
  remaining decimal(12, 2) not null,
  given_on date not null default current_date,
  note text,
  created_by uuid not null references users (id),
  at timestamptz not null default now()
);

-- Every money movement is one row here. Balance due = sum of rows for a
-- member. Never UPDATE/DELETE a row — add a `correction` entry instead.
create table ledger_entries (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  entry_type ledger_entry_type not null,
  amount decimal(12, 2) not null,
  method payment_method,
  note text,
  advance_id uuid references advances (id),
  month varchar not null,
  created_by uuid not null references users (id),
  at timestamptz not null default now(),
  check (entry_type <> 'deduction' or note is not null)
);

create table payslips (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  month varchar not null,
  days_worked int not null default 0,
  total_earned decimal(12, 2) not null default 0,
  total_deductions decimal(12, 2) not null default 0,
  total_paid decimal(12, 2) not null default 0,
  balance decimal(12, 2) not null default 0,
  language app_language not null default 'en',
  pdf_url varchar,
  unique (member_id, month)
);

create table disputes (
  id uuid primary key default gen_random_uuid(),
  raised_by uuid not null references users (id),
  ledger_id uuid references ledger_entries (id),
  attendance_id uuid references attendance (id),
  message text not null,
  status dispute_status not null default 'open',
  resolved_note text,
  created_at timestamptz not null default now()
);

-- ── household & admin ────────────────────────────────────────────────────

create table messages (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references households (id) on delete cascade,
  from_user uuid not null references users (id),
  to_user uuid not null references users (id),
  text text,
  voice_url varchar,
  read boolean not null default false,
  at timestamptz not null default now(),
  check (text is not null or voice_url is not null)
);

create table shopping_items (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references households (id) on delete cascade,
  item varchar not null,
  added_by uuid not null references users (id),
  status shopping_status not null default 'needed',
  at timestamptz not null default now()
);

create table documents (
  id uuid primary key default gen_random_uuid(),
  member_id uuid not null references household_members (id) on delete cascade,
  doc_type document_type not null,
  file_url varchar not null,
  uploaded_at timestamptz not null default now()
);

create table subscriptions (
  id uuid primary key default gen_random_uuid(),
  household_id uuid not null references households (id) on delete cascade,
  plan subscription_plan not null default 'free',
  paid_until date,
  payment_ref varchar
);

-- ── helpful indexes ──────────────────────────────────────────────────────

create index idx_household_members_household on household_members (household_id);
create index idx_household_members_user on household_members (user_id);
create index idx_contracts_member on contracts (member_id) where end_date is null;
create index idx_task_templates_household on task_templates (household_id);
create index idx_tasks_assigned_due on tasks (assigned_to, due_date);
create index idx_attendance_member_day on attendance (member_id, day);
create index idx_ledger_member_month on ledger_entries (member_id, month);
create index idx_messages_household on messages (household_id, at);
