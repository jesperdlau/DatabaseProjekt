DROP PROCEDURE IF EXISTS updateBillForResident;
DELIMITER ;;

CREATE PROCEDURE updateBillForResident(IN thisResID char(5), IN thisBillDate varchar(6))
BEGIN
	DECLARE LaundryPrice decimal(15,2);
    DECLARE BoatPrice decimal(15,2);

    SET LaundryPrice = (SELECT SUM(Price) 
    FROM Booking NATURAL JOIN BookingHistory NATURAL JOIN LaundryRoom
    WHERE ResID = ThisResID);
    
    SET BoatPrice = (SELECT SUM(Price) 
    FROM Booking NATURAL JOIN BookingHistory NATURAL JOIN Boats
    WHERE ResID = ThisResID);
    
    UPDATE Bills SET Laundry = LaundryPrice WHERE ResID = thisResID AND BillDate = thisBillDate;
    UPDATE Bills SET ClubsTotal = BoatPrice WHERE ResID = thisResID AND BillDate = thisBillDate;
End;
;;
DELIMITER ;


