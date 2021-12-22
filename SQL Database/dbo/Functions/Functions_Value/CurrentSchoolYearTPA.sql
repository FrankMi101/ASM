



-- drop function    dbo.CurrentSchoolYearLTO  
CREATE FUNCTION [dbo].[CurrentSchoolYearTPA] 
( 
  @date datetime 
)  
RETURNS varchar(8) 
AS  
BEGIN 
	return   dbo.CurrentSchoolYear2( @date , 8, 24) --- '20182019' for test purpose --
End

/*
declare @SchoolYear varchar(8)
declare @ThisYear int
declare @NextYear int
declare @PreviousYear int

--- set @schoolYear = (select Top 1 school_year from tcdsb_trillium_companion where user_id = dbo.userID())
--- if @SchoolYear is null
--   begin 
	set @ThisYear=CAST(year(@date)as int)
	set @NextYear= @ThisYear + 1
	set @PreviousYear=@ThisYear- 1
	if month(@date)>6
    		set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
	else 
		if month(@date) = 6
			if day(@date)> 15
				set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
			else
    			set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))

		else
    		set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))
--   end


return @SchoolYear

END
*/

 




