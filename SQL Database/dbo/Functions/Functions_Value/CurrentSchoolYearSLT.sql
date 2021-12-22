
create FUNCTION  [dbo].[CurrentSchoolYearSLT] 
( 
  @date datetime 
)  
RETURNS varchar(8) 
AS  
BEGIN 

declare @SchoolYear varchar(8)
set @SchoolYear ='20072008' 
return @SchoolYear

END






