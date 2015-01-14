-- Revert product_meta/create

BEGIN;

    DROP TABLE product_meta;

COMMIT;
