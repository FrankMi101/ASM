




  

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: Mary 18, 2021  
-- Description:	 get student enrolment Edit action tasks 
-- =====================================================================================


CREATE FUNCTION [dbo].[ActionTask.Enrolment] 
(@Actions	varchar(20),
@GoPage		varchar(100),
@Target		varchar(50),
@Height		varchar(4),
@Width		varchar(4),
@UserID		varchar(30),
@UserRole	varchar(30),
@SchoolYear	varchar(8),
@SchoolCode	varchar(8),
@PersonID	varchar(13),
@TypeID		varchar(1), -- could be PageID
@EffectiveDate		varchar(10)
)
RETURNS  varchar(450) 
AS 
  BEGIN
     declare @rValue varchar(450) ,  @P varchar(7), @Para varchar(250) , @img varchar(100)
 	 set  @p =''','''
	 set @Para =  @Actions  + @P + @GoPage + @P + @Target + @P + @Height + @P + @Width
				+ @P + @UserID  + @P + @UserRole + @P + @SchoolYear + @P + @SchoolCode
				+ @P + @PersonID     + @P + @TypeID    + @P + @EffectiveDate
	 set 	@img = case @Actions	when 'Edit'		then '<img src="../images/Edit.png" border="0" width="16" height="16">'
									when 'Delete'	then '<img src="../images/delete.png" border="0" width="16" height="16">'
									when 'SubFun'	then '<img src="../images/submenu.png" border="0" width="16" height="16">'
									else '<img src="../images/menu3.png" border="0" width="18" height="14">' end

	if @Actions ='TaskMenu'
		set @rValue =  '<a title= "click to open action menu"  href="javascript:OpenMenu(''' + @Para +''')">' + @img + '</a>'  
	else 
		set @rValue =  '<a title= "click to open action page"  href="javascript:OpenAction(''' + @Para +''')">' + @img + '</a>'  
 

 	RETURN(@rValue)
  END
   

