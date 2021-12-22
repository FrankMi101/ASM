





 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.Grade] (@PersonID varchar(13),@SchoolYear varchar(8) )  
RETURNS varchar(2)
--- Frank Mi
--- March 03, 2017
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
      declare @rValue varchar(2)
	 
		set @rValue =  (  select top 1 grade  
						  from student_registrations
				          where person_id = @PersonID  and left(school_code,1) in('0','X','A') and school_year = @SchoolYear      
				          order by status_indicator_code  )
						   
       RETURN(@rValue)
  END



 















