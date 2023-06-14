--procNewInvoice
--
--Adds new vendor invoice to system
--RETURN
--  0 = Success
--  1 = Invalid Vendor
--  2 = Unknown
CREATE PROCEDURE procNewInvoice
@inVendorId int
,@inInvNumber varchar(50)
,@inAmount money
,@inTerms int
,@inDueDate date
,@currentlyOwed money OUTPUT
AS
BEGIN
    BEGIN TRY
		IF NOT EXISTS (SELECT 1 from Vendors 
				WHERE VendorId = @inVendorId)
		  RETURN 1

		INSERT INTO Invoices (VendorId
				,InvoiceNumber
				,InvoiceDate
				,InvoiceTotal
				,PaymentTotal
				,CreditTotal
				,TermsID
				,InvoiceDueDate)
				VALUES (
				@inVendorId
				,@inInvNumber
				,GETDATE()
				,@inAmount
				,0
				,0
				,@inTerms
				,@inDueDate )
		--get the total of all pending invoices
		SELECT @currentlyOwed =
		         SUM(InvoiceTotal - PaymentTotal)
		     FROM Invoices
			 WHERE VendorID = @inVendorId
	END TRY
	BEGIN CATCH
	     --Usually process the error information
		DECLARE @ErrorMessage NVARCHAR(4000);  
		DECLARE @ErrorSeverity INT;  
		DECLARE @ErrorState INT;  
  
		SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  

		RAISERROR (@ErrorMessage, -- Message text.  
               @ErrorSeverity, -- Severity.  
               @ErrorState -- State.  
               ); 
		 RETURN 2
	END CATCH
	
	RETURN 0
END