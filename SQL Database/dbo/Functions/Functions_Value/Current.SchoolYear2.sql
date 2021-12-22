


-- =========================================================================
-- Author:		Frank Mi
-- Create date: August 22, 2017 
-- Description:	get current school year by new year month
-- =========================================================================
 
-- drop function  dbo.Current.SchoolYear 
CREATE FUNCTION [dbo].[Current.SchoolYear2] 
( @month int = 8,  
  @day int  = 25
)
RETURNS varchar(8) 
AS  
BEGIN 
    declare  @date datetime, @SchoolYear varchar(8)
	declare @ThisYear int, @NextYear int, @PreviousYear int

 	set @date = getdate()

	set @ThisYear=CAST(year(@date)as int)
	set @NextYear= @ThisYear+1
	set @PreviousYear=@ThisYear-1
	if month(@date)> @month
    		set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
	else 
		if month(@date) = @month
			if day(@date)>= @day
				set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
			else
    			set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))

		else
    		set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))
 

return @SchoolYear

END


