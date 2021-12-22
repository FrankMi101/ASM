
-- =================================================================================
-- Author:		Frank Mi
-- Create date: July 02, 2021
-- Description:	Get Student best 6 course marks average 
-- =================================================================================
 
CREATE FUNCTION [dbo].[Student.Mark.Average](
@Type			varchar(30) = '6Course', -- /Flag/Result/Progress/Name/Level/Class
@SchoolYear		varchar(8) ='20202021',
@SchoolCode		varchar(8), 
@PersonID		varchar(13)
)
RETURNS varchar(20)
AS 
BEGIN
	declare @rValue varchar(20)  , @CourseCount int , @TotalMark numeric(10,2), @Average numeric(8,2)
	declare @StudentMarcks as table (school_year varchar(8),school_code varchar(8), Course_code varchar(20),  Mark  numeric(8,2), Credit numeric(6,2) )

	-- Include Day school, Saturday school marks. highest marks always on top to pick up  

	if @Type = '6Course'
		insert into @StudentMarcks
  				select  top 6 school_year, school_code, course_code, convert(decimal(6,0),Marks) ,  earned_credit_value 
 				from [dbo].[tcdsb_Trillium_Students_Course_Marks_QualifiedCourse_ForCountTopStudents]
				where person_id = @PersonID and earned_credit_value > 0
 				order by marks desc, earned_credit_value
	else if @Type ='9Course'
		insert into @StudentMarcks
  				select  top 100   school_year, school_code, course_code, convert(decimal(6,0),Marks) , earned_credit_value 
 				from [dbo].[tcdsb_Trillium_Students_Course_Marks_QualifiedCourse_ForCountTopStudents]
				where person_id = '00011961376' and earned_credit_value > 0
 				order by marks desc, earned_credit_value
	
	else if @Type = 'AllCoures'
 		insert into @StudentMarcks
 				select   school_year, school_code, course_code, convert(decimal(6,0),Marks),earned_credit_value 
 				from [dbo].[tcdsb_Trillium_Students_Course_Marks_QualifiedCourse_ForCountTopStudents]
				where person_id = @PersonID and earned_credit_value > 0
 				order by marks desc, earned_credit_value
	else if @Type = 'YearCoures'
  		insert into @StudentMarcks
				select   school_year, school_code, course_code, convert(decimal(6,0),Marks) ,earned_credit_value 
  				from [dbo].[tcdsb_Trillium_Students_Course_Marks_QualifiedCourse_ForCountTopStudents]
				where school_year = @SchoolYear and person_id = @PersonID and earned_credit_value > 0
 				order by marks desc, earned_credit_value
	else if @Type = 'SchoolCoures'
		insert into @StudentMarcks
  				select  school_year, school_code,  course_code, convert(decimal(6,0),Marks) , earned_credit_value 
 				from [dbo].[tcdsb_Trillium_Students_Course_Marks_QualifiedCourse_ForCountTopStudents]
				where school_code = @SchoolCode and person_id = @PersonID and earned_credit_value > 0
 				order by marks desc, earned_credit_value


	set @CourseCount = (select count(*)  from @StudentMarcks)
    set @TotalMark = (select sum (Mark) from @StudentMarcks )
	set @Average = @TotalMark / @CourseCount 

   RETURN(@Average)
END

