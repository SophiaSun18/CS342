--1
use pubs
go

--2
select count(*)
from publishers
where state is null
go

--3
select top 1 price
from title
order by price DESC
go

--4
select s.*
t.name
from sales s inner join title t
    by s.id == t.id
go

--5
--this should be an inner join

--6
select s.name as "Store Name",
s.date as "Order Date",
s.qty as "Quantity",
t.title as "Title"
from sales s inner join title t
    by s.id == t.id
go

--7
select j.id,
j.des,
e.id,
e.lname + ", " + e.fname as Name
from employee e inner join job j
    by e.jobid == j.id
go

--8
select j.id,
j.des,
e.id,
e.lname + ", " + e.fname as Name
from employee e inner join job j
    by e.jobid == j.id
go

--9
???

--10
--when there's no employee name returned?

--11
use AP
go

--12
select v.name
from Vendors v inner join invoice i
    by v.id == i.VendorId
where v.invoice != null
go

--13
select InvoiceNumber,
InvoiceTotal
from Invoices
where PaymentTotal > ave(ave(PaymentTotal) - min(PaymentTotal))
go

--14
select i.InvoiceNumber,
i.InvoiceTotal,
v.VendorID,
count(*) ????
from Invoices i inner join Vendors v
    by v.id == i.VendorID
where PaymentTotal > ave(ave(PaymentTotal) - min(PaymentTotal))
go

--15
use AdventureWorks2017
go

--16

select count(*) as Num
min(BirthDate)
from Employees
go

--17
select employee
from Employees
where datediff(birthDate - getdate() > 52) as n --something like this

count(employee) * n

--18
???