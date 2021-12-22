






 



-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 13, 2021  
-- Description:	Get  Staff classess list by school  
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Classes.APP]
	(	@UserID		varchar(20) ,
		@AppID		varchar(10) ,
		@UserRole	varchar(20) ,
		@SchoolYear	varchar(8),
		@SchoolCode	varchar(8)
	 )
 
RETURNS @Classes  TABLE 
		(School_year varchar(8),
		 school_code varchar(8),
		 Class_code  varchar(15) 
		)
 
AS 
BEGIN 
 
    declare @AssignedGroupType varchar(20) , @AccessScope varchar(20)
	set @AssignedGroupType = [dbo].[Staff.Assign.GroupType](@UserID,@AppID,@SchoolYear)

	set @AccessScope   = (select top 1  AccessScope from [dbo].[SIC_sys_UserRole]  where RoleID = @UserRole)


	if (@AccessScope in ('Board','Panel','Area') or @AssignedGroupType in ('Board','Panel','Area') )
 		insert into @Classes
		select School_year, school_Code, class_code from [dbo].[SIC_sys_SchoolClasses] 
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if (@AccessScope = 'Feeders'  or @AssignedGroupType ='Feeders')
 		insert into @Classes
		select School_year, school_Code, class_code from [dbo].[SIC_sys_SchoolClasses] 
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if exists(select * from [dbo].[SIC_sys_MultipleSchool_User] where UserID = @UserID )
 			insert into @Classes
			select School_year, school_Code, class_code from [dbo].[SIC_sys_SchoolClasses] 
			where  school_year = @SchoolYear and school_Code = @SchoolCode  
   else 
 			insert into @Classes
			select School_year, school_Code, class_code from 	dbo.SIC_sys_SchoolClassTeacher
			where  school_year = @SchoolYear and school_Code = @SchoolCode  and  UserID = @UserID  and isnull(class_code,'') !=''

 
	Return 
 End
  
