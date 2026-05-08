-- Run in Supabase SQL editor after creating storage buckets in UI:
-- 1) verification-docs (public)
-- 2) intro-videos (public)
-- 3) report-attachments (public)

-- Restrict upload path to authenticated users.

drop policy if exists verification_upload_auth on storage.objects;
create policy verification_upload_auth
on storage.objects
for insert
to authenticated
with check (bucket_id = 'verification-docs');

drop policy if exists intro_upload_auth on storage.objects;
create policy intro_upload_auth
on storage.objects
for insert
to authenticated
with check (bucket_id = 'intro-videos');

drop policy if exists report_upload_auth on storage.objects;
create policy report_upload_auth
on storage.objects
for insert
to authenticated
with check (bucket_id = 'report-attachments');

drop policy if exists verification_read_auth on storage.objects;
create policy verification_read_auth
on storage.objects
for select
to authenticated
using (bucket_id = 'verification-docs');

drop policy if exists intro_read_auth on storage.objects;
create policy intro_read_auth
on storage.objects
for select
to authenticated
using (bucket_id = 'intro-videos');

drop policy if exists report_read_auth on storage.objects;
create policy report_read_auth
on storage.objects
for select
to authenticated
using (bucket_id = 'report-attachments');
