







 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.Status] (@Person_id char(13),@SchoolYear varchar(8), @Schoolcode varchar(8))  
RETURNS varchar(20)
--- Frank Mi
--- May 11, 2017   Modify by Frank @29018/05/15
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(20)
             if exists (select top 1  * from student_registrations  where   school_year = @SchoolYear and  school_code  = @Schoolcode and person_id = @person_id )
	              set @rValue = ( select top 1  status_indicator_code   from student_registrations    				
							      where school_year = @SchoolYear and  school_code  = @Schoolcode  and person_id = @person_id  
				                 order by school_year DESC , status_indicator_code)
	         else if exists (select top 1  * from student_registrations  where   school_year = @SchoolYear  and person_id = @person_id )
			      set @rValue = ( select top 1  status_indicator_code   from student_registrations    				
							      where school_year = @SchoolYear  and person_id = @person_id 
				                 order by school_year DESC , status_indicator_code)
			 else
				 set 	@rValue =''

       RETURN(@rValue)
  END



 

















