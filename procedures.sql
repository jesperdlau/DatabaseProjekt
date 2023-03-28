


-- Procedure til at insætte ny båd i boats table.
CREATE OR REPLACE PROCEDURE set_new_boat (IN new_name VARCHAR(20), IN new_type VARCHAR(10), IN ooo BOOLEAN)
BEGIN
    DECLARE new_number INT(2);
    DECLARE new_id VARCHAR(3);
    SET new_number = (SELECT MAX(RIGHT(ItemID, 2)) FROM Boats) + 1; -- New number is the biggest previous +1
    SET new_id = LPAD(CAST(new_number AS int), 2, "0"); -- Fixes the boat number as a string of len 2
    SET new_id = CONCAT("B", new_id); -- Sets "B" in fron of number.
    IF new_name NOT IN (SELECT BoatName FROM Boats) 
        THEN INSERT Boats VALUES (new_id, new_name, new_type, ooo); -- Only inserts boat if it doesn't exist.
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Boat already exists'; -- Else raise error
    END IF;
END;

-- Procedure til at indsætte ny maskine in Laundry
CREATE OR REPLACE PROCEDURE set_new_laundry (IN new_type VARCHAR(10), IN ooo BOOLEAN)
BEGIN
    DECLARE new_number INT(2);
    DECLARE new_id VARCHAR(3);
    SET new_number = (SELECT MAX(RIGHT(ItemID, 2)) FROM Laundry) + 1; -- New number is the biggest previous +1
    SET new_id = LPAD(CAST(new_number AS int), 2, "0"); -- Fixes the laundry number as a string of len 2
    SET new_id = CONCAT("L", new_id); -- Sets "L" in front of number. 
    INSERT Laundry VALUES (new_id, new_type, ooo);
END;

-- Update out of order for Laundry
CREATE OR REPLACE PROCEDURE set_laundry_out_of_order (IN laundry_id_ooo VARCHAR(20), IN ooo BOOLEAN)
BEGIN
    UPDATE Laundry SET OutOfOrder=ooo WHERE ItemID=laundry_id_ooo;
END;

-- Update out of order for Boats
CREATE OR REPLACE PROCEDURE set_boat_out_of_order (IN boat_name_ooo VARCHAR(20), IN ooo BOOLEAN)
BEGIN
    IF boat_name_ooo IN (SELECT BoatName FROM Boats) 
        THEN UPDATE Boats SET OutOfOrder=ooo WHERE BoatName=boat_name_ooo; -- Only update boat if it exists.
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Boat doesnt exists'; -- Else raise error
    END IF;
END;

-- Test
-- CALL set_new_boat("BrianTheBoat", "Kajak", False);
-- CALL set_boat_out_of_order("McBoatFace", False);
-- SELECT * FROM Boats;


-- Procedure til at booke items
CREATE OR REPLACE PROCEDURE book_item (IN res_id CHAR(5), IN item_id VARCHAR(3), IN book_time DATETIME)
BEGIN
    DECLARE new_book_id INT(8);
    DECLARE book_time_hour DATETIME;
    SET book_time_hour = date_format(book_time,'%Y-%m-%d %H');

    IF 0 IN (SELECT
    (SELECT OutOfOrder FROM Boats WHERE ItemID = item_id) UNION 
    (SELECT OutOfOrder FROM LaundryRoom WHERE ItemID = item_id)) -- If item is not out of order
        THEN IF book_time_hour NOT IN (SELECT TimeSlot FROM BookingHistory WHERE ItemID = item_id) -- If time slot is available
            THEN 
                INSERT INTO BookingHistory (ResID, ItemID, TimeSLot)
                    VALUES (res_id, item_id, book_time_hour);
            ELSE 
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Time slot is unavailable for that item';  -- Else raise error (Time slot unavailable)
            END IF;
    ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Item out of order'; -- Else raise error (Out of order)
    END IF;
END;



