


-- drop function dbo.StudentExcep
create FUNCTION [dbo].[Student.ISPProgram](
@SchoolYear char(8),
@SchoolCode  char(8), 
@PersonID char(13)  )
RETURNS varchar(100)
---@active   'Active'/'Inactive'/'PreReg'
AS 
BEGIN
  declare @rValue varchar(150)

  
if  exists ( select * from  tcdsb_Trillium_ISP_Students
			where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID )

	set @rValue = (select top 1 Full_name from tcdsb_Trillium_ISP_Students
							where school_year = @SchoolYear  and school_code = @SchoolCode and Person_id = @PersonID
							)
else
   set   @rValue = 'Non SE class'
  
  set @rValue = isnull(@rValue,'') 
  RETURN(@rValue)
END
 


