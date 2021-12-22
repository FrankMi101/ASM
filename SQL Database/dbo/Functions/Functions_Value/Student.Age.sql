
-- =================================================================================
-- Author		: Frank Mi
-- Create date	: Janurary 10, 2017
-- Modfy		: by Frank at 2020/11/02 using Datediff 
-- Description	: get student age  by person id  and Count date
-- ===================================================================================
 
-- select [dbo].[Student.BirthDate]('00881007658') 

CREATE FUNCTION [dbo].[Student.Age]
(@PersonID  varchar(13), @CountDate smalldatetime  
)
RETURNS int
AS  
BEGIN  
-- Create by Frank 2008.11.19
declare @BirthDate smalldatetime, @cAge int ,  @cMonth int
 	set @BirthDate =  [dbo].[Student.BirthDate](@PersonID) 
--set @cAge = year(@CountDate)- year(@birthDate)
--set @cMonth = month(@CountDate) - month(@birthDate)
--if @cMonth > 6   set @cAge = @cAge + 1 
 

    set @cAge =  DATEDIFF(YY, @BirthDate , @CountDate)
	if  DATEADD(YY, @cAge,  @BirthDate ) > @CountDate
		    set @cAge = @cAge - 1
    RETURN @cAge   


	
 --declare @age int  --changed by Eva Au 2020-01-29

 --  set @age=datediff(year,@birthdate,@CountDate)
   
 --  if @CountDate<cast (cast(year(@CountDate) as varchar(4))+'/'+cast(month(@birthdate) as varchar(2))+'/'+cast(day(@birthdate) as varchar(2))  as datetime)
 --        set @age=@age-1
  
 --  return @age       
 
  --RETURN @cAge   
end

