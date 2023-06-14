--1
Use pubs

--2
SELECT COUNT(*) as "Count"
FROM publishers
WHERE state is null

--3
SELECT max(price) as "Max Price"
FROM titles

--4
SELECT t.title
	,s.*
FROM titles t INNER JOIN sales s
  ON t.title_id = s.title_id

--5 Inner join

--6
SELECT st.stor_name  As "Store Name"
      , t.title  As Title
	  , s.ord_date As "Order Date"
	  , s.qty As "Quantity"
FROM titles t INNER JOIN sales s
  ON t.title_id = s.title_id
  INNER JOIN stores st
  ON s.stor_id = st.stor_id

--7
SELECT employee.job_id " JOB ID",
	   jobs.job_desc "JOB DESCRIPTION",
	   employee.emp_id "EMPLOYEE ID",
	   employee.lname + ',' + employee.fname  "EMPLOYEE NAME"
FROM jobs INNER JOIN employee
ON jobs.job_id = employee.job_id

--8
SELECT employee.job_id " JOB ID",
	   jobs.job_desc "JOB DESCRIPTION",
	   employee.emp_id "EMPLOYEE ID",
	   employee.lname + ',' + employee.fname  "EMPLOYEE NAME"
FROM jobs LEFT OUTER JOIN employee
ON jobs.job_id = employee.job_id

--9
--New Hire is not filled.  The employee attributes in the results are null.

--10
SELECT employee.job_id " JOB ID",
	   jobs.job_desc "JOB DESCRIPTION",
	   employee.emp_id "EMPLOYEE ID",
	   employee.lname + ',' + employee.fname  "EMPLOYEE NAME"
FROM jobs LEFT OUTER JOIN employee
ON jobs.job_id = employee.job_id
WHERE jobs.job_desc LIKE '%Executive%'
      OR jobs.job_desc LIKE '%Manager%'


--11
USE AP

--12
--12a
SELECT DISTINCT v.VendorName
FROM Vendors v INNER JOIN Invoices s
 ON v.VendorID = s.VendorID

--12b
SELECT  v.VendorName
FROM Vendors v
WHERE v.VendorID in
	(SELECT VendorID from Invoices)

--12c
SELECT  v.VendorName
FROM Vendors v
WHERE EXISTS
	(SELECT 1 from Invoices i
	   WHERE i.VendorID = v.VendorID)

--13
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE PaymentTotal >
     (SELECT AVG(PaymentTotal) - 
	       ( (AVG(PaymentTotal) - MIN(PaymentTotal))/2)
      FROM Invoices
      WHERE PaymentTotal <> 0);

--14

SELECT InvoiceNumber
	, InvoiceTotal
	, VendorID
	, InvCount
FROM Invoices INNER JOIN
  (SELECT VendorId as i
      , COUNT(*) InvCount
	  FROM Invoices
		GROUP BY VendorId) vi
	  on Invoices.VendorID = vi.i
WHERE PaymentTotal >
     (SELECT AVG(PaymentTotal) - 
	       ( (AVG(PaymentTotal) - MIN(PaymentTotal))/2)
      FROM Invoices
      WHERE PaymentTotal <> 0);

--15 No problem

--16
  USE AdventureWorks2017
  GO

  --17
SELECT   COUNT(*) AS 'Number of Employees'
         ,MIN(BirthDate) AS 'Oldest Person'
FROM HumanResources.Employee
GO

--18
--How Many Will Qualify and Cost
SELECT COUNT(*) AS 'Qualifying Number'
	, 12000 * COUNT(*) AS 'Qualifying Cost' 
FROM HumanResources.Employee 
WHERE (datediff(year, BirthDate, getdate())-52 >= 0 )
GO

--19
SELECT h.BirthDate
	,h.LoginId
	,h.BusinessEntityID
	,(((datediff(year, h.BirthDate,
					   getdate())- 52)* 10000)+120000) 
	AS 'Total Bonus' 
FROM HumanResources.Employee h 
WHERE (datediff(year, h.BirthDate, getdate())-52 >= 0 ) 
GO
