CREATE extension pgcrypto;
CREATE TABLE IF NOT EXISTS tasks
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);