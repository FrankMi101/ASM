

-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 13, 2017
-- Description:	get student age year by give a specific age
-- ===================================================================================



-- drop function dbo.StudentAge

CREATE FUNCTION [dbo].[Student.AgeYear]
(@PersonID  varchar(13), @Age int)
RETURNS varchar(4)
AS  
BEGIN  
-- Create by Frank 2008.11.19
   declare @currentDate smalldatetime
   set @currentDate = getdate()

	declare @cAge int , @cMonth int , @birthDate smalldatetime, @AgeYear varchar(4)
	set @birthDate =  [dbo].[Student.BirthDate](@PersonID) 
	set @cAge = year(@currentDate)- year(@birthDate)
	set @cMonth = month(@currentDate) - month(@birthDate)
	if @cMonth > 6   set @cAge = @cAge + 1 
  
     if @cAge - @Age  = 0 
		set @AgeYear =  year(@currentDate)
	 else
 		 set @AgeYear =  year(@currentDate) + @Age - @cAge

   RETURN @AgeYear   
end


