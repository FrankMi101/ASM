




-- =================================================================================
-- Author:		Frank Mi
-- Create date: Janurary 10, 2017
-- Description:	get student age  by birth date  and Count date
-- ===================================================================================



CREATE FUNCTION [dbo].[Student.AgebyDate](@BirthDate smalldatetime, @CountDate smalldatetime)
RETURNS int
AS  
BEGIN  

declare @cAge int, @Years int
declare @cMonth int
--set @cAge = year(@CountDate)- year(@birthDate)
--set @cMonth = month(@CountDate) - month(@birthDate)
--if @cMonth > 6   set @cAge = @cAge + 1 
    set @cAge =  DATEDIFF(YY, @BirthDate , @CountDate)
	if  DATEADD(YY, @cAge,  @BirthDate )  > @CountDate
		    set @cAge = @cAge - 1
     RETURN @cAge   
end
 
