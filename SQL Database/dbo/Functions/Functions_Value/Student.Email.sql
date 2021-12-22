
 
-- drop function PersonPhoneNumber

CREATE function [dbo].[Student.Email](@PersonID varchar(13))
returns varchar(50)
 
as
begin
	declare  @rValue varchar(50)
	set @rValue =  dbo.PersonEmailAddres(@PersonID,'Internet')
  
    RETURN(@rValue)
end
 
