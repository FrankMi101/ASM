


CREATE FUNCTION [dbo].[Student.HomeSchool] (@PersonID varchar(13) ,@Schoolyear varchar(8), @SchoolCode varchar(8) )  
RETURNS varchar(10)
WITH SCHEMABINDING

--- Frank Mi
--- Sept 9, 2020
--- @perason_id   
AS  
   BEGIN
      declare @rValue varchar(10)

	  if @SchoolCode in ('0469','0569')  
		-- set  @rValue = (select top 1 School_code from dbo.student_registrations where school_year ='20192020' and person_id =@PersonID  and left(school_code,2) in ('02','03','04','05','XI','AS') order by status_indicator_code )
		 set  @rValue = (select top 1 C_C2 from dbo.fs_student_custom where   person_id  = @PersonID   )
	  else
		 set @rValue = @SchoolCode
  
       RETURN(isnull(@rValue,@SchoolCode))
  END
   
