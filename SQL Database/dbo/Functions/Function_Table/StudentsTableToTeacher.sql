
CREATE FUNCTION dbo.StudentsTableToTeacher (@TeacherID  char(13),  @SchoolCode char(4),  @Schoolyear char(8),@UserType char(10))
RETURNS TABLE 
AS 
     Return  
	        	SELECT   Distinct S.Person_id  AS Student_PersonID
                           From student_program_class_tracks  as S
	         	inner join term_teachers	   as T  on S.school_code = T.school_code
						and S.school_year = T.school_year
						and S.School_year_track = T.school_year_track
						and S.class_code = T.class_code
                     	where T.school_code =@Schoolcode and T.school_year=@schoolYear and T.person_id =@TeacherID
              
 
 

