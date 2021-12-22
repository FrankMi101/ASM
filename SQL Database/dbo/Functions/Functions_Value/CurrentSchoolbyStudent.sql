-- drop function dbo.CurrentSchoolbyStudent
CREATE FUNCTION  [dbo].[CurrentSchoolbyStudent] 
( 
  @Schoolyear varchar(8),	
  @PersonID  varchar(13) 
)  
RETURNS varchar(8) 
AS  
BEGIN 
   declare @rValue varchar(8)
   begin 
		set @rValue = ( select  top 1 school_code	
						from dbo.tcdsb_SES_Students		
						where school_year =@Schoolyear and person_id = @PersonID
						order by Status )
 
     	set @rValue = isnull(@rValue,'0000')
   end

return @rValue

END 