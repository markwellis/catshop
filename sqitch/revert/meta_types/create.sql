-- Revert meta_types/create

BEGIN;

    DROP TABLE meta_types;

COMMIT;
