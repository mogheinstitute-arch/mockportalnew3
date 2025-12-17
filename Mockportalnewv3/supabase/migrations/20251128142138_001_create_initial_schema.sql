-- Users table
CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  role TEXT NOT NULL DEFAULT 'student',
  approved BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- User sessions table
CREATE TABLE IF NOT EXISTS user_sessions (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  device_token TEXT NOT NULL,
  user_agent TEXT,
  is_active BOOLEAN DEFAULT TRUE,
  last_activity TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, device_token)
);

-- Session violations table
CREATE TABLE IF NOT EXISTS session_violations (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  violation_type TEXT NOT NULL,
  old_device_token TEXT,
  new_device_token TEXT,
  user_agent TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Test attempts table
CREATE TABLE IF NOT EXISTS test_attempts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
  student_email TEXT,
  test_name TEXT,
  test_id TEXT,
  score INTEGER,
  total_questions INTEGER,
  correct_answers INTEGER,
  wrong_answers INTEGER,
  unattempted INTEGER,
  time_taken INTEGER,
  violations JSONB,
  submitted_at TIMESTAMPTZ DEFAULT NOW()
);
