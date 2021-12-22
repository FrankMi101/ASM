


 

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.Title] 
(@Type	varchar(30),
@Action	varchar(20)
)
RETURNS  varchar(150) 
AS 
  BEGIN
		declare @rValue varchar(150)

 		set @rValue = case @Action	when 'TaskMenu'			then ' title= "click to open action menu" '
									when 'Report'			then ' title= "click to open report" '
									when 'TaskMenuGroup'	then ' title= "click to open item details" ' 
									when 'Delete'			then ' title= "click to delete selected item" ' 
									when 'Edit'				then ' title= "click to edit selected item " '
									when 'View'				then ' title= "click to view selected item " '
									when 'SubFun'			then ' title= "click to open item details" '
									When 'SubFunM'			then ' title= "click to open item details" '
									else  ' title= "click to open item details" ' End

 
 	RETURN(rtrim(@rValue))
  END
   

