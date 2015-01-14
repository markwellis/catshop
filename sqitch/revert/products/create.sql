-- Revert products/create

BEGIN;

    DROP TABLE products;

COMMIT;
