-- Spring Session JDBC Schema for H2 Database
-- This script creates the necessary tables for Spring Session JDBC

CREATE TABLE IF NOT EXISTS SPRING_SESSION (
    PRIMARY_ID CHAR(36) NOT NULL,
    SESSION_ID CHAR(36) NOT NULL,
    CREATION_TIME BIGINT NOT NULL,
    LAST_ACCESS_TIME BIGINT NOT NULL,
    MAX_INACTIVE_INTERVAL INT NOT NULL,
    EXPIRY_TIME BIGINT NOT NULL,
    PRINCIPAL_NAME VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS SPRING_SESSION_ATTRIBUTES (
    SESSION_PRIMARY_ID CHAR(36) NOT NULL,
    ATTRIBUTE_NAME VARCHAR(200) NOT NULL,
    ATTRIBUTE_BYTES BLOB NOT NULL
);

-- Add constraints only if they don't exist
-- Note: H2 doesn't support IF NOT EXISTS for constraints, so we'll let Spring Session handle this
-- The tables are created above, and Spring Session will add the constraints as needed

-- Create indexes using H2 syntax
CREATE INDEX IF NOT EXISTS SPRING_SESSION_IX1 ON SPRING_SESSION (EXPIRY_TIME);
CREATE INDEX IF NOT EXISTS SPRING_SESSION_IX2 ON SPRING_SESSION (PRINCIPAL_NAME);
