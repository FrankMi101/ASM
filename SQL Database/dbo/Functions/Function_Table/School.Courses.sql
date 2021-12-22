
-- ============================================================================
-- Author:		Frank Mi
-- Create date: June 3, 2021  
-- Description:	Get  School classess list by school  
-- =============================================================================  

CREATE FUNCTION [dbo].[School.Courses]
	(
		@SchoolYear	varchar(8),
		@SchoolCode	varchar(8),
		@Include	varchar(1)
	 )
 
RETURNS @Classes  TABLE 
		(Course_Code varchar(20),
		 Course_Title varchar(200) 
		)
 
AS 
BEGIN 
	if isnull(@schoolCode,'0000' ) ='0000'

		insert into @Classes
		select '000' as course_code, 'All Courses' as course_title
		union
		select  distinct  course_code, course_title
		from  dbo.tcdsb_Trillium_Students_Course_Marks
		where  school_year = @SchoolYear and school_Code in ('0501','0544','0569')

	else
		begin
			insert into @Classes
			select '000' as course_code, 'All Courses' as course_title
			union
			select  distinct  course_code, course_title
			from  dbo.tcdsb_Trillium_Students_Course_Marks
			where  school_year = @SchoolYear and school_Code  = @SchoolCode

			if @Include ='Y'
				insert into @Classes
	 			select  distinct  course_code, course_title
				from  dbo.tcdsb_Trillium_Students_Course_Marks
				where  school_year = @SchoolYear and school_Code = '0569' and HomeSchool =   @SchoolCode
					and Course_code not in (select course_code from @Classes)

		end

			   
	Return 
 End
  
