-- Deploy categories/create

BEGIN;

    CREATE TABLE categories (
        id              serial PRIMARY KEY,

        name            varchar(256) NOT NULL,
        normalized_name varchar(256) NOT NULL UNIQUE,

        parent_id       integer REFERENCES categories(id),
        parent_path     varchar(256),

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

COMMIT;
