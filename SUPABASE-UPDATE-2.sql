-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.
-- Lets the album store collections (folders + a small settings file),
-- album covers, GIFs and videos up to 50 MB.

update storage.buckets
set public = true,
    file_size_limit = 52428800,
    allowed_mime_types = array[
      'image/jpeg','image/png','image/webp','image/gif',
      'video/mp4','video/webm','video/quicktime',
      'application/json'
    ]
where id = 'photos';

-- Needed so a cover photo or album name can be replaced.
create policy "Album: anyone can replace photos"
  on storage.objects for update to anon, authenticated
  using (bucket_id = 'photos')
  with check (bucket_id = 'photos');
