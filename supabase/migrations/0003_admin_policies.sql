-- The admin web panel is used by your own team (not a household), so it
-- authenticates as a plain Supabase auth user rather than a row in `users`.
-- Mark those accounts with app_metadata.is_staff = true (service-role only,
-- see supabase/README.md) and let them curate the global, admin-owned
-- tables: task_library and holidays.

create or replace function is_staff()
returns boolean
language sql
stable
as $$
  select coalesce((auth.jwt() -> 'app_metadata' ->> 'is_staff')::boolean, false);
$$;

create policy "staff manage the task library" on task_library
  for insert with check (is_staff());

create policy "staff update the task library" on task_library
  for update using (is_staff());

create policy "staff delete from the task library" on task_library
  for delete using (is_staff());

create policy "staff manage holidays" on holidays
  for insert with check (is_staff());

create policy "staff update holidays" on holidays
  for update using (is_staff());

create policy "staff delete holidays" on holidays
  for delete using (is_staff());

-- Read access for the admin panel's overview pages (households, disputes).
create policy "staff can view all households" on households
  for select using (is_staff());

create policy "staff can view all household members" on household_members
  for select using (is_staff());

create policy "staff can view all disputes" on disputes
  for select using (is_staff());

create policy "staff can resolve disputes" on disputes
  for update using (is_staff());
