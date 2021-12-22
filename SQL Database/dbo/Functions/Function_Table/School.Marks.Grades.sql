

-- ============================================================================
-- Author:		Frank Mi
-- Create date: June 3, 2021  
-- Description:	Get  School classess list by school  
-- =============================================================================  

CREATE FUNCTION [dbo].[School.Marks.Grades]
	(
		@SchoolYear	varchar(8),
		@SchoolCode	varchar(8) 
	 )
 
RETURNS @Grades  TABLE 
		(Grade_Code varchar(10),
		 Grade_Title varchar(50) 
		)
 
AS 
BEGIN 
if isnull(@SchoolCode,'0000') ='0000'
		insert into @Grades
		select '00' as course_code, 'All Grades' as course_title
		union
		select     distinct  Grade, 'Gr.' + Grade
		from  dbo.school_grades 
	   

	else
		insert into @Grades
		select '00' as course_code, 'All Grades' as course_title
		union
		select  distinct  Grade, 'Gr.' + Grade
		from   dbo.school_grades
		where    school_Code = @SchoolCode  

	return

	return

 End
  