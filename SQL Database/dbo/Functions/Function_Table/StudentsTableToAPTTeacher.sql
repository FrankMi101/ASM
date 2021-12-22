
CREATE FUNCTION dbo.StudentsTableToAPTTeacher ( @Schoolyear char(8))
RETURNS TABLE 
AS 
   Return  
	SELECT   Distinct Person_id  AS Student_PersonID
                 From student_program_class_tracks  as S
                 Where school_year=@schoolYear  and school_code in (select distinct school_code from tcdsbvsecurity_list)
  
              
 

