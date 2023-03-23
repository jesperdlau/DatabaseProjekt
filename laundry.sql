-- Kan let oversættes til laundry osv. 
-- Initialiser boat table
CREATE TABLE IF NOT EXISTS
Laundry (
    thing_id VARCHAR(3),
    laundry_type VARCHAR(10),
    out_of_order BOOLEAN DEFAULT False,
    PRIMARY KEY(thing_id));

INSERT Laundry VALUES
    ('L01', 'Vask', False),
    ('L02', 'Vask', False),
    ('L03', 'Tørre', False),
    ('L04', 'Tørre', True);

-- Dette virker i VS men ikke i Workbench!!!!
-- Procedure til at insætte ny maskine i laundry table.
CREATE OR REPLACE PROCEDURE set_new_laundry (IN new_type VARCHAR(10), IN ooo BOOLEAN)
BEGIN
    DECLARE new_number INT(2);
    DECLARE new_id VARCHAR(3);
    SET new_number = (SELECT MAX(RIGHT(thing_id, 2)) FROM Laundry) + 1; -- New number is the biggest previous +1
    SET new_id = LPAD(CAST(new_number AS int), 2, "0"); -- Fixes the laundry number as a string of len 2
    SET new_id = CONCAT("L", new_id); -- Sets "L" in front of number. 
    INSERT Laundry VALUES (new_id, new_type, ooo);
END;

-- Update out of order
CREATE OR REPLACE PROCEDURE set_laundry_out_of_order (IN laundry_id_ooo VARCHAR(20), IN ooo BOOLEAN)
BEGIN
    UPDATE Laundry SET out_of_order=ooo WHERE thing_id=laundry_id_ooo;
END;

-- Test
CALL set_new_laundry("Vask", False);
CALL set_laundry_out_of_order("L05", True);
SELECT * FROM Laundry;
