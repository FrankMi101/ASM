


-- =========================================================================
-- Author:		Frank Mi
-- Create date: May 28, 2019 
-- Description:	get current school year From SSN Form
-- =========================================================================
 
-- drop function  dbo.Current.SchoolYear 
CREATE FUNCTION [dbo].[Current.SchoolYearSSN] 
( 
)
RETURNS varchar(8) 
AS  
BEGIN 
	declare @SchoolYear varchar(8)
 
	select top 1 @SchoolYear =  Working_SchoolYear  from  [dbo].[tcdsb_SSSN_WorkingStatus] 
	 where active ='X'

	return @SchoolYear

END


 

