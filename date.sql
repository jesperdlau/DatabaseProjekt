

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



call book_item(00001, "B01", '2023-05-24 22:40:24');
call book_item(00001, "B02", '2023-04-24 21:40:24'); -- Raises error, out of order

SELECT * FROM BookingHistory;

