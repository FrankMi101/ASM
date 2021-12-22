


-- =================================================================================
-- Author:		Frank Mi
-- Create date: Febarury 22, 2016
-- Description:get school are by school code from TAP table 
-- ===================================================================================

-- drop function    select dbo.Area ('0290', '20132014','ID')
CREATE Function [dbo].[School.Area]
(@SchoolCode varchar(8),
 @NameType varchar(20))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
    declare @SchoolArea varchar(10)
    select top 1 @SchoolArea = School_Area  from tcdsb_tpa_schools
    where school_code = @SchoolCode  and active_flag ='x'

	if @NameType ='Area'
	   set @rValue = @SchoolArea
    else if @NameType ='Superintendent'
	   set @rValue = (select top 1  LastName + ', ' + FirstName   from tcdsb_TPA_School_area where School_area = @SchoolArea)

    else if @NameType ='SuperArea'
	   set @rValue = (select top 1  School_Area + '--' + fName  from tcdsb_TPA_School_area where School_area = @SchoolArea)
	else if @NameType ='TrilliumArea'
		set @rValue = (select top 1 school_family_code from school_family_schools  
							where school_code = @SchoolCode and school_family_code like 'Area%')
	else if @NameType ='Ward' 
		 set @rValue = (select top 1  isnull(school_family_code, '') 
						From school_family_schools 
						where school_code = @SchoolCode  and school_family_code like( 'Ward%')
							)		  
	
    else
	   set @rValue = (select top 1  UserID   from tcdsb_TPA_School_area where School_area = @SchoolArea)
 		 
   set @rValue = isnull(@rValue,  '')

  Return(@rValue)
 
end 
 
