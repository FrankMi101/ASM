
--  drop function dbo.StudentParents
CREATE FUNCTION [dbo].[Student.Enrolment.Name]( @Indicator char(1) )
RETURNS varchar(50) 
--- Frank Mi
--- March 04 2021.  
  
AS  
BEGIN
    declare @rValue  varchar(50) 
	set @rValue = case @Indicator	when '1'	then 'Entry'
									when '2'	then 'Enrolment'
									when '3'	then 'Funding'
									when '4'	then 'Arrival'
									when '5'	then 'Departure'
									when '8'	then 'Share'
									when '9'	then 'Transfer'
									else '' end
   RETURN(@rValue) 
END
