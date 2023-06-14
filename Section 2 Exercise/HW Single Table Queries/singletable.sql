--ZeAi Sun

--1
use AP
GO

--2
select VendorState
     , VendorCity
     , VendorContactFName
     , VendorContactLName
     , VendorName
from Vendors
order by VendorState
       , VendorCity
       , VendorContactLName
       , VendorContactFName
GO

--3
select VendorContactLName + ', ' + VendorContactFName as [FullName]
from Vendors
where VendorState = 'OH'
order by VendorContactLName, VendorContactFName
GO

--4
select InvoiceTotal
     , InvoiceTotal * 0.25 as [25%]
     , InvoiceTotal * 1.25 as [Plus25%]
from Invoices
where InvoiceTotal - PaymentTotal - CreditTotal > 1000
order by InvoiceTotal desc
GO

--5
select VendorContactLName + ', ' + VendorContactFName as [FullName]
from Vendors
where VendorContactLName like 'A%' 
   or VendorContactLName like 'D%'
   or VendorContactLName like 'E%'
   or VendorContactLName like 'L%'
order by VendorContactLName, VendorContactFName
GO

select VendorContactLName + ', ' + VendorContactFName as [FullName]
from Vendors
where LEFT(VendorContactLName, 1) in ('A', 'D', 'E', 'L')
GO

--6
select *
from Invoices
where PaymentDate = NULL
and PaymentTotal != 0
GO

--7
select *
from Vendors
where DefaultTermsID = 3
GO

--8
select *
from Vendors
where DefaultTermsID = 3
and DefaultAccountNo >= 540
GO

--9
select *
from Vendors
where VendorName like '%Company%'
GO

--10
select distinct VendorState, LEFT(VendorPhone, 5) as [Prefix]
from Vendors
GO

--11
select distinct VendorState, LEFT(VendorPhone, 5) as [Prefix]
from Vendors
where VendorState != NULL
and VendorPhone != NULL
GO

--12
use pubs
GO

--13
select top 5 title, ytd_sales
from titles
order by ytd_sales desc
GO

--14
select title, ytd_sales / price as [Sold]
from titles
GO

--15
select top 3 title, ytd_sales / price as [Sold]
from titles
order by [Sold] desc
GO

--16
--The query is not followed by GO, so it might have issue if multiple queries are executed simutaneously.