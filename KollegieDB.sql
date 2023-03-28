-- ###Project 1
-- #Authors: Carl Nørlund, Rasmus Torp

-- ## Fremtidens Kollegie Fællesskab / Dorm of the Future

-- #CREATE SHOULD ONLY RUN ONCE
CREATE DATABASE KollegieDB;


-- #USE DATABSASE
USE KollegieDB;



-- DROP IF EXISTS
DROP TABLE IF EXISTS Resident;
DROP TABLE IF EXISTS Building;
DROP TABLE IF EXISTS Bills;
DROP TABLE IF EXISTS Kitchen;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Laundry;
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

CREATE TABLE Lives
			(ResID		CHAR(5),
			 RoomNr	 	VARCHAR(2),
             KitchenNr	VARCHAR(2),
             BuildingID	VARCHAR(2),
             PRIMARY KEY(ResID),
             FOREIGN KEY (RoomNr, KitchenNr, BuildingID) REFERENCES Rooms(RoomNr, KitchenNr, BuildingID)
             );
             
CREATE TABLE Building
			(BuildingID		VARCHAR(2),
			 SpecialRoom	VARCHAR(20),
             ResTot			INTEGER(4),
             PRIMARY KEY(BuildingID)
             );


CREATE TABLE Kitchen
			(KitchenNr    varchar(2),
             BuildingID   varchar(2),
             Budget       decimal(15,2),
             PRIMARY KEY(KitchenNr, BuildingID),
             );

CREATE TABLE Rooms
			(RoomNr      varchar(2),
			 KithcenNr   varchar(2),
             BuildingID  varchar(2),
             Inhabited   bool,
             PRIMARY KEY (RoomNr, KitchenNr, BuildingID),
             );
            
            
CREATE TABLE Bills
			(ResID       varchar(2),
			 Rent        decimal(15,2),
             Electricity decimal(15,2),
             Water       decimal(15,2),
             Internet    decimal(15,2),
             Laundry     decimal(15,2),
             Clubs       decimal(15,2),
             PRIMARY KEY(ResID)
            );
            
            

            
CREATE TABLE Booking
			(ResID       varchar(2),
			 BookID		 varchar(4),
             TimeSlot	 varchar(20),
             PRIMARY KEY(ResID, BookID, TimeSlot)
             );

CREATE TABLE Laundry
			 (BookID		varchar(4),
			  LaundryType	varchar(10),
              OutOfOrder	varchar(6),
              primary key(BookID)
              );

CREATE TABLE Laundry 
            (ItemID         VARCHAR(3),
             LaundryType    VARCHAR(10),
             OutOfOrder     BOOLEAN DEFAULT False,
             PRIMARY KEY(ItemID)
             );

CREATE TABLE Boats 
            (ItemID         VARCHAR(3),
             BoatName       VARCHAR(20),
             BoatType       VARCHAR(10),
             OutOfOrder     BOOLEAN DEFAULT False,
             PRIMARY KEY(ItemID)
             );

CREATE TABLE BookingHistory
			(BookID		    varchar(8),
             ResID          char(5),
             ItemID         varchar(3),
             TimeSlot	    varchar(20),
             PRIMARY KEY(BookID),
             FOREIGN KEY(ResID) REFERENCES Resident(ResID),
             FOREIGN KEY(ItemID) REFERENCES Boats(ItemID),
             FOREIGN KEY(ItemID) REFERENCES Laundry(ItemID)
             );

CREATE TABLE Booking
            (ResID       char(5),
             BookID      varchar(8),
             PRIMARY KEY(ResID, BookID)
             );

CREATE TABLE Item
            (BookID      varchar(8),
             ItemID      varchar(3),
             PRIMARY KEY(BookID, ItemID)
             );
             
             
             



















            
