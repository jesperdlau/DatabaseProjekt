
DROP TRIGGER IF EXISTS MoveIn;
DROP TRIGGER IF EXISTS MoveOut;

DELIMITER ;;
CREATE TRIGGER MoveIn 
AFTER INSERT ON Resident
FOR EACH ROW 
BEGIN
	DECLARE thisRoomNr VARCHAR(2);
    DECLARE thisKitchenNr VARCHAR(2);
    DECLARE thisBuildingID VARCHAR(2);
    
    SET thisRoomNr = (SELECT RoomNr FROM Lives WHERE ResID = NEW.ResID);
    SET thisKitchenNr = (SELECT KitchenNr FROM Lives WHERE ResID = NEW.ResID);
    SET thisBuildingID = (SELECT BuildingNr FROM Lives WHERE ResID = NEW.ResID);
    
	UPDATE Rooms SET Inhabited = True 
    WHERE RoomNr = thisRoomNr 
    AND 
    KitchenNr = thisKitchenNr 
    AND 
    BuildingID = thisBuildingID;
END;
;;
DELIMITER ;

DELIMITER ;;
CREATE TRIGGER MoveOut 
BEFORE DELETE ON Resident
FOR EACH ROW 
BEGIN
	DECLARE thisRoomNr VARCHAR(2);
    DECLARE thisKitchenNr VARCHAR(2);
    DECLARE thisBuildingID VARCHAR(2);
    
    SET thisRoomNr = (SELECT RoomNr FROM Lives WHERE ResID = OLD.ResID);
    SET thisKitchenNr = (SELECT KitchenNr FROM Lives WHERE ResID = OLD.ResID);
    SET thisBuildingID = (SELECT BuildingNr FROM Lives WHERE ResID = OLD.ResID);
    
	UPDATE Rooms SET Inhabited = FALSE 
    WHERE RoomNr = thisRoomNr 
    AND 
    KitchenNr = thisKitchenNr 
    AND 
    BuildingID = thisBuildingID;
END;
;;
DELIMITER ;







