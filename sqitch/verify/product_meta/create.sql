-- Verify product_meta/create

BEGIN;

    SELECT * FROM product_meta WHERE 1=1;

ROLLBACK;
