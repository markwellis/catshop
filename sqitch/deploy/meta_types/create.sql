-- Deploy meta_types/create

BEGIN;

    CREATE TABLE meta_types (
        id              serial PRIMARY KEY,

        name            varchar(256) NOT NULL,

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

    CREATE UNIQUE INDEX meta_types_name ON meta_types (name);

COMMIT;
