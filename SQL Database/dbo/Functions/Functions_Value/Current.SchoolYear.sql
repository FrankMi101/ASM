






-- =========================================================================
-- Author:		Frank Mi
-- Create date: August 22, 2017 
-- Modify date:	Frank @2020/08/24 using [dbo].[Current.SchoolYear2] function 
-- Description:	get current school year by application
-- =========================================================================
 
-- drop function  dbo.Current.SchoolYear 
CREATE FUNCTION [dbo].[Current.SchoolYear] 
( @appID varchar(10)
)
RETURNS varchar(8) 
AS  
BEGIN 


	declare @month int, @day int , @date datetime

	set @month = Case @appID when 'LTO' then 6  when 'SES' then 8  when 'IEP' then 8  when 'SSF' then 8  when 'TPA' then 8 when 'Tri' then 6 else 8 end
	set @day   = Case @appID when 'LTO' then 12 when 'SES' then 22 when 'IEP' then 22 when 'SSF' then 22 when 'TPA' then 25  when 'Tri' then 15 else 25 end 

	return [dbo].[Current.SchoolYear2](@month,@day) 

	/*
	declare @SchoolYear varchar(8)
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
*/
END


 


