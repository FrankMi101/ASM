
CREATE FUNCTION  [dbo].[Current.School]  
(  @UserID  varchar(30),
  @Schoolyear varchar(8)	
)  
RETURNS varchar(8) 
AS  
BEGIN 
   declare @rValue varchar(8)
   begin 
		set @rValue = ( select  top 1 lu.LocationID 
						from dbo.tcdsb_RSecurity_LocationUsers lu 
						inner join dbo.tcdsb_RSecurity_Locations rl on rl.LocationID=lu.LocationID
						where userid=@UserID and rl.LocationType='School' and disable =0
						order by lu.LocationID )
        if (@rValue is null) or (@rValue='0000')
         	set @rValue = (select top 1 school_code from dbo.tcdsb_TPA_school_staff
							where UserID = @UserID order by school_year DESC)
 
     	set @rValue = isnull(@rValue,'0000')
   end

return @rValue

END
   
