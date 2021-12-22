

CREATE FUNCTION [dbo].[Student.GetAgebyDate](@BirthDate smalldatetime, @CountDate smalldatetime)
RETURNS int
AS  
BEGIN  

declare @cAge int
declare @cMonth int
set @cAge = year(@CountDate)- year(@birthDate)
set @cMonth = month(@CountDate) - month(@birthDate)
if @cMonth > 6   set @cAge = @cAge + 1 
 
     RETURN @cAge   
end



