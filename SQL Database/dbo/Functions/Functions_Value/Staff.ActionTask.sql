








-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[Staff.ActionTask] 
(@ActionType	varchar(10),
@UserID		varchar(30),
@UserRole	varchar(30),
@SchoolYear varchar(8),
@SchoolCode varchar(20),
@Grade		varchar(50),
@CPNum		varchar(20),
@Name		varchar(50)
)
RETURNS  varchar(350) 
AS 
  BEGIN
     declare @rValue varchar(350) ,  @P varchar(7), @Para varchar(100) 
	 set @Name = replace(@Name, '''','`')
	 set  @p =''','''
	set @Para =  @SchoolYear + @P + @SchoolCode  + @P + @Grade + @P + @CPNum + @P + @CPNum + @P + @Name

	if @ActionType ='TaskMenu'
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenMenu(''' +   @Para +''')">'  
					   + '<img src="../images/menu3.png" border="0" width="20" height="16">' + '</a>'  
    else if @ActionType ='Report' 
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenReport(''' +   @Para +''')">'  
					   + '<img src="../images/report.png" border="0" width="20" height="16">' + '</a>'  
	else if @ActionType ='SMDetail'
		begin
			set @Para =  @SchoolYear + @P + @SchoolCode  + @P + @UserID + @P + @CPNum + @P + @Name
			set @rValue =  '<a title= "click to open Details content" target ="IframeFunction"  href="javascript:OpenSMDetails(''' +   @Para +''')">'  
					   + '<img src="../images/submenu.png" border="0" width="18" height="18">' + '</a>'  
 
		end
	else if @ActionType ='SubMenu'
		begin
			set @Para =  @SchoolYear + @P + @SchoolCode  + @P + @UserID + @P + @CPNum + @P + @Name
			set @rValue =  '<a title= "click to open Details content"  href="javascript:OpenSubMenu(''' +   @Para +''')">'  
					   + '<img src="../images/submenu.png" border="0" width="18" height="18">' + '</a>'  

		end

 	RETURN(@rValue)
  END
   

