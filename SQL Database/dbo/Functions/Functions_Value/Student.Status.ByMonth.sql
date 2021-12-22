
 

 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.Status.ByMonth] (@PersonID char(13),@SchoolYear varchar(8), @Schoolcode varchar(8),@ReportMonth varchar(2))  
RETURNS varchar(20)
--- Frank Mi
--- March 11, 2021   
--- @perason_id  
 AS  
   BEGIN
        declare @rValue varchar(20), @reportYear varchar(4)
		if @ReportMonth >  9 
			set @reportYear = left(@Schoolyear,4)
		else
			set @reportYear = right(@Schoolyear,4)
		if exists(select * from  dbo.tcdsb_student_enrolment where report_year =@reportYear and report_month  = @ReportMonth and person_id = @PersonID)
			set @rValue = ( select top 1 case active_flag when 'x' then 'Active' else 'Inactive' end
							from dbo.tcdsb_student_enrolment 
							where report_year =@reportYear and report_month  = @ReportMonth and person_id = @PersonID
							)
		else
			set @rValue ='Unknow'
 

       RETURN isnull(@rValue,'Unknow')
  END



 

















