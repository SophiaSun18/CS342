USE AdventureWorks2017
GO

DELETE FROM Sales.SalesOrderHeader
	Where SalesOrderId > 75123
GO

DECLARE @@MYCOUNTER INT
SET @@MYCOUNTER = 0;

WHILE @@MYCOUNTER < 8
BEGIN
	Insert into Sales.SalesOrderHeader (
		AccountNumber
		,BillToAddressID
		,Comment
		,CreditCardApprovalCode
		,CreditCardID
		,CurrencyRateID
		,CustomerID
		,DueDate
		,Freight
		,ModifiedDate
		,OnlineOrderFlag
		,OrderDate
		,PurchaseOrderNumber
		,RevisionNumber
		,rowguid
		,SalesPersonID
		,ShipDate
		,ShipMethodID
		,ShipToAddressID
		,Status
		,SubTotal
		,TaxAmt
		,TerritoryID
		)
	Select 
			AccountNumber
			,BillToAddressID
			, convert(varchar(10),Round(rand(CustomerId + 4) * 2000,1)) 
			  + '  ' + Convert(varchar(10),Round(rand(CustomerId + 2) * 2000,1))
			  + '  ' + Convert(varchar(10),Round(rand(CustomerId + 1000) * 2000,1))
			  + '  ' + Convert(varchar(10),Round(rand(CustomerId + 1000) * 2000,1))
			  + '  ' + Convert(varchar(10),Round(rand(CustomerId + 3000) * 2000,1))
			  + '  ' + Convert(varchar(10),Round(rand(CustomerId + 300) * 2000,1))
			,CreditCardApprovalCode
			,CreditCardID
			,CurrencyRateID
			,CustomerID
			,DueDate
			,Freight
			,ModifiedDate
			,OnlineOrderFlag
			,OrderDate
			,PurchaseOrderNumber
			,RevisionNumber
			,newid()
			,SalesPersonID
			,ShipDate
			,ShipMethodID
			,ShipToAddressID
			,Status
			,SubTotal
			,TaxAmt
			,TerritoryID
		From Sales.SalesOrderHeader
	SET @@MYCOUNTER = @@MYCOUNTER + 1
	PRINT 'Finished copy ' + CONVERT(CHAR(1),@@MYCOUNTER) + ' of table.'
END

select count(*) from sales.SalesOrderHeader