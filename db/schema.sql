-- Database schema for supr-demo-target-alpha
-- Missing: Rate_Limits table (Issue #1)

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS sessions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  token VARCHAR(512) NOT NULL,
  expires_at TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TODO: Add Rate_Limits table to track login attempts per IP
-- Issue #1 requires this table for brute-force protection
-- CREATE TABLE Rate_Limits (
--   id SERIAL PRIMARY KEY,
--   ip_address VARCHAR(45) NOT NULL,
--   endpoint VARCHAR(255) NOT NULL,
--   attempt_count INTEGER DEFAULT 1,
--   window_start TIMESTAMPTZ DEFAULT NOW(),
--   blocked_until TIMESTAMPTZ,
--   UNIQUE(ip_address, endpoint)
-- );
