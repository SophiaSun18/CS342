--trInvAdd
--Each time an invoice is added, automatically
--add to permanent temp table
USE AP
GO

SET NOCOUNT ON
GO

CREATE Trigger trInvAdd
ON Invoices
FOR INSERT
AS
BEGIN
   if object_id('tempdb..tally') is NULL
       select 0 rt into tempdb..tally

    update tempdb..tally 
	     set rt = rt + (SELECT SUM(invoiceTotal)
		                  FROM inserted )
END
