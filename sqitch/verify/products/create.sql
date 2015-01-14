-- Verify products/create

BEGIN;

    SELECT * FROM products WHERE 1=1;

ROLLBACK;
