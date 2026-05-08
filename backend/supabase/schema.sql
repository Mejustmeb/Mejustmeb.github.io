-- Run in Supabase SQL editor

create table if not exists public.tester_profiles (
  user_id uuid primary key references auth.users(id) on delete cascade,
  user_email text not null,
  role text not null default 'tester' check (role in ('tester', 'programmer', 'other')),
  alias text not null,
  address text not null,
  id_front_url text,
  id_back_url text,
  intro_video_url text,
  recorded_video_captured boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.qa_reports (
  id bigint generated always as identity primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  reporter_email text not null,
  type text not null check (type in ('bug', 'glitch', 'idea', 'comment', 'security')),
  severity text not null check (severity in ('Low', 'Medium', 'High', 'Critical')),
  platform text not null,
  build text not null,
  title text not null,
  description text not null,
  steps text,
  attachment_url text,
  status text not null default 'new',
  created_at timestamptz not null default now()
);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists trg_tester_profiles_updated_at on public.tester_profiles;
create trigger trg_tester_profiles_updated_at
before update on public.tester_profiles
for each row
execute function public.set_updated_at();

alter table public.tester_profiles enable row level security;
alter table public.qa_reports enable row level security;

-- Profiles: testers can read everyone for leaderboard, but only edit their own.
drop policy if exists tester_profiles_select_all on public.tester_profiles;
create policy tester_profiles_select_all
on public.tester_profiles
for select
to authenticated
using (true);

drop policy if exists tester_profiles_insert_own on public.tester_profiles;
create policy tester_profiles_insert_own
on public.tester_profiles
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists tester_profiles_update_own on public.tester_profiles;
create policy tester_profiles_update_own
on public.tester_profiles
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Reports: testers can submit and view report feed.
drop policy if exists qa_reports_select_all on public.qa_reports;
create policy qa_reports_select_all
on public.qa_reports
for select
to authenticated
using (true);

drop policy if exists qa_reports_insert_own on public.qa_reports;
create policy qa_reports_insert_own
on public.qa_reports
for insert
to authenticated
with check (auth.uid() = user_id);
