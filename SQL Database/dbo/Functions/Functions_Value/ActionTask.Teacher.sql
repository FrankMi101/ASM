








-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.Teacher] 
(@ActionType	varchar(10),
@UserID		varchar(30),
@UserRole	varchar(30),
@SchoolYear varchar(8),
@SchoolCode varchar(20),
@CPNum		varchar(10),
@Name		varchar(250)
)
RETURNS  varchar(350) 
AS 
  BEGIN
     declare @rValue varchar(350) ,  @P varchar(7), @Para varchar(100) 
	 set @Name = replace(@Name, '''','`')
	 set  @p =''','''
	set @Para =   @SchoolYear + @P + @SchoolCode  + @P + @UserRole + @P + @CPNum + @P + @CPNum + @P + @Name
	if @ActionType ='TaskMenu'
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenMenu(''' +   @Para +''')">'  
					   + '<img src="../images/menu3.png" border="0" width="18" height="14">' + '</a>'  

    else if @ActionType ='Report' 
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenReport(''' +   @Para +''')">'  
					   + '<img src="../images/report.png" border="0" width="18" height="14">' + '</a>'  

 	RETURN(@rValue)
  END
   

