
 
-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 07, 2021  
-- Description:	 get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.Report] 
(@ActionType	varchar(20),
@UserID		varchar(30),
@UserRole	varchar(30),
@SchoolYear varchar(8),
@SchoolCode varchar(8),
@Category	varchar(20),
@ObjID		varchar(20),
@ObjName	varchar(150),
@ObjTitle	varchar(250),
@ObjType	varchar(50)

)
RETURNS  varchar(500) 
AS 
  BEGIN
     declare @rValue varchar(500) ,  @P varchar(7), @Para varchar(300) 
	 set @ObjTitle = replace(@ObjTitle, '''','`')
 	 set  @p =''','''
	set @Para = @UserRole + @P +  @SchoolYear + @P + @SchoolCode  + @P +  @ObjID  + @P +  @ObjName   + @P + @ObjTitle + @P + @ObjType + @P + @Category + @P +'800'+@P +'990'
	if @ActionType ='TaskMenu'
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenMenu(''' +   @Para +''')">'  
					   + '<img src="../images/menu3.png" border="0" width="18" height="14">' + '</a>'  

    else if @ActionType ='Report' 
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenReport(''' +   @Para +''')">'  
					   + '<img src="../images/report.png" border="0" width="18" height="14">' + '</a>'  
    else if @ActionType ='Parameter' 
		set @rValue =  '<a title= "click to open action Parameter Page"  href="javascript:OpenParameterPage(''' +   @Para +''')">'  
					   + '<img src="../images/menu3.png" border="0" width="18" height="14">' + '</a>'  

 	RETURN(@rValue)
  END
   
