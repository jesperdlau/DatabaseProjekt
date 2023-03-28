-- ###Project 1
-- #Authors: Carl Nørlund, Rasmus Torp, Jesper Lauridsen, Sara Maria Bjørn Andersen, Bressel

-- ## Fremtidens Kollegie Fællesskab / Dorm of the Future

-- #CREATE SHOULD ONLY RUN ONCE

DROP DATABASE IF EXISTS Kollegiedb;
CREATE DATABASE KollegieDB;


-- #USE DATABSASE
USE KollegieDB;



-- DROP IF EXISTS
DROP TABLE IF EXISTS Resident;
DROP TABLE IF EXISTS Lives;
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Owes;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS LaundryRoom;
DROP TABLE IF EXISTS Boats;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS BookingHistory;
DROP TABLE IF EXISTS Item;


-- #Table Creation


CREATE TABLE Resident
			(ResID		CHAR(5),
			 NameRes	VARCHAR(30),
             Email		VARCHAR(20),
             PhoneNr	CHAR(8),
             BankNr		VARCHAR(15),
             PRIMARY KEY(ResID)
             );
             
CREATE TABLE Rooms
			(RoomNr      varchar(2),
			 KitchenNr   varchar(2),
             BuildingID  varchar(2),
             Inhabited   bool,
             DoubleRoom  bool,
             rent        decimal(15,2),
             PRIMARY KEY (RoomNr, KitchenNr, BuildingID)
             );



CREATE TABLE Bills
			(BillID     varchar(16),
             ResID       varchar(2),
			 BillDate    varchar(16),   
             Internet    decimal(15,2),
             Laundry     decimal(15,2),
             ClubsTotal  decimal(15,2),
             PRIMARY KEY(BillID)
            );

CREATE TABLE LaundryRoom 
            (ItemID         VARCHAR(3),
             LaundryType    VARCHAR(10),
             Price          decimal(15,2),
             OutOfOrder     BOOLEAN DEFAULT False,
             PRIMARY KEY(ItemID)
             );

CREATE TABLE Boats 
            (ItemID         VARCHAR(3),
             BoatName       VARCHAR(20),
             BoatType       VARCHAR(10),
             Price          decimal(15,2),
             OutOfOrder     BOOLEAN DEFAULT False,
             PRIMARY KEY(ItemID)
             );

CREATE TABLE Booking
            (ResID       char(5),
             BookID      varchar(8),
             PRIMARY KEY(ResID, BookID)
             );



CREATE TABLE BookingHistory
			(BookID		    varchar(8),
             TimeSlot	    varchar(20),
             PRIMARY KEY(BookID)
             );
             
CREATE TABLE Item
            (BookID      varchar(8),
             ItemID      varchar(3),
             PRIMARY KEY(BookID, ItemID),
             FOREIGN KEY(ItemID) REFERENCES LaundryRoom(ItemID),
             FOREIGN KEY(ItemID) REFERENCES Boats(ItemID)
             );
             
            
CREATE TABLE Lives
			(ResID		CHAR(5),
			 RoomNr	 	VARCHAR(2),
             KitchenNr	VARCHAR(2),
             BuildingID	VARCHAR(2),
             PRIMARY KEY(ResID),
             FOREIGN KEY (KitchenNr, RoomNr, BuildingID) REFERENCES Rooms(KitchenNr, RoomNr, BuildingID) 
             ON DELETE SET NULL
             );
             
             
















