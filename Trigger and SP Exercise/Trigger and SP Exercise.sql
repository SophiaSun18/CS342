-- ZeAi Sun

--1
create database AvLogs
go

--2
use AvLogs
go

--3
create table dbo.StateProvinceLog (
	[StateProvinceID] [int] IDENTITY(1,1) NOT NULL,
	[StateProvinceCode] [nchar](3) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[IsOnlyStateProvinceFlag] [bit] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[TerritoryID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ChangeType] [nchar](1) NOT NULL,
	[ChangeDate] [datetime] NOT NULL,
	[UserName] [nvarchar](30) NOT NULL)
go

--4
use AdventureWorks2017
go

--5
create trigger stPersonLog
	on AdventureWorks2017.Person.StateProvince
	for insert, update, delete
as
begin

-- The declare function consulted "https://stackoverflow.com/questions/6217484/sql-server-trigger-on-insert-delete-update-on-table".
declare @cType nchar(1) = 
	case when not exists (select * from inserted)
		then 'D'
	when not exists (select * from deleted)
		then 'I'
	else
		'U'
	end

if @cType = 'I' or @cType = 'U'
	insert into AvLogs.dbo.StateProvinceLog
	select
		StateProvinceCode,
		CountryRegionCode,
		IsOnlyStateProvinceFlag,
		Name,
		TerritoryID,
		ModifiedDate,
		@cType,
		getdate(),
		user_name()
	from inserted
if @cType = 'D' or @cType = 'U'
	insert into AvLogs.dbo.StateProvinceLog
	select
		StateProvinceCode,
		CountryRegionCode,
		IsOnlyStateProvinceFlag,
		Name,
		TerritoryID,
		ModifiedDate,
		@cType,
		getdate(),
		user_name()
	from deleted

end
go

--6
insert into [AdventureWorks2017].[Person].[StateProvince]
values ('BA', 'UM', 0, 'Bailey', 3, NEWID(), getdate())
go

update [AdventureWorks2017].[Person].[StateProvince]
set Name = 'Buckey'
where StateProvinceCode = 'BA'
go

delete from [AdventureWorks2017].[Person].[StateProvince]
where StateProvinceCode = 'BA'
go

select * from AvLogs.dbo.StateProvinceLog
go

--7
use AvLogs
go

--8, 9
create procedure procLogActivity (
@checkDate date,
@activeCount int output)
as
begin
select * from AvLogs.dbo.StateProvinceLog
	where ChangeDate >= @checkDate
set @activeCount = @@ROWCOUNT
end
go

--10
declare @returnCount int
declare @returnValue int
declare @curDate date
select @curDate = getdate()

exec @returnValue = procLogActivity 
	 @checkDate = @curDate,
	 @activeCount = @returnCount output
select @returnCount as returnCount, @returnValue as returnValue
go

--11
drop trigger stPersonLog on database
go

--12
use AdventureWorks2017
go

drop database AvLogs
go