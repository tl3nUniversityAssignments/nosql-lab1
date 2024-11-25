
CREATE OR REPLACE PROCEDURE SoftDelete_Users (
    p_id INT,
    p_updated_by INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Users"
    SET "DeletedAt" = CURRENT_TIMESTAMP,
        "UpdatedBy" = p_updated_by
    WHERE "UserID" = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE SoftDelete_Characters (
    p_id INT,
    p_updated_by INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Characters"
    SET "DeletedAt" = CURRENT_TIMESTAMP,
        "UpdatedBy" = p_updated_by
    WHERE "CharacterID" = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE Restore_Users (
    p_id INT,
    p_updated_by INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Users"
    SET "DeletedAt" = NULL,
        "UpdatedBy" = p_updated_by,
        "UpdatedAt" = CURRENT_TIMESTAMP
    WHERE "UserID" = p_id;
END;
$$;



CREATE OR REPLACE PROCEDURE Restore_Characters (
    p_id INT,
    p_updated_by INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE "Characters"
    SET "DeletedAt" = NULL,
        "UpdatedBy" = p_updated_by,
        "UpdatedAt" = CURRENT_TIMESTAMP
    WHERE "CharacterID" = p_id;
END;
$$;



CREATE OR REPLACE VIEW Active_Users AS
SELECT *
FROM "Users"
WHERE "DeletedAt" IS NULL;



CREATE OR REPLACE VIEW Active_Characters AS
SELECT *
FROM "Characters"
WHERE "DeletedAt" IS NULL;



CREATE OR REPLACE VIEW Audit_Users AS
SELECT *
FROM "Users";



CREATE OR REPLACE VIEW Audit_Characters AS
SELECT *
FROM "Characters";




CREATE OR REPLACE FUNCTION UpdateAudit_Users()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW."UpdatedAt" := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;



CREATE OR REPLACE FUNCTION UpdateAudit_Characters()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    NEW."UpdatedAt" := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;



CREATE OR REPLACE TRIGGER Update_Users_Trigger
BEFORE UPDATE ON "Users"
FOR EACH ROW
WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION UpdateAudit_Users();



CREATE OR REPLACE TRIGGER Update_Characters_Trigger
BEFORE UPDATE ON "Characters"
FOR EACH ROW
WHEN (OLD.* IS DISTINCT FROM NEW.*)
EXECUTE FUNCTION UpdateAudit_Characters();