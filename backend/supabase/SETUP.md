# Free Backend Setup (Supabase)

This uses Supabase free tier only.

## 1) Create Free Project

1. Go to `https://supabase.com/` and create a free project.
2. In `Project Settings > API`, copy:
- Project URL
- anon public key

## 2) Create Tables and Policies

1. Open SQL Editor.
2. Run `backend/supabase/schema.sql`.

## 3) Create Storage Buckets

In Storage create these buckets:
- `verification-docs`
- `intro-videos`
- `report-attachments`

Set each bucket to **Public** for now (quick start).
Then run `backend/supabase/storage.sql`.

## 4) Configure Frontend

Edit `docs/config.js`:
- set `url`
- set `anonKey`
- set `reportEmail`
- set `githubRepo`

## 5) Deploy to GitHub Pages

Push to `main` branch.
The workflow in `.github/workflows/pages.yml` deploys automatically.

## 6) Security Upgrade Recommendation

For production identity verification, move ID/video buckets to private and use signed URLs from a server-side function.
