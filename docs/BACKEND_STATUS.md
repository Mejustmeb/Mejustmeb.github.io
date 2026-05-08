# Backend Status

Current mode:
- If `docs/config.js` has Supabase URL + anon key, portal uses Supabase backend.
- If config is empty, portal falls back to local browser storage.

Required files:
- `backend/supabase/schema.sql`
- `backend/supabase/storage.sql`
- `backend/supabase/SETUP.md`
