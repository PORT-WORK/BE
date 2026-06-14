ALTER TABLE users ADD COLUMN IF NOT EXISTS password_hash varchar(100);

INSERT INTO users (
    email,
    password_hash,
    name,
    profile_image_url,
    tier,
    location,
    experience_years,
    bio,
    language,
    ai_usage_count,
    is_email_public,
    noti_email,
    noti_push,
    noti_message,
    created_at,
    updated_at
)
VALUES (
    'demo@port.kr',
    '$2a$10$djDAOGSQh4WZJ7Ke98qZheHqxAtmTFWheINNCKIjMKMaqotCH1RvO',
    'PORT Demo',
    'https://i.pravatar.cc/150?img=12',
    'FREE',
    'Seoul',
    3,
    'Local login test account for PORT.',
    'ko',
    0,
    true,
    true,
    false,
    true,
    now(),
    now()
)
ON CONFLICT (email) DO UPDATE
SET password_hash = EXCLUDED.password_hash,
    updated_at = now();
