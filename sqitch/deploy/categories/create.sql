-- Deploy categories/create

BEGIN;

    CREATE TABLE categories (
        id              serial PRIMARY KEY,

        name            varchar(256) NOT NULL,
        normalized_name varchar(256) NOT NULL,

        parent_id       integer REFERENCES categories(id),
        parent_path     varchar(256),

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

    CREATE INDEX categories_normalized_name ON categories (normalized_name);
    CREATE INDEX categories_parent_path ON categories (parent_path);
    CREATE UNIQUE INDEX categories_normalized_name_parent_id ON categories (normalized_name, parent_id);

COMMIT;
