DROP PROCEDURE IF EXISTS updateBillsForResident;
DELIMITER ;;
CREATE PROCEDURE updateBillForResident(IN thisResID char(5))
BEGIN
	DECLARE LaundryPrice decimal(15,2);
    DECLARE BoatPrice decimal(15,2);

    SET LaundryPrice = (SELECT SUM(Price) 
    FROM Booking NATURAL JOIN BookingHistory NATURAL JOIN Laundry
    WHERE ResID = ThisResID);
    
    SET BoatPrice = (SELECT SUM(Price) 
    FROM Booking NATURAL JOIN BookingHistory NATURAL JOIN Boats
    WHERE ResID = ThisResID);
    
    UPDATE Bills SET Laundry = LaundryPrice WHERE ResID = thisResID;
    UPDATE Bills SET Clubs = BoatPrice WHERE ResID = thisResID;
End;
;;
DELIMITER ;


