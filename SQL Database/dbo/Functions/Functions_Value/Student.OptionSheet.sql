

 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.OptionSheet] (@PersonID varchar(13), @SchoolYear varchar(8), @SchoolCode varchar(8) )  
RETURNS varchar(20)
--- Frank Mi
--- March 118, 2016
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
            declare @rValue varchar(20)
	 
            if exists (select *  from [dbo].[student_course_requests]
						where school_year = @SchoolYear and school_code = @SchoolCode and person_id = @PersonID  )
				 set @rValue = 'Returning'
	        else if exists (select * from dbo.student_registrations
							where school_year = @SchoolYear and school_code = @SchoolCode and person_id = @PersonID ) 
                 set @rValue = 'No Option Sheet'
            else   
			     set @rValue = 'Not Returning'
	
 
       RETURN(@rValue)
  END


