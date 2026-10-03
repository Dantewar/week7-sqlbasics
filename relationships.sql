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

SELECT
    users.id,
    users.name,
    profiles.bio
FROM users
JOIN profiles
    ON users.id = profiles.user_id;


-- Constraint test:
-- This would fail because user_id 99 does not exist.
--
-- INSERT INTO profiles (user_id, bio)
-- VALUES (99, 'Invalid profile');
--
-- PostgreSQL returns a foreign key constraint error because
-- profiles.user_id must reference an existing users.id.


-- Constraint test:
-- This would fail because user_id must be UNIQUE.
--
-- INSERT INTO profiles (user_id, bio)
-- VALUES (1, 'Second profile');
--
-- PostgreSQL returns a unique constraint error because
-- one user can only have one profile.


-- ============================================
-- 2. One-to-Many Relationship
-- authors -> books
-- ============================================

DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(id)
);

INSERT INTO authors (name)
VALUES
    ('George Orwell'),
    ('J.K. Rowling'),
    ('Stephen King');

INSERT INTO books (title, author_id)
VALUES
    ('1984', 1),
    ('Animal Farm', 1),
    ('Harry Potter and the Philosopher''s Stone', 2),
    ('The Shining', 3),
    ('It', 3);

SELECT
    authors.name AS author,
    books.title
FROM authors
JOIN books
    ON authors.id = books.author_id
ORDER BY authors.name, books.title;


-- Constraint test:
-- This would fail because author_id 99 does not exist.
--
-- INSERT INTO books (title, author_id)
-- VALUES ('Invalid Book', 99);
--
-- PostgreSQL returns a foreign key constraint error because
-- books.author_id must reference an existing authors.id.