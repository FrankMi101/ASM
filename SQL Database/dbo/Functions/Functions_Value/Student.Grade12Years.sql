

-- =================================================================================
-- Author:		Frank Mi
-- Create date: April 26, 2016
-- Description:	get student Grade 12 years 
-- ===================================================================================

 

CREATE  FUNCTION [dbo].[Student.Grade12Years]
 (@PersonID varchar(13),
  @SchoolYear varchar(8),
  @Grade varchar(2) 
  )  
RETURNS  int 
  
AS  
   BEGIN
       declare @rValue int   

	  set @rValue = ( select  count(distinct school_year) from student_registrations 
	   where person_id =  @PersonID and grade = @Grade and school_year <= @SchoolYear and left(school_code,2) ='05'-- and Status_indicator_code='Active'
	   )
	 	set  @rValue = isnull(@rValue, 0)   
      RETURN(@rValue)
  END


