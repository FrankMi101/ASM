
CREATE FUNCTION dbo.StudentsTableToSchool (@SchoolCode char(4),  @Schoolyear char(8))
RETURNS TABLE 
AS 
   Return  
	SELECT   Distinct Person_id  AS Student_PersonID
                 From student_program_class_tracks  as S
                 Where school_code =@Schoolcode and school_year=@schoolYear 


