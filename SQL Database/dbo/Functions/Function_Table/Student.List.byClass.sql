
-- =====================================================================================
-- Author:		Frank Mi
-- Create date: December 02, 2020  
-- Description:	 get student list by class
-- =====================================================================================
CREATE FUNCTION [dbo].[Student.List.byClass]
(	@Schoolyear varchar(8),
	@SchoolCode  varchar(8), 
	@ClassCode   varchar(30)
) 

RETURNS @StudentList  TABLE 
		(School_year varchar(8),
		 school_code varchar(8),
		 Grade		 varchar(8),
		 Person_ID  varchar(13) )

AS 
BEGIN 
 
			insert into @StudentList
			select distinct SP.School_year,SP.school_code, SR.Grade,SP.Person_ID --, S.Grade --, S.Student_Name,
			from dbo.student_program_class_tracks  as SP
			inner join dbo.student_registrations   as SR on SP.school_year = SR.school_year and SP.school_Code =SR.school_code and SP.person_id = SR.person_id and SR.status_indicator_code !='Inactive'
   			-- where sp.school_year ='20202021' and SP.school_Code ='0531' and SP.class_code ='ADA1O1-01' 
			where SP.school_year = @Schoolyear and SP.School_code = @SchoolCode and SP.class_code = @ClassCode  
				 --	and getdate()  between start_date and end_date   
 		 
     RETURN  
 

end