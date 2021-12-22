

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: December 02, 2020  
-- Description:	 get student list by class
-- =====================================================================================
CREATE FUNCTION [dbo].[Student.List.byGrade]
(	@Schoolyear varchar(8),
	@SchoolCode  varchar(8), 
	@Grade		 varchar(10)
) 

RETURNS @StudentList  TABLE 
		(School_year varchar(8),
		 school_code varchar(8),
		 Grade		 varchar(8),
		 Person_ID  varchar(13),
		 Status		varchar(10)
		)

AS 
BEGIN 
 
			insert into @StudentList
			select distinct  School_year, school_code, Grade, Person_id,status_indicator_code
			from dbo.student_registrations  
 			where school_year = @Schoolyear and School_code = @SchoolCode and Grade = @Grade  
				 --	and getdate()  between start_date and end_date   
 		 
     RETURN  
 

end
