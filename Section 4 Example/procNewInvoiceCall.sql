USE [AP]
GO

DECLARE	@return_value int,
		@balance money

EXEC	@return_value = [dbo].[procNewInvoice]
		@inVendorId = 110,
		@inInvNumber = N'A-1',
		@inAmount = 200,
		@inTerms = 1,
		@inDueDate = '2-2-2022',
		@currentlyOwed = @balance OUTPUT

SELECT	@balance as N'@currentlyOwed'

SELECT	'Return Value' = @return_value

GO
select * from tempdb..tally