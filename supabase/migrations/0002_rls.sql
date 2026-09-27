-- Row-level security: every household's data is only visible to the people
-- in that household (Sprint 1: "owner and maid see different screens;
-- Supabase row-level security per household").
--
-- This is a starting-point policy set covering the MVP basics, not a full
-- production hardening pass — revisit as each sprint's features land.

-- ── helpers ──────────────────────────────────────────────────────────────

-- Maps the logged-in auth user to their row in `users`.
create or replace function app_user_id()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select id from users where auth_user_id = auth.uid();
$$;

-- True if the current user has an active membership in the household.
create or replace function is_household_member(target_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from household_members hm
    where hm.household_id = target_household_id
      and hm.user_id = app_user_id()
      and hm.active
  );
$$;

-- True if the current user owns the household.
create or replace function is_household_owner(target_household_id uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from households h
    where h.id = target_household_id
      and h.owner_id = app_user_id()
  );
$$;

-- Household a membership row belongs to (for policies keyed off member_id).
create or replace function household_of_member(target_member_id uuid)
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select household_id from household_members where id = target_member_id;
$$;

-- ── enable RLS ───────────────────────────────────────────────────────────

alter table users enable row level security;
alter table households enable row level security;
alter table household_members enable row level security;
alter table contracts enable row level security;
alter table task_library enable row level security;
alter table task_templates enable row level security;
alter table tasks enable row level security;
alter table task_logs enable row level security;
alter table stars enable row level security;
alter table badges enable row level security;
alter table attendance enable row level security;
alter table leave_requests enable row level security;
alter table holidays enable row level security;
alter table ledger_entries enable row level security;
alter table advances enable row level security;
alter table payslips enable row level security;
alter table disputes enable row level security;
alter table messages enable row level security;
alter table shopping_items enable row level security;
alter table documents enable row level security;
alter table subscriptions enable row level security;

-- ── users ────────────────────────────────────────────────────────────────

create policy "users can view themselves" on users
  for select using (auth_user_id = auth.uid());

-- Lets a freshly signed-in phone see its own not-yet-claimed invited row
-- (see the claim policy below), instead of RLS hiding it and the app
-- creating a duplicate.
create policy "signed-in user can see their own unclaimed invited row" on users
  for select using (auth_user_id is null and phone = (auth.jwt() ->> 'phone'));

create policy "users can view household co-members" on users
  for select using (
    exists (
      select 1 from household_members mine
      join household_members theirs on theirs.household_id = mine.household_id
      where mine.user_id = app_user_id() and theirs.user_id = users.id
    )
  );

create policy "users can update themselves" on users
  for update using (auth_user_id = auth.uid());

-- A household owner can invite a maid by phone before she has ever signed
-- in (auth_user_id stays null until her first OTP login claims the row —
-- see the next policy). Claiming her own row is handled below, not here.
create policy "invited user can claim their profile on first login" on users
  for update using (auth_user_id is null and phone = (auth.jwt() ->> 'phone'))
  with check (auth_user_id = auth.uid());

create policy "anyone signed in can create their own user row" on users
  for insert with check (auth_user_id = auth.uid());

create policy "signed-in users can pre-create an invited user's row" on users
  for insert with check (auth_user_id is null);

-- ── households & membership ─────────────────────────────────────────────

create policy "members can view their households" on households
  for select using (is_household_member(id));

create policy "signed-in users can create a household" on households
  for insert with check (owner_id = app_user_id());

create policy "owner can update their household" on households
  for update using (owner_id = app_user_id());

create policy "members can view household membership" on household_members
  for select using (is_household_member(household_id));

create policy "owner manages membership" on household_members
  for all using (is_household_owner(household_id))
  with check (is_household_owner(household_id));

-- ── contracts ────────────────────────────────────────────────────────────

create policy "members can view contracts in their household" on contracts
  for select using (is_household_member(household_of_member(member_id)));

create policy "owner manages contracts" on contracts
  for all using (is_household_owner(household_of_member(member_id)))
  with check (is_household_owner(household_of_member(member_id)));

-- ── task library (shared, admin-curated) ────────────────────────────────

create policy "anyone signed in can read the task library" on task_library
  for select using (auth.uid() is not null);

-- Writes to task_library are done via the service role from the admin panel
-- (no insert/update/delete policy for regular users).

-- ── task templates & daily tasks ────────────────────────────────────────

create policy "members can view task templates" on task_templates
  for select using (is_household_member(household_id));

create policy "owner manages task templates" on task_templates
  for all using (is_household_owner(household_id))
  with check (is_household_owner(household_id));

create policy "members can view tasks in their household" on tasks
  for select using (is_household_member(household_of_member(assigned_to)));

create policy "owner manages tasks" on tasks
  for insert with check (is_household_owner(household_of_member(assigned_to)));

create policy "owner updates tasks" on tasks
  for update using (is_household_owner(household_of_member(assigned_to)));

create policy "assigned member updates their own task" on tasks
  for update using (
    exists (
      select 1 from household_members hm
      where hm.id = tasks.assigned_to and hm.user_id = app_user_id()
    )
  );

create policy "members can view task logs" on task_logs
  for select using (
    is_household_member(household_of_member((select assigned_to from tasks where id = task_id)))
  );

create policy "members can create task logs for their household" on task_logs
  for insert with check (
    is_household_member(household_of_member((select assigned_to from tasks where id = task_id)))
  );

-- ── rewards ──────────────────────────────────────────────────────────────

create policy "members can view stars in their household" on stars
  for select using (is_household_member(household_of_member(member_id)));

create policy "owner gives stars" on stars
  for insert with check (is_household_owner(household_of_member(member_id)));

create policy "members can view badges in their household" on badges
  for select using (is_household_member(household_of_member(member_id)));

-- ── attendance & leave ───────────────────────────────────────────────────

create policy "members can view attendance in their household" on attendance
  for select using (is_household_member(household_of_member(member_id)));

create policy "household can record attendance" on attendance
  for insert with check (is_household_member(household_of_member(member_id)));

create policy "household can amend attendance" on attendance
  for update using (is_household_member(household_of_member(member_id)));

create policy "members can view leave requests in their household" on leave_requests
  for select using (is_household_member(household_of_member(member_id)));

create policy "maid requests leave" on leave_requests
  for insert with check (
    exists (
      select 1 from household_members hm
      where hm.id = member_id and hm.user_id = app_user_id()
    )
  );

create policy "owner approves leave" on leave_requests
  for update using (is_household_owner(household_of_member(member_id)));

-- ── holidays (global, admin-curated) ────────────────────────────────────

create policy "anyone signed in can read holidays" on holidays
  for select using (auth.uid() is not null);

-- ── payments ─────────────────────────────────────────────────────────────

create policy "members can view ledger entries in their household" on ledger_entries
  for select using (is_household_member(household_of_member(member_id)));

create policy "owner records ledger entries" on ledger_entries
  for insert with check (is_household_owner(household_of_member(member_id)));

-- No update/delete policy on purpose: ledger rows are append-only. Mistakes
-- are fixed with a `correction` entry_type row, never an UPDATE/DELETE.

create policy "members can view advances in their household" on advances
  for select using (is_household_member(household_of_member(member_id)));

create policy "owner manages advances" on advances
  for all using (is_household_owner(household_of_member(member_id)))
  with check (is_household_owner(household_of_member(member_id)));

create policy "members can view payslips in their household" on payslips
  for select using (is_household_member(household_of_member(member_id)));

create policy "members can view disputes in their household" on disputes
  for select using (
    (ledger_id is not null and is_household_member(household_of_member((select member_id from ledger_entries where id = ledger_id))))
    or (attendance_id is not null and is_household_member(household_of_member((select member_id from attendance where id = attendance_id))))
  );

create policy "household members raise disputes" on disputes
  for insert with check (raised_by = app_user_id());

create policy "owner resolves disputes" on disputes
  for update using (
    (ledger_id is not null and is_household_owner(household_of_member((select member_id from ledger_entries where id = ledger_id))))
    or (attendance_id is not null and is_household_owner(household_of_member((select member_id from attendance where id = attendance_id))))
  );

-- ── household & admin ────────────────────────────────────────────────────

create policy "members can view messages in their household" on messages
  for select using (is_household_member(household_id));

create policy "members can send messages in their household" on messages
  for insert with check (is_household_member(household_id) and from_user = app_user_id());

create policy "recipient can mark messages read" on messages
  for update using (to_user = app_user_id());

create policy "members can view shopping list" on shopping_items
  for select using (is_household_member(household_id));

create policy "members can manage shopping list" on shopping_items
  for all using (is_household_member(household_id))
  with check (is_household_member(household_id));

create policy "members can view documents in their household" on documents
  for select using (is_household_member(household_of_member(member_id)));

create policy "owner manages documents" on documents
  for all using (is_household_owner(household_of_member(member_id)))
  with check (is_household_owner(household_of_member(member_id)));

create policy "owner views their subscription" on subscriptions
  for select using (is_household_owner(household_id));
