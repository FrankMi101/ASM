





 

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: Sept 20, 2021  
-- Description:	 get Staff action tasks 
-- =====================================================================================

CREATE FUNCTION [dbo].[ActionTask.Staff] 
(@Action		varchar(20),
@Type			varchar(20),	
@UserID			varchar(30),
@UserRole		varchar(30),
@SchoolYear		varchar(8),
@SchoolCode		varchar(8),
@CPNum			varchar(10),
@StaffID		varchar(20),
@StaffName		varchar(50),
@StaffRole		varchar(10)
)
RETURNS  varchar(800) 
AS 
  BEGIN
   declare @rValue varchar(800) ,  @P varchar(7), @Para varchar(300) ,  @Title varchar(150), @Image varchar(150), @JS varchar(600)
    set  @p =''','''
 	set @Para =  @UserID + @P +  @UserRole   + @P  +  @SchoolYear + @P + @SchoolCode + @P + @CPNum + @P + @StaffID  + @P + @StaffName  + @P + @StaffRole + @P + @Action

	 set @Title = case @Type when 'SAP' then ' title= "click to open App Overwrite Role item details"'
							 when 'APP' then 'click to open App Group item details'
							 when 'SIS'	then 'click to open App SIS Class item details' 
							 else [dbo].[ActionTask.Title](@Type,@Action) end

 	 set @Image = [dbo].[ActionTask.Image](@Action) 

	 set @JS =  case @Action when 'TaskMenu' then ' href="javascript:OpenMenu(''' +    @Para +''')">' 
							 when 'Report'	 then ' href="javascript:OpenReport(''' +  @Para +''')">' 
							 when 'Edit'	 then ' href="javascript:OpenStaffActionPage(''' +  @Para +''')">' 
							 when 'View'	 then ' href="javascript:OpenStaffActionPage(''' +  @Para +''')">' 
							 when 'Delete'	 then ' href="javascript:OpenStaffActionPage(''' +  @Para +''')">' 
							 when 'SubFun'	 then ' href="javascript:OpenSubPage(''' +  @Para +''')">' 
							 when 'SubFunM'	 then ' href="javascript:OpenSubPage(''' +  @Para +''')">' 
											 else ' href="javascript:OpenDetail(''' +  @Para +''')">'  end

	set @rValue =  '<a ' + @Title + @JS  + @Image + '</a>'    



	--if @ActionType ='TaskMenu'
	--	set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenMenu(''' +   @Para +''')">'  
	--				   + '<img src="../images/menu3.png" border="0" width="18" height="14">' + '</a>'  

 --   else if @ActionType ='Report' 
	--	set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenReport(''' +   @Para +''')">'  
	--				   + '<img src="../images/report.png" border="0" width="18" height="14">' + '</a>'  


 --	else if @ActionType ='Edit'
 --			set @rValue =  '<a title= "click to open current item"  href="javascript:OpenStaffActionPage(''' +  @Para +''')">'  
	--				   + '<img src="../images/Edit.png" border="0" width="16" height="16">' + '</a>'  
	--else if @ActionType ='View'
 --			set @rValue =  '<a title= "click to open work multiple Schools list"  href="javascript:OpenStaffActionPage(''' +  @Para +''')">'  
	--				   + '<img src="../images/submenu.png" border="0" width="16" height="16">' + '</a>'  
	--else if @ActionType ='SubFun'
 --			set @rValue =  '<a title= "click to open user SAP profile details"  href="javascript:OpenStaffActionPage(''' +  @Para +''')">'  
	--				   + '<img src="../images/submenu.png" border="0" width="16" height="16">' + '</a>'  
	--else if @ActionType ='SubFunM'
 --			set @rValue =  '<a title= "click to open item details"  href="javascript:OpenStaffActionPage(''' +  @Para +''')">'  
	--				   + '<img src="../images/submenu.png" border="0" width="16" height="16">' + '</a>'  

 	RETURN(@rValue)
  END
   

