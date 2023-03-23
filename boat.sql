USE Nybro;

-- Initialiser boat table
CREATE TABLE IF NOT EXISTS
Boats (
    thing_id VARCHAR(3),
    boat_name VARCHAR(20),
    boat_type VARCHAR(10),
    out_of_order BOOLEAN DEFAULT False,
    PRIMARY KEY(thing_id));

INSERT Boats VALUES
    ('B01', 'W.T. Frigg', 'Kano', False),
    ('B02', 'Malthe Boatsler', 'Kano', True),
    ('B03', 'Bo(at)', 'Kano', False),
    ('B04', 'Bloat', 'Kajak', False);

-- Dette virker i VS men ikke i Workbench!!!!
-- Procedure til at insætte ny båd i boats table.
CREATE OR REPLACE PROCEDURE set_new_boat (IN new_name VARCHAR(20), IN new_type VARCHAR(10), IN ooo BOOLEAN)
BEGIN
    DECLARE new_number INT(2);
    DECLARE new_id VARCHAR(3);
    SET new_number = (SELECT MAX(RIGHT(thing_id, 2)) FROM Boats) + 1; -- New number is the biggest previous +1
    SET new_id = LPAD(CAST(new_number AS int), 2, "0"); -- Fixes the boat number as a string of len 2
    SET new_id = CONCAT("B", new_id); -- Sets "B" in fron of number.
    IF new_name NOT IN (SELECT boat_name FROM Boats) 
        THEN INSERT Boats VALUES (new_id, new_name, new_type, ooo); -- Only inserts boat if it doesn't exist.
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Boat already exists'; -- Else raise error
    END IF;
END;

-- Update out of order
CREATE OR REPLACE PROCEDURE set_boat_out_of_order (IN boat_name_ooo VARCHAR(20), IN ooo BOOLEAN)
BEGIN
    UPDATE Boats SET out_of_order=ooo WHERE boat_name=boat_name_ooo;
END;

-- Test
CALL set_new_boat("BrianTheBoat", "Kajak", False);
CALL set_boat_out_of_order("McBoatFace", False);
SELECT * FROM Boats;




