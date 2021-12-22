
 
-- drop function  dbo.CurrentSchoolYearDay 
CREATE FUNCTION [dbo].[CurrentSchoolYearDay] 
( @Type varchar(20),
  @date datetime 
)  
RETURNS varchar(10) 
AS  
BEGIN 
declare @SchoolYear varchar(10)
declare @ThisYear int
declare @NextYear int
declare @PreviousYear int

--- set @schoolYear = (select Top 1 school_year from tcdsb_trillium_companion where user_id = dbo.userID())
--- if @SchoolYear is null
--   begin 
	set @ThisYear=CAST(year(@date)as int)
	set @NextYear=@ThisYear+1
	set @PreviousYear=@ThisYear-1
	if month(@date)>8
    		set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
	else 
		if month(@date) = 8
			if day(@date)> 25
				set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
			else
    			set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))

		else
    		set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))
--   end
if @Type ='FirstDay'
	set @SchoolYear = left(@SchoolYear,4) +'/09/01'
if @Type ='LastDay'
	set @SchoolYear = right(@SchoolYear,4) +'/08/30'

return @SchoolYear

END


 