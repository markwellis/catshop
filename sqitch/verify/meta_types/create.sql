-- Verify meta_types/create

BEGIN;

    SELECT * FROM meta_types WHERE 1=1;

ROLLBACK;
