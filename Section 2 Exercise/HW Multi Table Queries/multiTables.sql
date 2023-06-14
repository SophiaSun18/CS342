--ZeAi Sun

--1
USE AP
GO

--2
SELECT *
FROM Vendors JOIN Invoices
	ON Vendors.VendorID = Invoices.VendorID
WHERE VendorCity = 'New York'
GO

--3
SELECT VendorName
	, InvoiceNumber
	, InvoiceDate
	, InvoiceTotal - PaymentTotal - CreditTotal AS Balance
FROM Vendors JOIN Invoices
	ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY Balance DESC
GO

--4
SELECT VendorName
	, VendorState
FROM Vendors
WHERE VendorState = 'CA'
UNION
SELECT VendorName
	, 'NY'
FROM Vendors
WHERE vendorState = 'NY'
UNION
SELECT VendorName
	, 'Neither'
FROM Vendors
WHERE VendorState <> 'CA'
	and VendorState <> 'NY'
ORDER BY VendorName
GO

--5
USE pubs
GO

--6
SELECT *
FROM authors
WHERE LEFT(phone, 3) = '801'
GO

--7
SELECT a.au_fname
	, a.au_lname
	, t.title
FROM authors a JOIN titleauthor ta
	ON a.au_id = ta.au_id
	JOIN titles t
	ON ta.title_id = t.title_id
WHERE LEFT(phone, 3) = '801'
GO

--8
SELECT 'Publisher' AS [Type]
	, pub_name AS [Name]
	, state AS [State]
FROM pubs.dbo.publishers
UNION
SELECT 'Vendor' AS [Type]
	, VendorName AS [Name]
	, VendorState AS [State]
FROM AP.dbo.vendors
GO

--9
SELECT DISTINCT a.au_lname + ', ' + a.au_fname AS [Author]
	, t.title AS [Title]
	, s.stor_name AS [Store Name]
	, s.state AS [Store State]
FROM authors a JOIN titleauthor ta
	ON a.au_id = ta.au_id
	JOIN titles t
	ON ta.title_id = t.title_id
	JOIN sales sa
	ON t.title_id = sa.title_id
	JOIN stores s
	ON s.stor_id = sa.stor_id
GO

--10
USE AdventureWorks2017
GO

--11
SELECT TOP 4 e.BusinessEntityID
	, e.LoginID
	, eph.Rate
	, eph.RateChangeDate
FROM HumanResources.Employee e JOIN HumanResources.EmployeePayHistory eph
	ON e.BusinessEntityID = eph.BusinessEntityID
ORDER BY eph.Rate DESC
GO

--12
SELECT e.BusinessEntityID
	, e.LoginID
	, ad.AddressLine1
FROM HumanResources.Employee e JOIN Person.BusinessEntityAddress ead
	ON e.BusinessEntityID = ead.BusinessEntityID
	JOIN Person.Address ad
	ON ead.AddressID = ad.AddressID
WHERE AddressLine1 = ''
GO