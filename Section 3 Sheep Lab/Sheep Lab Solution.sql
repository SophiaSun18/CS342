-- Sheep homework possible solutions
--

--2
create database sheep;
GO

--3
use sheep
go

--4
create schema ActiveHerd
GO

--5 through 7
create table [ActiveHerd].[sheep](
	idNumber int identity(1,1) ,
	SheepName varchar(30),
	BreedCategory char(1) NOT NULL,
	Gender	char(1) NOT NULL,
	ShepherdId int NOT NULL,
	CONSTRAINT [PK_sheepID] PRIMARY KEY ([idNumber])
);
GO

create table [ActiveHerd].[breed](
	BreedCategory char(1),
	BreedDescriptions varchar(30)
	CONSTRAINT [PK_breedID] PRIMARY KEY ([BreedCategory])
);
GO

create table [ActiveHerd].[sheepShots](
	idNumber int,
	ShotType char(1) NOT NULL,
	ShotDate datetime NOT NULL,
	InjectionType char(1) NOT NULL,
	CONSTRAINT [PK_shotID] PRIMARY KEY ([idNumber],[ShotType],[ShotDate])
);
GO

create table [ActiveHerd].[shotList] (
	ShotType char(1) PRIMARY KEY,
	shotDescription varchar(40),
	dayCycle int NOT NULL
);
GO

create table [ActiveHerd].[injectionList](
	InjectionType char(1),
	InjectionDescription varchar (30),
	CONSTRAINT [PK_injectType] PRIMARY KEY ([InjectionType])
);
GO

create table [ActiveHerd].[shepherd](
	ShepherdID int identity,
	LastName varchar(30) NOT NULL,
	FirstName varchar(30) NOT NULL,
	ShepherdCertification bit NOT NULL,
	CONSTRAINT [PK_shepherdID] PRIMARY KEY ([ShepherdID])
);
GO


ALTER TABLE [ActiveHerd].[sheep]
ADD CONSTRAINT [FK_sheepBreed ] FOREIGN KEY(BreedCategory)
	REFERENCES [ActiveHerd].[breed](BreedCategory);

ALTER TABLE [ActiveHerd].[sheep]
ADD CONSTRAINT [FK_shepherd ] FOREIGN KEY(ShepherdID)
	REFERENCES [ActiveHerd].[shepherd](ShepherdID);

ALTER TABLE [ActiveHerd].[sheepShots]
ADD CONSTRAINT [FK_sheepShot ] FOREIGN KEY(idNumber)
	REFERENCES [ActiveHerd].[sheep](idNumber);

ALTER TABLE [ActiveHerd].[sheepShots]
ADD CONSTRAINT [FK_sheepShotType ] FOREIGN KEY(ShotType)
	REFERENCES [ActiveHerd].[shotList](ShotType);

ALTER TABLE [ActiveHerd].[sheepShots]
ADD CONSTRAINT [FK_sheepShotInjection ] FOREIGN KEY(InjectionType)
	REFERENCES [ActiveHerd].[injectionList](InjectionType);

GO

--8
insert into [ActiveHerd].[shotList](ShotType, shotDescription,dayCycle)
	VALUES (1, 'Parvo', 100);
insert into [ActiveHerd].[shotList](ShotType, shotDescription,dayCycle)
	VALUES (2, 'Parvo2', 130);
insert into [ActiveHerd].[shotList](ShotType, shotDescription,dayCycle)
	VALUES (3, 'Parvo3', 102);
insert into [ActiveHerd].[injectionList] (InjectionType, InjectionDescription)
	VALUES ('E', 'Oral Injection');
insert into [ActiveHerd].[injectionList] (InjectionType, InjectionDescription)
	VALUES ('B', 'IV');
insert into [ActiveHerd].[injectionList] (InjectionType, InjectionDescription)
	VALUES ('C', 'SQ');

insert into [ActiveHerd].[shepherd](LastName, FirstName, ShepherdCertification)
	VALUES ('Bailey', 'Pat', 1);

insert into [ActiveHerd].[shepherd](LastName, FirstName, ShepherdCertification)
	VALUES ('Jones', 'Mary', 1);


insert into [ActiveHerd].[shepherd](LastName, FirstName, ShepherdCertification)
	VALUES ('Matthers', 'Jerry', 0);

insert into [ActiveHerd].[breed] (BreedCategory, BreedDescriptions)
    VALUES ('B', 'Big one');
insert into [ActiveHerd].[breed] (BreedCategory, BreedDescriptions)
    VALUES ('M', 'Medium one');
insert into [ActiveHerd].[breed] (BreedCategory, BreedDescriptions)
    VALUES ('L', 'Little one');

insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
	VALUES ('Molly', 'L', 'M', 2);
insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
	VALUES ('Molly', 'L', 'M', 2);
insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
	VALUES ('Molly', 'L', 'M', 2);
GO

--9 
--Using Join for Insert.  In this case only shots that themselves
--are Oral Injections  
INSERT INTO [ActiveHerd].[sheepShots] (
	idNumber
	, ShotType
	, ShotDate
	, InjectionType)
		SELECT s.idNumber
		, h.ShotType
		,getdate() 
		,t.InjectionType 
		FROM [ActiveHerd].sheep s
			, [ActiveHerd].shotlist h
			,[ActiveHerd].InjectionList t
			Where t.InjectionDescription = 'Oral Injection';  
		--Product of only sheep and shotlist 

-- 9 alternative
--Using SUBSELECT for Insert, depends on interpretation of instruction
--INSERT INTO [ActiveHerd].[sheepShots] (
--	idNumber
--	, ShotType
--	, ShotDate
--	, InjectionType)
--		SELECT s.idNumber
--		, h.ShotType
--		,getdate() 
--		,(SELECT InjectionType From [ActiveHerd].InjectionList 
--			Where InjectionDescription = 'Oral Injection')
--		FROM [ActiveHerd].sheep s, [ActiveHerd].shotlist h;  
--		--Product of only sheep and shotlist

		
--10
UPDATE [ACtiveHerd].[sheepShots]
SET ShotDate = '2020-02-03'		

--11
select *  from [ActiveHerd].[sheepShots]
select *  from [ActiveHerd].[sheep]
select *   from [ActiveHerd].[shotList]
select *   from [ActiveHerd].[injectionList]
select *   from [ActiveHerd].[shepherd]
select *  from [ActiveHerd].[breed]
GO

--12
-- DELETE FROM [ActiveHerd].[sheep]
-- Did not work because of dependency

--13 and 14
DELETE  from [ActiveHerd].[sheepShots]
DELETE  from [ActiveHerd].[sheep]
DELETE  from [ActiveHerd].[shotList]
DELETE  from [ActiveHerd].[injectionList]
DELETE  from [ActiveHerd].[shepherd]
DELETE  from [ActiveHerd].[breed]
GO

--16
DROP TABLE [ActiveHerd].[sheepShots]
DROP TABLE  [ActiveHerd].[sheep]
DROP TABLE  [ActiveHerd].[shotList]
DROP TABLE  [ActiveHerd].[injectionList]
DROP TABLE  [ActiveHerd].[shepherd]
DROP TABLE  [ActiveHerd].[breed]
GO
--17
use master
GO

DROP Database sheep
GO
