
 /*  Randall Taylor Database Milestone Project 'Law office'
	Syracuse University Spring Semester 
	Dr. Gregory Block - Professor 
*/

-- Drop Tables: drop all database object in reverse-dependency order. Drop foreign key 


IF OBJECT_ID('FirmCalendarCourtHearingDate') IS NOT NULL 
		DROP TABLE FirmCalendarCourtHearingDate;
go

IF OBJECT_ID('CourtCaseHearingDate') IS NOT NULL 
		DROP TABLE CourtCaseHearingDate;
go
IF OBJECT_ID('FirmCalendarClientPersonnel') IS NOT NULL 
		DROP TABLE FirmCalendarClientPersonnel;
go

IF OBJECT_ID('ClientCourtCase') IS NOT NULL 
		DROP TABLE ClientCourtCase;
go

IF OBJECT_ID('DiscoveryClient') IS NOT NULL 
		DROP TABLE DiscoveryClient;
go

IF OBJECT_ID('JudicialFormsClient') IS NOT NULL 
		DROP TABLE JudicialFormsClient;
go

IF OBJECT_ID('BillingClient') IS NOT NULL 
		DROP TABLE BillingClient;
go

IF OBJECT_ID('PersonnelClient') IS NOT NULL 
		DROP TABLE PersonnelClient;
go

IF OBJECT_ID('BillingPersonnel') IS NOT NULL 
		DROP TABLE BillingPersonnel;
go



IF OBJECT_ID('spCreateCase', 'P') IS NOT NULL 
		DROP PROC spCreateCase;
go

IF OBJECT_ID('spCreateClientCourtCase', 'P') IS NOT NULL 
		DROP PROC spCreateClientCourtCase;
go

IF OBJECT_ID('spCreateFirmCalendarEntry', 'P') IS NOT NULL
		DROP PROC spCreateFirmCalendarEntry;
go

IF OBJECT_ID('spCreateFirmMasterCalendar', 'P') IS NOT NULL
		DROP PROC spCreateFirmMasterCalendar
GO

IF OBJECT_ID('viewFirmCalendar', 'V') IS NOT NULL
		DROP VIEW viewFirmCalendar
GO

IF OBJECT_ID('TotalBillingHoursByClient', 'V') IS NOT NULL
		DROP VIEW TotalBillingHoursByClient
GO

IF OBJECT_ID('PersonnelClientCount', 'FN') IS NOT NULL
		DROP FUNCTION PersonnelClientCount

IF OBJECT_ID('mostPersonnelAssignments', 'V') IS NOT NULL
		DROP VIEW mostPersonnelAssignments
go



IF OBJECT_ID('totalPayrollOwed', 'V') IS NOT NULL
		DROP VIEW totalPayrollOwed
go

IF OBJECT_ID('CurrentCaseCount', 'FN') IS NOT NULL
		DROP FUNCTION CurrentCaseCount
go

IF OBJECT_ID('ClientCourtCaseAssignments', 'V') IS NOT NULL
		DROP VIEW ClientCourtCaseAssignments
go


-- at this point, below are the independent table drops


IF OBJECT_ID('CourtHearingDate') IS NOT NULL 
		DROP TABLE CourtHearingDate;
go

IF OBJECT_ID('FirmCalendar') IS NOT NULL 
		DROP TABLE FirmCalendar;
go

IF OBJECT_ID('CourtCase') IS NOT NULL 
		DROP TABLE CourtCase;
go

IF OBJECT_ID('Client') IS NOT NULL 
		DROP TABLE Client;
go

IF OBJECT_ID('Discovery') IS NOT NULL 
		DROP TABLE Discovery;
go

IF OBJECT_ID('JudicialForms') IS NOT NULL 
		DROP TABLE JudicialForms;
go

IF OBJECT_ID('Billing') IS NOT NULL 
		DROP TABLE Billing;
go

IF OBJECT_ID('Personnel') IS NOT NULL 
		DROP TABLE Personnel;
go





/* 
	This concludes the drop database objects;
	
	Now; create TABLES in DEPENDENCY ORDER: Create INDEPENDENT TABLES FIRST, then TABLES that
	are DEPENDENT.  

*/

--Law Office

CREATE TABLE Personnel	
(
	PersonnelID int IDENTITY NOT NULL,
	PersonnelFirstName varchar(30) NOT NULL,
	PersonnelLastName varchar(30) NOT NULL,
	PersonnelBarNumber varchar(30),
	CONSTRAINT PersonnelPK PRIMARY KEY (PersonnelID)

);
go

CREATE TABLE Billing
(
	BillingID int IDENTITY NOT NULL,
	BillingClientLastName varchar(100),
	BillingClientFirstName varchar(100),
	BillingDescription1 varchar(100),
	BillingDescription2 varchar(100),
	BillingDate DATETIME,
	CONSTRAINT BillingPK PRIMARY KEY (BillingID)

);
go

CREATE TABLE JudicialForms
(
	JudicialFormsID int IDENTITY NOT NULL,
	FormJurisdiction varchar(100) NOT NULL,
	FormName varchar(100) NOT NULL,
	FormStorageLocal varchar(100) NOT NULL,
	CONSTRAINT JudicialFormsPK PRIMARY KEY (JudicialFormsID)

);
go

-- All items tested correctly

CREATE TABLE Discovery
(
	DiscoveryID int IDENTITY NOT NULL,
	DiscoveryType varchar(100) NOT NULL,
	DiscoveryStorageLocation varchar(100) NOT NULL,
	CONSTRAINT DiscoveryPK PRIMARY KEY (DiscoveryID)

);
go

CREATE TABLE Client
(
	ClientID int IDENTITY NOT NULL,
	ClientFirstName varchar(100) NOT NULL,
	ClientLastName varchar(100) NOT NULL,
	ClientAddress1 varchar(50) NOT NULL,
	ClientAddress2 varchar(50), 
	ClientEmailAddress varchar(100) NOT NULL,
	ClientCity varchar(100) ,
	ClientState varchar(100) ,
	ClientProvince varchar(50), 
	ClientZIP varchar(20) ,
	CONSTRAINT ClientPK PRIMARY KEY (ClientID),
	CONSTRAINT ClientEmailAddressU1 UNIQUE (ClientEmailAddress), 
	
);
go

CREATE TABLE CourtCase
(
	CourtCaseID int IDENTITY NOT NULL,
	CourtName1 varchar(50) NOT NULL,
	CourtName2 varchar (50) NOT NULL,
	CourtNumber varchar(20) NOT NULL,
	CourtJudicialOfficer1 varchar(40) NOT NULL,
	CourtJudicialOfficer2 varchar(40),
	CourtCaseNumber varchar(50) NOT NULL, 
	CONSTRAINT CourtCasePK PRIMARY KEY (CourtCaseID)

);
go

CREATE TABLE FirmCalendar
(
	FirmCalendarID int IDENTITY NOT NULL, 
	FirmCalendarDate DATETIME NOT NULL,
	FirmCalendarMeetingTime varchar(50) NOT NULL,
	FirmCalendarMeetingInfo varchar(100) NOT NULL, 
	CONSTRAINT FirmCalendarPK PRIMARY KEY (FirmCalendarID)

);
go

CREATE TABLE CourtHearingDate
(
	CourtHearingDateID int IDENTITY NOT NULL,
	CourtHearingDateDescription varchar(100) NOT NULL, 
	CourtHearingHeard DATETIME NOT NULL,
	CONSTRAINT CourtHearingDatePK PRIMARY KEY (CourtHearingDateID)

);
go

-- All items tested correctly



-- It is at this point that all Dependent Tables will be created 

CREATE TABLE BillingPersonnel
(
	BillingPersonnelID int IDENTITY NOT NULL,
	BillingPersonnelRate int NOT NULL,
	BillingPersonnelHoursOwed int NOT NULL,
	PersonnelID int NOT NULL,
	BillingID int NOT NULL,
	CONSTRAINT PersonnelIDU1 UNIQUE(PersonnelID),
	CONSTRAINT BilingIDU2 UNIQUE(BillingID),
	CONSTRAINT BillingPersonnelPK PRIMARY KEY (BillingPersonnelID),
	CONSTRAINT BillingPersonnelFK1 FOREIGN KEY (PersonnelID) REFERENCES Personnel (PersonnelID),
	CONSTRAINT BillingPersonnelFK2 FOREIGN KEY (BillingID) REFERENCES Billing(BillingID) 
	
);
go

CREATE TABLE PersonnelClient
(
	PersonnelClientID int IDENTITY NOT NULL,
	PersonnelID int NOT NULL,
	ClientID int NOT NULL,
	CONSTRAINT PersonnelClientPK PRIMARY KEY(PersonnelClientID),
	CONSTRAINT PersonnelClient_FK1 FOREIGN KEY (PersonnelID) REFERENCES Personnel(PersonnelID),
	CONSTRAINT PersonnelClient_FK2 FOREIGN KEY (ClientID) REFERENCES Client(ClientID)
);
go

CREATE TABLE BillingClient
(
	BillingClientID int IDENTITY NOT NULL,
	ClientTotalBillingHours int,
	BillingID int NOT NULL, 
	ClientID int NOT NULL,
	CONSTRAINT BillingClientPK PRIMARY KEY (BillingClientID),
	CONSTRAINT BillingClient_FK1 FOREIGN KEY (BillingID) REFERENCES Billing(BillingID),
	CONSTRAINT BillingClient_FK2 FOREIGN KEY(ClientID) REFERENCES Client(ClientID),
	

);
go

CREATE TABLE JudicialFormsClient
(
	JudicialFormsClientID int IDENTITY NOT NULL,
	JudicialFormsID int NOT NULL,
	ClientID int NOT NULL, 
	CONSTRAINT JudicialFormsClientPK PRIMARY KEY (JudicialFormsClientID),
	CONSTRAINT JudicialFormsClient_FK1 FOREIGN KEY (JudicialFormsID) REFERENCES JudicialForms(JudicialFormsID), 
	CONSTRAINT JudicialFormsClient_FK2 FOREIGN KEY (ClientID) REFERENCES Client(ClientID) 

);
go

CREATE TABLE DiscoveryClient 
(
	DiscoveryClientID int IDENTITY NOT NULL, 
	DiscoveryID int NOT NULL, 
	ClientID int NOT NULL, 
	CONSTRAINT DiscoveryIDU1 UNIQUE(DiscoveryID),
	CONSTRAINT ClientIDU2 UNIQUE(ClientID),
	CONSTRAINT DiscoveryClientPK PRIMARY KEY (DiscoveryClientID),
	CONSTRAINT DiscoveryClientFK1 FOREIGN KEY (DiscoveryClientID) REFERENCES Discovery(DiscoveryID), 
	CONSTRAINT DiscoveryClientFK2 FOREIGN KEY (DiscoveryClientID) REFERENCES Client(ClientID)

);
go

CREATE TABLE ClientCourtCase
(
	ClientCourtCaseID int IDENTITY NOT NULL,
	CONSTRAINT ClientCourtCasePK PRIMARY KEY (ClientCourtCaseID),
	CourtCaseID int NOT NULL,
	ClientID int NOT NULL,
	CONSTRAINT CourtCaseIDU1 UNIQUE(CourtCaseID),
	CONSTRAINT ClientIDU3 UNIQUE(ClientID),
	CONSTRAINT ClientCourtCaseFK1 FOREIGN KEY (CourtCaseID) REFERENCES CourtCase(CourtCaseID),
	CONSTRAINT ClientCourtCaseFK2 FOREIGN KEY (ClientID) REFERENCES Client(ClientID)

);
go

-- All items tested correctly

CREATE TABLE FirmCalendarClientPersonnel
(
	
	FirmCalendarClientPersonnelID int IDENTITY NOT NULL,
	MasterMeetingNumber int NOT NULL,
	PersonnelHoursSpent int  ,
	ClientID int , 
	PersonnelID int , 
	FirmCalendarID int ,
	CONSTRAINT FirmCalendarClientPersonnelPK PRIMARY KEY (FirmCalendarClientPersonnelID),
	CONSTRAINT FirmCalendarClientPersonnelFK1 FOREIGN KEY (ClientID) REFERENCES Client(ClientID),
	CONSTRAINT FirmCalendarClientPersonnelFK2 FOREIGN KEY (PersonnelID) REFERENCES Personnel(PersonnelID),
	CONSTRAINT FirmCalendarClientPersonnelFK3 FOREIGN KEY( FirmCalendarID) REFERENCES FirmCalendar(FirmCalendarID)

);
go

CREATE TABLE CourtCaseHearingDate
(
	CourtCaseHearingDateID int IDENTITY NOT NULL,
	CourtCaseID int NOT NULL, 
	CourtHearingDateID int NOT NULL, 
	CONSTRAINT CourtCaseIDU2 UNIQUE(CourtCaseID),
	CONSTRAINT CourtHearingDateIDU2 UNIQUE(CourtHearingDateID),
	CONSTRAINT CourtCaseHearingDatePK PRIMARY KEY (CourtCaseHearingDateID),
	CONSTRAINT CourtCaseHearingDateFK1 FOREIGN KEY (CourtCaseID) REFERENCES CourtCase(CourtCaseID), 
	CONSTRAINT CourtCaseHearingDateFK2 FOREIGN KEY (CourtHearingDateID) REFERENCES CourtHearingDate(CourtHearingDateID)

);
go

CREATE TABLE FirmCalendarCourtHearingDate
(
	FirmCalendarCourtHearingDateID int IDENTITY NOT NULL,
	FirmCalendarID int NOT NULL, 
	CourtHearingDateID int NOT NULL, 
	CONSTRAINT FirmCalendarID UNIQUE(FirmCalendarID),
	CONSTRAINT CourtHearingDateID UNIQUE(CourtHearingDateID),
	CONSTRAINT FirmCalendarCourtHearingDatePK PRIMARY KEY (FirmCalendarCourtHearingDateID),
	CONSTRAINT FirmCalendarCourtHearingDateFK1 FOREIGN KEY (FirmCalendarCourtHearingDateID) REFERENCES FirmCalendar(FirmCalendarID),
	CONSTRAINT FirmCalendarCourtHearingDateFK2 FOREIGN KEY (FirmCalendarCourtHearingDateID) REFERENCES CourtHearingDate(CourtHearingDateID)


);
go


/*
	 This ends the body of the Law Office Database tables. 

	 Moving Forward we will see our 
	 INSERT statements
	 PROCEDURES 
	 VIEWS
	 AGGREGATES

 
	DATA CREATION 

	In order to answer data questions; there has to be data present that can be aggregatly ran against. 
*/

--creating client data, adding 10 clients to clients table 


INSERT INTO Client
(ClientFirstName, ClientLastName, ClientAddress1, ClientAddress2, ClientEmailAddress, ClientCity, ClientState, ClientZIP)

VALUES

('David', 'Wearhouse', '84 Home Lane', 'Apartment 2', 'dwearhouse@mail.mail', 'New York', 'New State', '071000'),
('Edward', 'Vincent', '83 House Street', 'none', 'evin@email.mail', 'OldeTowne', 'Texas', '071002'),
('Franny', 'Ulvade', '82 State Street', '3 floor', 'fuvalde@mail.org', 'Kingston', 'Mississippi', '071001'),
('Greg', 'Thomas', '24 Basic Bia Ave', '2 floor', 'gthom@funktown.org', 'Kings Failing', 'New Hampshire', '071003'),
('Hillary', 'Samson', '12 Trail Place Ln', 'none', 'Hsam@att.com', 'Wylie', 'Texas', '071020'),
('Icabod', 'Crane', '1123 Sleepy Street Road', 'none', 'icrane@home.org', 'Sleepy Hollow', 'New York', '071001'),
('Shelly', 'Crable', '41 Patricia Ln', 'Lot 1', 'scrable@att.org', 'Westminister', 'Colorado', '90212'),
('Gavin', 'Lee', '45 West Street', 'Lot 12', 'glee@wiznet.com', 'McKinney', 'Nevada', '12010'),
('Chris', 'Tucker', '1121 Lefty Lane', 'Apt 123', 'tuckerc@me.org', 'Detriot', 'Michigan', '65520'),
('Shelby', 'Mustang', '66 Big Street', 'none', 'smustang@ford.com', 'Chicago', 'Illinois', '102801'),
('Randall', 'Taylor', '66 Big Street', 'none', 'rtaylor@ford.com', 'Chicago', 'Illinois', '102801')

go


-- Adding Court(s), Location(s), Judge(s), Case Numbers to the Court Case Table

INSERT INTO CourtCase
(CourtName1, CourtName2, CourtNumber, CourtJudicialOfficer1, CourtJudicialOfficer2, CourtCaseNumber)

VALUES

('District', 'Court Room A', '222nd', 'Judge Alex Jones', 'Associate Judge', '071000'),
('Municipal', 'Court Room B', '83rd', 'Judge Chris Tucker', 'Associate Judge','071002'),
('Federal', 'Court Room c', '4th Appeals Court', 'Judge Harris', 'Associate Judge', '071001'),
('District', 'Court Room D', '24th', 'Judge Johnson', 'Associate Judge', '071003'),
('Tax', 'Court Room B', '12th', 'Judge Blinkon', 'Associate Judge', '071020'),
('Appelate Court', 'Court Room A', '112th', 'Judge Blankenship', 'Associate Judge', '071001'),
('Probate Court', 'Court Room A', '41st', 'Judge Qye', 'Associate Judge', '90212'),
('District Court', 'Court Room B', '45th ', 'Judge Jacobs', 'Associate Judge', '12010'),
('Appeals Court', 'Court Room B', '11th', 'Judge Johnson', 'Associate Judge', '65520'),
('District', 'Court Room B', '222ns', 'Judge Hisname', 'Associate Judge', '102801')

go



INSERT INTO Personnel
(PersonnelFirstName, PersonnelLastName, PersonnelBarNumber)
VALUES
('Perry','Mason','323'), 
('Della','Street','232'),
('Sarah','Pause','544'),
('William','Fontaine','656')
go

--adding Personnel to Client relationships

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES (
       (SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Pause'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Crable')
	   )
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Pause'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Vincent')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Street'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Tucker')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Street'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Tucker')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Mason'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Crane')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Fontaine'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Tucker')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Pause'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Thomas')
		)
go

INSERT INTO PersonnelClient (PersonnelID, ClientID)
VALUES ( 
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Pause'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Wearhouse')
		)
go

--Adding Data to the Billing Table, Billing Descriptions and Billing Dates

-- I forgot to add the BillingDate attribute to the Billing Table 



go
INSERT INTO Billing
(BillingClientFirstName,  BillingClientLastName, BillingDescription1, BillingDescription2, BillingDate )

VALUES

('David','Wearhouse','District Court Room A','222nd Judge Alex Jones Associate Judge', '2019-04-02'),  
('Edward','Vincent','Municipal Court Room B', '83rd Judge Chris Tucker Associate Judge','2019-04-01'),
('Franny','Ulvade','Federal  Court Room C', '4th Appeals Court Judge Harris Associate Judge', '2019-04-08'),
('Icabod','Crane','District Court Room D', '24th Judge Johnson Associate Judge', '2019-04-07'),
('Shelly','Crable','Tax Court Room B', '12th Judge Blinkon Associate Judge', '2019-04-04'),
('Gavin','Lee','Appelate Court Court Room A', '112th Judge Blankenship Associate Judge', '2019-04-20'),
('Hillary','Samson','Probate Court Court Room A', '41st Judge Qye Associate Judge', '2019-04-21'),
('Greg','Thomas','District Court Court Room B', '45th  Judge Jacobs Associate Judge', '2019-04-14'),
('Chris','Tucker','Appeals Court Court Room B', '11th Judge Johnson Associate Judge', '2019-04-26'),
('Shelby','Mustang','District Court Room B', '222nd Judge Hisname Associate Judge', '2019-04-30'),
('Randall', 'Taylor', 'Just a Demonstration', 'Of the Delete','2019-04-04')

go

-- The following insert statements are inserting Billing data, Client data, and hours billed, to Billing Client

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Wearhouse'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Wearhouse'),
	   ('10')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Thomas'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Thomas'),
	   ('40')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Crable'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Crable'),
	   ('80')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Lee'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Lee'),
	   ('40')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Mustang'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Mustang'),
	   ('40')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Crane'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Crane'),
	   ('78')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Samson'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Samson'),
	   ('65')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Vincent'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Vincent'),
	   ('78')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Thomas'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Thomas'),
	   ('60')
	   )
go


go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Vincent'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Vincent'),
	   ('40')
	   )
go

INSERT INTO BillingClient (BillingID, ClientID, ClientTotalBillingHours)
VALUES (
       (SELECT BillingID FROM Billing WHERE BillingClientLastName = 'Crane'),
       (SELECT ClientID FROM Client WHERE ClientLastName = 'Crane'),
	   ('20')
	   )
go

-- The following insert statements are to enter values within the BillingPersonnel table


INSERT INTO BillingPersonnel (BillingPersonnelRate, BillingPersonnelHoursOwed, PersonnelID, BillingID)
VALUES (
		('150'), ('80'),
		(SELECT PersonnelID FROM Personnel WHERE PersonnelLastName = 'Pause'),
		(SELECT ClientID FROM Client WHERE ClientLastName = 'Crable')
		)
go







/*

	 DELETE STATEMENTS : 
	 While going throught the Client and Billing Tables; entries I noticed that I accidentally added myself to the list

	 UPDATE STATEMENTS : 
	 Client table, David Wearhouse has moved and the address needs to be updated. 
*/

DELETE FROM Client
WHERE ClientID = 11

-- DELETE STATEMENTS: Delete record Billing ID via the Last Name 

DELETE FROM Billing

WHERE BillingClientLastName = 'Taylor'


--Confirming the data changes within these tables 
SELECT * FROM Client
SELECT * FROM Billing

--UPDATE STATEMENTS : Client table, David Wearhouse has moved and the address needs to be updated. 

UPDATE Client
SET ClientAddress1 = '40 Westwood lane'
WHERE ClientID = 1 
go

UPDATE Client 
SET ClientAddress2 = 'TownHouse 3'
WHERE CLientID = 1
go


/* 
		Stored procedures for:  

*/

-- Create a stored procedure for entering Case information into the CourtCase table (sp_#1)

CREATE PROC spCreateCase
		@CourtName1 varchar(50),
		@CourtName2 varchar(50),
		@CourtNumber varchar(20),
		@CourtJudicialOfficer1 varchar(40),
		@CourtJudicialOfficer2 varchar(40),
		@CourtCaseNumber varchar(50)

AS 
BEGIN
IF EXISTS 
	(SELECT * FROM CourtCase WHERE CourtCaseNumber = @CourtCaseNumber)

	BEGIN 
		UPDATE CourtCase
		SET CourtName1 = @CourtName1, CourtName2 = @CourtName2, CourtNumber = @CourtNumber, 
		CourtJudicialOfficer1 = @CourtJudicialOfficer1, CourtJudicialOfficer2 = @CourtJudicialOfficer2, 
		CourtCaseNumber = @CourtCaseNumber
	END

ELSE
	BEGIN
		INSERT INTO CourtCase
		(CourtName1, CourtName2, CourtNumber, CourtJudicialOfficer1, CourtJudicialOfficer2, CourtCaseNumber)

		VALUES
		(@CourtName1, @CourtName2, @CourtNumber, @CourtJudicialOfficer1, @CourtJudicialOfficer2, @CourtCaseNumber)
	END
	RETURN @@IDENTITY

END
go


-- Let's add some Cases into the Court Cases table via the store procedure just created
-- Executing the Stored Procedure: spCreateCase (executing stored procedure #1)


EXEC spCreateCase
		@CourtName1 = 'District',
		@CourtName2 = 'Court Room A',
		@CourtNumber = '222d ', 
		@CourtJudicialOfficer1 = 'Judge Johnson ',
		@CourtJudicialOfficer2 = 'Associate Judge ',
		@CourtCaseNumber = '902132'

go

-- Create a stored procedure for entering Case information into the CourtCase table sp_#2



CREATE PROC spCreateClientCourtCase
		@CourtCaseID int,
		@ClientID int
AS 
BEGIN
IF EXISTS 
	(SELECT * FROM ClientCourtCase WHERE CourtCaseID = @CourtCaseID)

	BEGIN 
		UPDATE ClientCourtCase
		SET CourtCaseID = @CourtCaseID, ClientID = @ClientID
		
	END   

ELSE
	BEGIN
		INSERT INTO ClientCourtCase
		(CourtCaseID, ClientID)

		VALUES
		(@CourtCaseID, @ClientID)
	END
	RETURN @@IDENTITY

END
go

-- Let's add some ase information into the CourtCase table via the store procedure just created
-- Executing the Stored Procedure: spCreateCase (executing stored procedure #2) creation of 9 entries


EXEC spCreateClientCourtCase
		@CourtCaseID = '2',
		@ClientID = '2'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '3',
		@ClientID = '3'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '4',
		@ClientID = '4'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '5',
		@ClientID = '5'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '6',
		@ClientID = '6'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '7',
		@ClientID = '7'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '8',
		@ClientID = '8'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '9',
		@ClientID = '9'   

go

EXEC spCreateClientCourtCase
		@CourtCaseID = '10',
		@ClientID = '10'   

go

-- Create a stored procedure for creating a Firm Calendar Entry into the Firm Calendar table sp_#3 ( FirmCalendarMeetingTime, 
--FirmCalendarMeetingInfo,FirmCalendarDate)

CREATE PROC spCreateFirmCalendarEntry  

		@FirmCalendarID int,
		@FirmCalendarMeetingTime varchar(100),
		@FirmCalendarMeetingInfo varchar(50),
		@FirmCalendarDate DATETIME
AS 
BEGIN
IF EXISTS 
	(SELECT * FROM FirmCalendar WHERE @FirmCalendarID = FirmCalendarID)

	BEGIN 
		UPDATE FirmCalendar
		SET FirmCalendarMeetingTime = @FirmCalendarMeetingTime, FirmCalendarMeetingInfo = @FirmCalendarMeetingInfo, 
			FirmCalendarDate = @FirmCalendarDate
		
	END   

ELSE
	BEGIN
		INSERT INTO FirmCalendar
		( FirmCalendarID,FirmCalendarMeetingTime, FirmCalendarMeetingInfo, FirmCalendarDate)

		VALUES
		(@FirmCalendarID, @FirmCalendarMeetingTime, @FirmCalendarMeetingInfo, @FirmCalendarDate)
	END
	RETURN @@IDENTITY

END
go
-- Let's add some case information into the FirmCalendar table via the store procedure just created
-- Executing the Stored Procedure: spCreateFirmCalendarEntry (executing stored procedure #3) creation of 10 Calendar entries
--I know that Setting the IDentity Insert to ON is not recommended, however, I will note in reflection that I just can not get this table to work, otherwise and I need it to work 

SET IDENTITY_INSERT [dbo].FirmCalendar ON

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-01 04:30', 
		@FirmCalendarMeetingTime = 'Court Room A District Court',
		@FirmCalendarMeetingInfo = 'David Warehouse Case, Discovery Hearing',
		@FirmCalendarID = '1'

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-02 02:30', 
		@FirmCalendarMeetingTime = 'Municipal Court Court Room B Judge Tucker',
		@FirmCalendarMeetingInfo = 'Edward Vincent Case, Discovery Hearing',
			@FirmCalendarID = '2' 
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-04 02:30', 
		@FirmCalendarMeetingTime = 'Federal Court Room c Judge Harris ',
		@FirmCalendarMeetingInfo = 'Franny Ulvade Case, Discovery Hearing', 
		@FirmCalendarID ='3'
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-05 02:30', 
		@FirmCalendarMeetingTime = 'District Court Room D ',
		@FirmCalendarMeetingInfo = 'Greg Thomas Case, Discovery Hearing', 
		@FirmCalendarID ='4'
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-06 02:30', 
		@FirmCalendarMeetingTime = 'Tax Court, Court Room B  Judge Blinkon',
		@FirmCalendarMeetingInfo = 'Hillary Samson Case, Discovery Hearing', 
		@FirmCalendarID ='5'
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-07 02:30', 
		@FirmCalendarMeetingTime = 'Appeals Court Court Room B Judge Hisname',
		@FirmCalendarMeetingInfo = 'Icabod Crane Case, Discovery Hearing', 
		@FirmCalendarID ='6'
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-08 02:30', 
		@FirmCalendarMeetingTime = 'Probate Court -- Miss you Mama <3',
		@FirmCalendarMeetingInfo = 'Shelly Taylor Crable Case, Probate Hearing', 
		@FirmCalendarID ='7'
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-09 02:30', 
		@FirmCalendarMeetingTime = 'District Court Court Room B Judge Qye',
		@FirmCalendarMeetingInfo = 'Gavin Lee Case, Discovery Hearing',
		@FirmCalendarID ='8' 
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-10 02:30', 
		@FirmCalendarMeetingTime = 'Appeals Court Court Room B Judge Johnson',
		@FirmCalendarMeetingInfo = 'Chris Tucker Case, Discovery Hearing',
		@FirmCalendarID ='9' 
		

go

EXEC spCreateFirmCalendarEntry
		
		@FirmCalendarDate = '2019-04-11 02:30', 
		@FirmCalendarMeetingTime = 'District Court Room B Judge Hisname',
		@FirmCalendarMeetingInfo = 'Shelby Mustang Case, Discovery Hearing',
		@FirmCalendarID ='10' 
		

go

SET IDENTITY_INSERT [dbo].FirmCalendar OFF

go
SELECT * FROM FirmCalendar


--Right this is getting interesting, now, let us tie the Firm Calendar entries, to the Personnel and Clients, via the 
-- FirmCalendarClientPersonnel table (thats a mouthful, remind me to reflect upon this) sp_#4
go

CREATE PROC spCreateFirmMasterCalendar 
		
		@MasterMeetingNumber int,
		@PersonnelHoursSpent int,
		@ClientID int,
		@PersonnelID int, 
		@FirmCalendarID int
		

AS 
BEGIN
		

IF EXISTS 
	(SELECT * FROM FirmCalendarClientPersonnel WHERE @MasterMeetingNumber = MasterMeetingNumber )  

	BEGIN 
		UPDATE FirmCalendarClientPersonnel
		SET MasterMeetingNumber = @MasterMeetingNumber,  PersonnelHoursSpent = @PersonnelHoursSpent, ClientID = @ClientID, PersonnelID = @PersonnelID, FirmCalendarID = @FirmCalendarID 

		
	END   

ELSE
	BEGIN
		
		INSERT INTO FirmCalendarClientPersonnel
		( MasterMeetingNumber, PersonnelHoursSpent, ClientID, PersonnelID, FirmCalendarID)
		
		VALUES
			(@MasterMeetingNumber, @PersonnelHoursSpent, @ClientID,@PersonnelID, @FirmCalendarID)
				
	
	
	END
	RETURN @@IDENTITY

END

go


---- Let's add some case information into the FirmCalendarClientPersonnel table via the stored procedure just created
-- Executing the Stored Procedure: spCreateFirmMasterCalendar (executing stored procedure #4) creation of 10 Calendar entries 

go
EXEC spCreateFirmMasterCalendar
		
		@FirmCalendarID = '7',
		@MasterMeetingNumber = '101',
		@PersonnelHoursSpent = '11',
		@ClientID = '7',
		@PersonnelID = '3'
		
go		
	
EXEC spCreateFirmMasterCalendar
		@MasterMeetingNumber = '102',
		@PersonnelHoursSpent = '23',
		@ClientID = '2',
		@PersonnelID = '3',
		@FirmCalendarID = '2'

go


EXEC spCreateFirmMasterCalendar
		@MasterMeetingNumber = '103',
		@PersonnelHoursSpent = '55',
		@ClientID = '9',
		@PersonnelID = '2',
		@FirmCalendarID = '9'

go

EXEC spCreateFirmMasterCalendar
		@MasterMeetingNumber = '106',
		@PersonnelHoursSpent = '21',
		@ClientID = '9',
		@PersonnelID = '4',
		@FirmCalendarID = '2'

go

EXEC spCreateFirmMasterCalendar
		@MasterMeetingNumber = '107',
		@PersonnelHoursSpent = '42',
		@ClientID = '4',
		@PersonnelID = '3',
		@FirmCalendarID = '4'

go

EXEC spCreateFirmMasterCalendar
		@MasterMeetingNumber = '108',
		@PersonnelHoursSpent = '53',
		@ClientID = '1',
		@PersonnelID = '3',
		@FirmCalendarID = '1'

go	

-- Views (5 pertaint to Data Questions) 
-- Create a View of the Firm Calendar and Master Calendar Assignments, such, that Personnel know their exact Scheduling  #1 

CREATE VIEW viewFirmCalendar AS
		SELECT FirmCalendarClientPersonnel.MasterMeetingNumber, 
			   FirmCalendarClientPersonnel.PersonnelHoursSpent, 
			   FirmCalendarClientPersonnel.PersonnelID,
			   FirmCalendarClientPersonnel.ClientID, 
			   FirmCalendar.FirmCalendarID, 
			   FirmCalendar.FirmCalendarDate, (SUM(ALL FirmCalendarClientPersonnel.PersonnelHoursSpent / 8) * 240) AS MediationBillRate 


		FROM FirmCalendarClientPersonnel
		RIGHT OUTER JOIN FirmCalendar 
		ON FirmCalendarClientPersonnel.FirmCalendarID = FirmCalendar.FirmCalendarID
		GROUP BY FirmCalendarClientPersonnel.MasterMeetingNumber, FirmCalendarClientPersonnel.PersonnelHoursSpent, 
			   FirmCalendarClientPersonnel.PersonnelID, FirmCalendarClientPersonnel.ClientID, FirmCalendar.FirmCalendarID, FirmCalendar.FirmCalendarDate
go

SELECT * FROM viewFirmCalendar



go


--We need to create a view that will tell us our Total Billing Hours, per each Client  #2





go
CREATE VIEW TotalBillingHoursByClient 

		AS
		SELECT DISTINCT  Client.ClientID, Client.ClientLastName, Client.ClientFirstName,  (SUM(BillingClient.ClientTotalBillingHours)) AS TotalAllBilling
		FROM BillingClient
		RIGHT OUTER JOIN Client 
		ON BillingClient.ClientID = Client.ClientID
		GROUP BY BillingClient.ClientTotalBillingHours, Client.ClientID, Client.ClientLastName, Client.ClientFirstName  
		

GO 

SELECT * FROM TotalBillingHoursByClient






--Create a Function to select the Top 5 Personnel Client Assignments that is then tied into a view, for the purpose of answering data question, 
-- top 5 personnel assignments #3
go

CREATE FUNCTION PersonnelClientCount(@Collective int)
RETURNS int AS
BEGIN
	DECLARE @returnValue int 

	SELECT @returnValue = (MAX(PersonnelID)) FROM PersonnelClient 
	WHERE PersonnelClient.PersonnelClientID = @Collective
	RETURN @returnValue
END 
go 


CREATE VIEW mostPersonnelAssignments 
		AS
		SELECT TOP 5 
			*
			, dbo.PersonnelClientCount(PersonnelClientID) AS PersonnelAssignments
		FROM PersonnelClient
		ORDER BY PersonnelAssignments

GO

SELECT * FROM mostPersonnelAssignments





---Created the vIEW to give us the payroll total, now we can add that to a VIEW #4
GO
CREATE VIEW totalPayrollOwed 

		AS
		SELECT BillingPersonnelRate, BillingPersonnelHoursOwed, (SUM([BillingPersonnelRate]*[BillingPersonnelHoursOwed])) AS PayrollDue 
		FROM BillingPersonnel
		GROUP BY [BillingPersonnelID],[BillingPersonnelRate], [BillingPersonnelHoursOwed]

GO 

SELECT * FROM totalPayrollOwed




-- Create a view and a function that will creat a view of current court cases, and the amount of cases per client #5

go

CREATE FUNCTION CurrentCaseCount(@ClientCount int)
RETURNS int AS
BEGIN
	 DECLARE @CurrentBalance int


	SELECT @CurrentBalance = COUNT(*) FROM ClientCourtCase
	RIGHT OUTER JOIN Client 
		ON ClientCourtCase.ClientID = Client.ClientID
		GROUP BY Client.ClientID, Client.ClientLastName, Client.ClientFirstName
		RETURN @CurrentBalance
END

go


CREATE VIEW ClientCourtCaseAssignments

		AS
		SELECT *
			   , dbo.CurrentCaseCount(ClientCourtCaseID) AS ClientStats
		
	FROM ClientCourtCase

go

SELECT * FROM ClientCourtCaseAssignments

go





SELECT * FROM Client


--fin