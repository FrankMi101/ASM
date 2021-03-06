




-- drop function  dbo.CurrentSchoolYear 
CREATE FUNCTION [dbo].[CurrentSchoolYearNext] 
( 
  @date datetime ,
  @YearType  varchar(10)
)  
RETURNS varchar(8) 
AS  
BEGIN 
declare @SchoolYear varchar(8)
declare @ThisYear int
declare @NextYear int
declare @PreviousYear int

--- set @schoolYear = (select Top 1 school_year from tcdsb_trillium_companion where user_id = dbo.userID())
--- if @SchoolYear is null
--   begin 
if @YearType ='Current'
   begin
		set @ThisYear=CAST(year(@date)as int)
		set @NextYear=@ThisYear+1
		set @PreviousYear=@ThisYear-1
		if month(@date)>8
    		set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
		else 
			if month(@date) = 8
				if day(@date)> 20
					set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
				else
    				set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))

			else
    			set @SchoolYear=CAST(@PreviousYear as varchar(4)) + CAST(@ThisYear as varchar(4))
  end
    
if @YearType ='Next'
   begin
		set @ThisYear=CAST(year(@date)as int)
		set @NextYear=@ThisYear+1
		set @PreviousYear=@ThisYear-1	 
		set @SchoolYear=CAST(@ThisYear as varchar(4)) + CAST(@NextYear as varchar(4))
	    
  end
      

return @SchoolYear

END


 

