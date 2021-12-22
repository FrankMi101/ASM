CREATE FUNCTION  [dbo].[CurrentSchool] 
( 
  @UserID  varchar(30),
  @Schoolyear varchar(8)	
)  
RETURNS varchar(8) 
AS  
BEGIN 
   declare @rValue varchar(8)
   begin 
		set @rValue = ( select  top 1 lu.LocationID 
						from tcdsb_RSecurity_LocationUsers lu 
						inner join tcdsb_RSecurity_Locations rl on rl.LocationID=lu.LocationID
						where userid=@UserID and rl.LocationType='School' and disable =0
						order by lu.LocationID )
        if (@rValue is null) or (@rValue='0000')
         	set @rValue = (select top 1 school_code from tcdsb_TPA_school_staff
							where UserID = @UserID order by school_year DESC)
 
     	set @rValue = isnull(@rValue,'0000')
   end

return @rValue

END
   