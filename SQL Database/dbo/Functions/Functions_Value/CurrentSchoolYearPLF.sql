

-- drop function  dbo.CurrentSchoolYearPLF  (getdate())
CREATE FUNCTION [dbo].[CurrentSchoolYearPLF] 
( 
  @date datetime 
)  
RETURNS varchar(8) 
AS  
BEGIN 
	return   [dbo].[Current.SchoolYear]('PLF') --   dbo.CurrentSchoolYear2( @date , 6, 14)
End
 
