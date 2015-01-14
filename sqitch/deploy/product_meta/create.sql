-- Deploy product_meta/create

BEGIN;

    CREATE TABLE product_meta (
        id              serial PRIMARY KEY,

        product_id      integer REFERENCES products(id),
        meta_type_id    integer REFERENCES meta_types(id),
        value           text,

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

COMMIT;
