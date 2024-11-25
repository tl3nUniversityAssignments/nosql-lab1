CREATE OR REPLACE FUNCTION run_all_tests()
RETURNS TABLE (test_name TEXT, test_result BOOLEAN) 
LANGUAGE plpgsql AS $$
DECLARE 
    v_user_id INT;
    v_character_id INT;
BEGIN
    -- Create test tables to store results
    DROP TABLE IF EXISTS test_results;
    CREATE TEMPORARY TABLE test_results (
        test_name TEXT,
        test_result BOOLEAN
    );

    -- Soft Delete User Test
    INSERT INTO "Users" ("Username", "Email", "PasswordHash") 
    VALUES ('TestUser', 'test@example.com', 'testhash')
    RETURNING "UserID" INTO v_user_id;

    CALL SoftDelete_Users(v_user_id, v_user_id);

    INSERT INTO test_results (test_name, test_result)
    VALUES ('SoftDelete_Users Test', 
        NOT EXISTS (
            SELECT 1 FROM Active_Users 
            WHERE "UserID" = v_user_id
        )
    );

    -- Restore User Test
    CALL Restore_Users(v_user_id, v_user_id);

    INSERT INTO test_results (test_name, test_result)
    VALUES ('Restore_Users Test', 
        EXISTS (
            SELECT 1 FROM Active_Users 
            WHERE "UserID" = v_user_id
        )
    );

    -- Soft Delete Character Test
    INSERT INTO "Characters" ("Name", "UserID", "RaceID", "ClassID") 
    VALUES ('TestChar', 1, 1, 1)
    RETURNING "CharacterID" INTO v_character_id;

    CALL SoftDelete_Characters(v_character_id, v_user_id);

    INSERT INTO test_results (test_name, test_result)
    VALUES ('SoftDelete_Characters Test', 
        NOT EXISTS (
            SELECT 1 FROM Active_Characters 
            WHERE "CharacterID" = v_character_id
        )
    );

    -- Restore Character Test
    CALL Restore_Characters(v_character_id, v_user_id);

    INSERT INTO test_results (test_name, test_result)
    VALUES ('Restore_Characters Test', 
        EXISTS (
            SELECT 1 FROM Active_Characters 
            WHERE "CharacterID" = v_character_id
        )
    );

    -- Audit Trigger Tests for Users
    UPDATE "Users" 
    SET "Email" = 'updated@example.com' 
    WHERE "UserID" = v_user_id;

    INSERT INTO test_results (test_name, test_result)
    VALUES ('Users Audit Trigger Test', 
        (SELECT "UpdatedAt" IS NOT NULL 
         FROM "Users" 
         WHERE "UserID" = v_user_id)
    );

    -- Audit Trigger Tests for Characters
    UPDATE "Characters" 
    SET "Level" = 2 
    WHERE "CharacterID" = v_character_id;

    INSERT INTO test_results (test_name, test_result)
    VALUES ('Characters Audit Trigger Test', 
        (SELECT "UpdatedAt" IS NOT NULL 
         FROM "Characters" 
         WHERE "CharacterID" = v_character_id)
    );

    -- Return results
    RETURN QUERY SELECT * FROM test_results;
END;
$$;

CREATE OR REPLACE PROCEDURE execute_tests()
LANGUAGE plpgsql AS $$
DECLARE
    test_results RECORD;
    has_failed BOOLEAN := FALSE;
BEGIN
    RAISE NOTICE 'Starting Database Object Tests';
    
    FOR test_results IN 
        SELECT * FROM run_all_tests() 
    LOOP
        IF test_results.test_result = FALSE THEN
            RAISE NOTICE 'Test Failed: %', test_results.test_name;
            has_failed := TRUE;
        ELSE
            RAISE NOTICE 'Test Passed: %', test_results.test_name;
        END IF;
    END LOOP;

    IF has_failed THEN
        RAISE EXCEPTION 'Some tests have failed';
    ELSE
        RAISE NOTICE 'All tests passed successfully';
    END IF;
END;
$$;

CREATE OR REPLACE PROCEDURE cleanup_test_data()
LANGUAGE plpgsql AS $$
BEGIN
    DELETE FROM "Characters" WHERE "Name" = 'TestChar';
    DELETE FROM "Users" WHERE "Username" = 'TestUser';
END;
$$;