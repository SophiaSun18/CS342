-- Sheep Homework
-- Student Name: ZeAi Sun

--2
create database sheep
go

--3
use sheep
go

--4
create schema ActiveHerd
go

--5 through 7
create table [ActiveHerd].[sheep] (
	IdNumber int identity(1, 1),
	SheepName varchar(30),
	BreedCategory char(1) NOT NULL,
	Gender char(1) NOT NULL,
	ShepherdId int NOT NULL,
	constraint pk_sheepID primary key (IdNumber),
);
go

create table [ActiveHerd].[breed] (
	BreedCategory char(1) NOT NULL,
	BreedDescription varchar(50),
	constraint pk_Bcat primary key (BreedCategory)
);
go

create table [ActiveHerd].[sheepShots] (
	IdNumber int NOT NULL,
	ShotType varchar(20) NOT NULL,
	ShotDate DATE NOT NULL,
	InjectionType varchar(30)
	constraint [pk_ID, pk_shotType, pk_shotDate] primary key (IdNumber, ShotType, ShotDate)
);
go

create table [ActiveHerd].[shotList] (
	ShotType varchar(20) NOT NULL,
	shotDescription varchar(50),
	dayCycle int NOT NULL,
	constraint pk_sType primary key (ShotType),
);
go

create table [ActiveHerd].[injectionList] (
	InjectionType varchar(30) NOT NULL,
	injectionDescription varchar(50),
	constraint pk_iType primary key (InjectionType),
);
go

create table [ActiveHerd].[shepherd] (
	ShepherdId int NOT NULL,
	LastName varchar(20) NOT NULL,
	FirstName varchar(20) NOT NULL,
	ShepherdCertification varchar(10) NOT NULL,
	constraint pk_shepherdID primary key (ShepherdId)
);
go

alter table [ActiveHerd].[sheep]
	add constraint fk_BCat foreign key (BreedCategory) references [ActiveHerd].[breed](BreedCategory);
go

alter table [ActiveHerd].[sheep]
	add constraint fk_shepherdID foreign key (ShepherdId) references [ActiveHerd].[shepherd](ShepherdId);
go

alter table [ActiveHerd].[sheepShots]
	add constraint fk_ID foreign key (IdNumber) references [ActiveHerd].[sheep](IdNumber);
go

alter table [ActiveHerd].[sheepShots]
	add constraint fk_shotType foreign key (ShotType) references [ActiveHerd].[shotList](ShotType);
go

alter table [ActiveHerd].[sheepShots]
	add constraint fk_injectionType foreign key (InjectionType) references [ActiveHerd].[injectionList](InjectionType);
go

--8

-- insert into [ActiveHerd].[sheep]

insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
values ('Alice', 'A', 'F', 3)
go

insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
values ('Billy', 'B', 'M', 1)
go

insert into [ActiveHerd].[sheep] (SheepName, BreedCategory, Gender, ShepherdId)
values ('Caleb', 'C', 'M', 2)
go

-- insert into [ActiveHerd].[breed]

insert into [ActiveHerd].[breed] (BreedCategory, BreedDescription)
values ('A', 'This group is defined as breed A.')
go

insert into [ActiveHerd].[breed] (BreedCategory, BreedDescription)
values ('B', 'This group is defined as breed B.')
go

insert into [ActiveHerd].[breed] (BreedCategory, BreedDescription)
values ('C', 'This group is defined as breed C.')
go

-- insert into [ActiveHerd].[shotList]

insert into [ActiveHerd].[shotList] (ShotType, shotDescription, dayCycle)
values ('Parvo', 'This shot is named Parvo.', 15)
go

insert into [ActiveHerd].[shotList] (ShotType, shotDescription, dayCycle)
values ('CDT', 'This shot is named CDT.', 20)
go

insert into [ActiveHerd].[shotList] (ShotType, shotDescription, dayCycle)
values ('Pasteurella', 'This shot is named Pasteurella.', 30)
go

-- insert into [ActiveHerd].[injectionList]

insert into [ActiveHerd].[injectionList] (InjectionType, injectionDescription)
values ('Oral Injection', 'This injection is injected orally.')
go

insert into [ActiveHerd].[injectionList] (InjectionType, injectionDescription)
values ('Subcutaneous', 'This injection is Subcutaneous.')
go

insert into [ActiveHerd].[injectionList] (InjectionType, injectionDescription)
values ('IV', 'This injection is IV.')
go

-- insert into [ActiveHerd].[shepherd]

insert into [ActiveHerd].[shepherd] (ShepherdId, LastName, FirstName, ShepherdCertification)
values (1, 'Miller', 'Marty', 'True')
go

insert into [ActiveHerd].[shepherd] (ShepherdId, LastName, FirstName, ShepherdCertification)
values (2, 'Dennis', 'Ginger', 'False')
go

insert into [ActiveHerd].[shepherd] (ShepherdId, LastName, FirstName, ShepherdCertification)
values (3, 'Tyler', 'Lisa', 'True')
go

--9
insert into [ActiveHerd].[sheepShots] (IdNumber, ShotType, ShotDate, InjectionType)
select s.IdNumber,
	sList.ShotType,
	getdate(),
	'Oral Injection'
from [ActiveHerd].[sheep] s, [ActiveHerd].[shotList] sList
go

--10
update [ActiveHerd].[sheepShots]
set ShotDate = cast('2023-02-03' as date)
go

--11
select * from [ActiveHerd].[sheep]
go

select * from [ActiveHerd].[breed]
go

select * from [ActiveHerd].[sheepShots]
go

select * from [ActiveHerd].[shotList]
go

select * from [ActiveHerd].[injectionList]
go

select * from [ActiveHerd].[shepherd]
go

--12
delete from [ActiveHerd].[sheep]  --success, 3 rows are deleted
go

--14
drop table [ActiveHerd].[shepherd]  -- the instruction says "drop their records", so I assume I should use drop to delete the whole table.
go

--16
drop table [ActiveHerd].[sheep]
go

drop table [ActiveHerd].[shotList]
go

drop table [ActiveHerd].[breed]
go

drop table [ActiveHerd].[sheepShots]
go

drop table [ActiveHerd].[injectionList]
go

--17
drop database sheep
go