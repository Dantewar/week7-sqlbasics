-- ============================================
-- Week 7 - SQL Joins Homework
-- Skill 1: Relationships
-- ============================================


-- ============================================
-- 1. One-to-One Relationship
-- users -> profiles
-- ============================================

DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,
    bio VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(id)
);


INSERT INTO users (name)
VALUES
    ('Dante'),
    ('Bianca'),
    ('Shanti');


INSERT INTO profiles (user_id, bio)
VALUES
    (1, 'Backend student'),
    (2, 'Developer'),
    (3, 'Product owner');


-- Show users together with their profiles

SELECT
    users.id,
    users.name,
    profiles.bio
FROM users
JOIN profiles
    ON users.id = profiles.user_id;


-- ============================================
-- Constraint tests
-- ============================================

-- Test 1:
-- This would fail because user_id 99 does not exist in users.
--
-- INSERT INTO profiles (user_id, bio)
-- VALUES (99, 'Invalid profile');
--
-- PostgreSQL returns a foreign key constraint error because
-- profiles.user_id must reference an existing users.id.


-- Test 2:
-- This would fail because user_id must be UNIQUE.
--
-- INSERT INTO profiles (user_id, bio)
-- VALUES (1, 'Second profile for Dante');
--
-- PostgreSQL returns a unique constraint error because
-- one user can only have one profile in this one-to-one relationship.