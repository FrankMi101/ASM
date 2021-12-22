
 

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.Image] 
(@Action	varchar(20)
)
RETURNS  varchar(150) 
AS 
  BEGIN
		declare @rValue varchar(150)

 		set @rValue = case @Action	when 'TaskMenu'			then '<img src="../images/menu3.png"	border="0" width="18" height="14">' 
									when 'Report'			then '<img src="../images/report.png"	border="0" width="18" height="14">' 
									when 'TaskMenuGroup'	then '<img src="../images/menu3.png"	border="0" width="18" height="14">' 
									when 'Delete'			then '<img src="../images/delete.png"	border="0" width="14" height="14">' 
									when 'Edit'				then '<img src="../images/Edit.png"		border="0" width="16" height="16">' 
									when 'View'				then '<img src="../images/Info.png"		border="0" width="16" height="16">' 
									when 'SubFun'			then '<img src="../images/submenu.png"	border="0" width="16" height="16">' 
									When 'SubFunM'			then '<img src="../images/submenu.png"	border="0" width="16" height="16">'  

									else '' End

 	RETURN(rtrim(@rValue))
  END
   

