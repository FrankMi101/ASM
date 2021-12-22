
CREATE FUNCTION [dbo].[Student.School] (@PersonID varchar(13),@SchoolYear varchar(8) )  
RETURNS varchar(4)
--- Frank Mi
--- March 03, 2017
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
      declare @rValue varchar(4)
	 
		set @rValue =  (  select top 1 school_code
						  from dbo.student_registrations
				          where person_id = @PersonID  and left(school_code,1) in('0','X','A','C') and school_year = @SchoolYear
						  order by case status_indicator_code when 'Active' then '1' when 'Inactive' then '3' else '2' end )
						   
       RETURN(@rValue)
  END
