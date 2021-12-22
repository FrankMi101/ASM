CREATE FUNCTION dbo.Application (@application_id char(20))
RETURNS varchar(50)
AS 
  BEGIN
  	declare @rValue varchar(50)
  	set @rValue = (SELECT  top 1 application 
			FROM  	tcdsb_security_applications
        	        WHERE   application_id = @application_id)
  	set @rValue = isnull(@rValue,' ') 
  	RETURN(@rValue)
  END
