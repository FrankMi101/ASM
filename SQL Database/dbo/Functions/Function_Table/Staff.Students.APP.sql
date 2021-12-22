

-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 13, 2021  
-- Description:	Get  Staff students list by school  
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Students.APP]
	(	@UserID		varchar(20) ,
		@AppID		varchar(10) ,
		@UserRole	varchar(20) ,
		@SchoolYear	varchar(8),
		@SchoolCode	varchar(8)
	 )
 
RETURNS @Students  TABLE 
		(School_year varchar(8),
		 school_code varchar(8),
		 student_no  varchar(15),
		 Grade		 varchar(10),
		 Status		 varchar(10),
		 scope_source		 varchar(50)
		)
 
AS 
BEGIN 
 
    declare @AssignedGroupType varchar(20) , @AccessScope varchar(20)
	set @AssignedGroupType = [dbo].[Staff.Assign.GroupType](@UserID,@AppID,@SchoolYear)

	set @AccessScope   = (select top 1  AccessScope from [dbo].[SIC_sys_UserRole]  where RoleID = @UserRole)


	if (@AccessScope = 'Board' or @AssignedGroupType ='Board')
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if (@AccessScope = 'Panel' or @AssignedGroupType ='Panel')
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  
		
	else if (@AccessScope = 'Area'  or @AssignedGroupType ='Area')
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if (@AccessScope = 'Feeders'  or @AssignedGroupType ='Feeders')
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if (@AccessScope = 'School'  or @AssignedGroupType ='School')
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	else if exists(select * from [dbo].[SIC_sys_MultipleSchool_User] where UserID = @UserID )
		begin
 			insert into @Students
			select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
			where  school_year = @SchoolYear and school_Code = @SchoolCode  
		end
   else 
 		insert into @Students
		select School_year, school_Code,student_no,grade,status, @AccessScope    from [dbo].[SIC_sys_Students]
		where  school_year = @SchoolYear and school_Code = @SchoolCode  
		and person_id in (	select person_id from [dbo].[SIC_sys_StudentClasses] 
							where school_year = @SchoolYear and school_Code = @SchoolCode 
							  and  class_code in ( select class_code from dbo.[Staff.Classes.APP](@UserID,@AppID,@UserRole,@SchoolYear,@SchoolCode) 
												 ) 
						 )
 	Return 
 End
 
