

-- =================================================================================
-- Author		: Frank Mi
-- Create date	: November 13, 2020
-- Description	: get student today age  by person id
-- ===================================================================================
 
-- select [dbo].[Student.BirthDate]('00881007658') 

CREATE FUNCTION [dbo].[Student.Age.Today]
(@PersonID  varchar(13)   
)
RETURNS int
AS  
BEGIN  
-- Create by Frank 2008.11.19
declare @BirthDate smalldatetime, @CountDate smalldatetime,  @cAge int ,  @cMonth int
 	set @BirthDate =  [dbo].[Student.BirthDate](@PersonID) 
	set @CountDate = getdate()

--set @cAge = year(@CountDate)- year(@birthDate)
--set @cMonth = month(@CountDate) - month(@birthDate)
--if @cMonth > 6   set @cAge = @cAge + 1 
 

    set @cAge =  DATEDIFF(YY, @BirthDate , @CountDate)
	if  DATEADD(YY, @cAge,  @BirthDate ) > @CountDate
		    set @cAge = @cAge - 1
    RETURN @cAge   

	  
end

