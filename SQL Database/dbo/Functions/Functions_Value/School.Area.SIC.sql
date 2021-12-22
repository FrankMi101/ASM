


-- =================================================================================
-- Author:		Frank Mi
-- Create date: Febarury 22, 2016
-- Description:get school are by school code from TAP table 
-- ===================================================================================

-- drop function    select dbo.Area ('0290', '20132014','ID')
CREATE Function [dbo].[School.Area.SIC]
(@SchoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(50)
 
as
begin 
	declare @rValue varchar(50),  @SchoolArea varchar(20), @SuperID varchar(30)
	if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )  set @SchoolCode ='0533'  
	set @SchoolArea = (select top 1 school_area  from dbo.[SIC_sys_Schools] where school_code = @Schoolcode )
    set @rValue = (select top 1  userID from  dbo.SIC_sys_SchoolAreas where School_area = @SchoolArea)
 

	if @NameType ='Area'
	   set @rValue = @SchoolArea
    else if @NameType ='Superintendent'
	   set @rValue = (select top 1  LastName + ', ' + FirstName   from dbo.SIC_sys_SchoolAreas where School_area = @SchoolArea)

    else if @NameType ='SuperArea'
	   set @rValue = (select top 1  School_Area + '--' + fName  from dbo.SIC_sys_SchoolAreas where School_area = @SchoolArea)
    else
	   set @rValue = (select top 1  UserID   from dbo.SIC_sys_SchoolAreas where School_area = @SchoolArea)
 		 
   set @rValue = isnull(@rValue,  '')

  Return(@rValue)
 
end 
 
