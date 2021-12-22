








 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Septmber 26, 2021 
-- Description	: get student action tasks based on the Student and User Role
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.ASM] 
(@Action	varchar(20),
@Type		varchar(20),
@IDs		varchar(10),
@SchoolYear varchar(8),
@SchoolCode varchar(8),
@AppID		varchar(20),
@ModelID	varchar(50),
@xID		varchar(200),
@xName		varchar(300),
@xType		varchar(20)
)
RETURNS  varchar(800) 
AS 
  BEGIN
     declare @rValue varchar(800) ,  @P varchar(7), @Para varchar(300) ,  @Title varchar(150), @Image varchar(150), @JS varchar(600)
 	 set  @p =''','''
	 set @xName = replace(@xName,'''','`')
 	 set @Para =   isnull(@Action,'') + @P +  isnull(@Type,'') + @P + isnull(@IDs,'') + @P +  isnull(@SchoolYear,'') + @P + isnull(@SchoolCode,'')  + @P + isnull(@AppID,'') + @P   + isnull(@ModelID,'')  + @P + isnull(@xID,'')  + @P + isnull(@xName,'') + @P + isnull(@xType,'') 
 
	 set @Title = case @Type when 'SAP'		then ' title= "click to open App Overwrite Role item details"'
							 when 'APP'		then ' title= "click to open App Group item details"'
							 when 'SIS'		then ' title= "click to open App SIS Class item details"' 
							 when 'Schools'	then ' title = "click to open Working on multiple school select"' 
							 else [dbo].[ActionTask.Title](@Type,@Action) end

 	 set @Image = [dbo].[ActionTask.Image](@Action) 

	 set @JS =  case @Action when 'TaskMenu' then ' href="javascript:OpenMenu(''' +    @Para +''')">' 
							 when 'Report'	 then ' href="javascript:OpenReport(''' +  @Para +''')">' 
							 when 'SubFun'	 then ' href="javascript:OpenSubPage(''' +  @Para +''')">' 
							 when 'SubFunM'	 then ' href="javascript:OpenSubPage(''' +  @Para +''')">' 
											 else ' href="javascript:OpenDetail(''' +  @Para +''')">'  end

	set @rValue =  '<a ' + @Title + @JS  + @Image + '</a>'    

 	RETURN(rtrim(@rValue))
  END
   

