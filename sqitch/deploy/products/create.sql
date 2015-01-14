-- Deploy products/create

BEGIN;

    CREATE TABLE products (
        id              serial PRIMARY KEY,

        sku             varchar(256) NOT NULL,
        name            varchar(256) NOT NULL,
        normalized_name varchar(256) NOT NULL,

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

    CREATE UNIQUE INDEX products_sku ON products (sku);

COMMIT;
