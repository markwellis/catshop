-- Revert product_category/create

BEGIN;

    DROP TABLE product_category;

COMMIT;
