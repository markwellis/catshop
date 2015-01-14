-- Deploy product_category/create

BEGIN;

    CREATE TABLE product_category (
        id              serial PRIMARY KEY,

        product_id      integer REFERENCES products(id),
        category_id     integer REFERENCES categories(id),

        created_at      timestamptz NOT NULL default CURRENT_TIMESTAMP,
        updated_at      timestamptz
    );

    CREATE UNIQUE INDEX product_category_product_id_category_id ON product_category (product_id, category_id);

COMMIT;
