




 

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: Sept 20, 2021  
-- Description:	 get Staff action tasks 
-- =====================================================================================

CREATE FUNCTION [dbo].[ActionTask.User] 
(@ActionType	varchar(20),
@UserID			varchar(30),
@UserRole		varchar(30),
@SchoolYear		varchar(8),
@SchoolCode		varchar(8),
@CPNum			varchar(10),
@EmployeeID		varchar(20),
@EmployeeName	varchar(50),
@EmployeeRole	varchar(10)
)
RETURNS  varchar(350) 
AS 
  BEGIN
     declare @rValue varchar(350) ,  @P varchar(7), @Para varchar(200) , @Image varchar(150),  @Title varchar(150), @JS varchar(100) 
 	 set  @p =''','''
 	 set @Image = [dbo].[ActionTask.Image](@ActionType) 
	 set @Title = [dbo].[ActionTask.Title]('',@ActionType)
  	 set @Para =  @UserID + @P +  @UserRole   + @P  +  @SchoolYear + @P + @SchoolCode + @P + @CPNum + @P + @EmployeeID  + @P + @EmployeeName  + @P + @EmployeeRole + @P + @ActionType

	 set @JS =  case @ActionType when 'TaskMenu' then ' href="javascript:OpenMenu(''' +  @Para +''')">' 
								 when 'Report'	 then ' href="javascript:OpenReport(''' +  @Para +''')">' 
												 else ' href="javascript:OpenUserProfilePage(''' +  @Para +''')">'  end


	set @rValue =  '<a ' + @Title + @JS  + @Image + '</a>'   
/*
	if @ActionType ='TaskMenu'
		set @rValue =  '<a ' + @Title + ' href="javascript:OpenMenu(''' +   @Para +''')">'    + @Image + '</a>'  

    else if @ActionType ='Report' 
		set @rValue =  '<a ' + @Title + ' href="javascript:OpenReport(''' +   @Para +''')">'    + @Image + '</a>'  
	else
 		set @rValue =  '<a ' +  @Title + @JS + '(''' +  @Para +''')">'  + @Image + '</a>'    
		
 --	else if @ActionType ='Edit'
 --			set @rValue =  '<a ' +  @Title + @JS + '(''' +  @Para +''')">'  + @Image + '</a>'    

	--else if @ActionType ='View'
 --			set @rValue =  '<a ' +  @Title + @JS + '(''' +  @Para +''')">'  + @Image + '</a>'    

	--else if @ActionType ='SubFun'
 --			set @rValue =  '<a ' +  @Title + @JS + '(''' +  @Para +''')">'  + @Image + '</a>'    

	--else if @ActionType ='SubFunM'
 	    
  --			set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenRoleMatchActionPage(''' +  @Para +''')">'  
	--				   + '<img src="../images/Edit.png" border="0" width="16" height="16">' + '</a>'  

 */
 	RETURN(@rValue)
  END
   

