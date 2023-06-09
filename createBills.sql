DROP PROCEDURE IF EXISTS createBills;

SET @rentSingleRoom = 2700;
SET @rentDoubleRoom = 4500;
SET @Internet = 50;

DELIMITER ;;
CREATE PROCEDURE createBills(IN thisResID varchar(5), IN thisBillDate varchar(6))
BEGIN
	DECLARE doubleroom bool;
    DECLARE thisBillID CHAR(32);
    
    # generates random BillID, these can be the same:/ (Bressel doesn't care)
    SET thisBillID = SUBSTR(MD5(rand()), 1, 16);
    
    SET doubleroom = (SELECT DoubleRoom FROM Rooms NATURAL JOIN Lives WHERE ResID = thisResID);
    
    IF doubleroom THEN
		INSERT INTO Bills
		VALUES (thisBillID, thisResID, thisBillDate, rentDoubleRoom, Internet, NULL, NULL);
		
	ELSE
		INSERT INTO Bills
        VALUES (thisBillID, thisResID, thisBillDate, rentSingleRoom, Internet, NULL, NULL);

END;
;;    