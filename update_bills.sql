DROP PROCEDURE IF EXISTS updateBillsForResident;
DELIMITER ;;
CREATE PROCEDURE updateBillForResident(IN thisResID char(5))
BEGIN
	DECLARE LaundryPrice decimal(15,2);
    DECLARE BoatPrice decimal(15,2);
    
	SET LaundryPrice = (SELECT SUM(Price) FROM 
		(SELECT ResID, BookID FROM Booking WHERE ResID = thisResID)
		NATURAL JOIN 
		(SELECT BookID, ItemID FROM BookingHistory)
        NATURAL JOIN 
        (SELECT ItemID, Price FROM Laundry));
    
    
	SET BoatPrice = (SELECT SUM(Price) FROM 
		((SELECT ResID, BookID FROM Booking)
		NATURAL JOIN 
		(SELECT BookID, ItemID FROM BookingHistory)
        NATURAL JOIN 
        (SELECT ItemID, Price FROM Boats))
        WHERE ResID = thisResID);
    
    UPDATE Bills SET Laundry = LaundryPrice WHERE ResID = thisResID;
    UPDATE Bills SET Clubs = BoatPrice WHERE ResID = thisResID;
    
End;
;;
DELIMITER ;


