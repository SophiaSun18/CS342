create procedure mycalc 
@input int,
@answer int output
as
BEGIN
   select @answer = @input * 
      (select count(*) from authors, titles)
   return 0
END
GO

--Exercise the SP

DECLARE @x int
DECLARE @rval int
EXEC @rval = mycalc @input = 2, @answer = @x output
select @x,@rval