
CREATE FUNCTION [dbo].[Student.FTE] 
(@PersonID char(13),
@SchoolCode varchar(8),
@ReportYear varchar(4),
@ReportMonth varchar(2))  
RETURNS numeric(4,2)
AS  
BEGIN

declare @rValue  numeric(4,2)
if exists (select * from dbo.tcdsb_student_enrolment  where  school_code= @SchoolCode and report_year = @ReportYear and person_id = @PersonID  )
	  select @rValue=fte
	  from dbo.tcdsb_student_enrolment 
	  where  school_code= @SchoolCode and report_year= @ReportYear and person_id = @PersonID  --  and report_month=@ReportMonth
	  order by report_month DESC
else 
	set @rValue = 0.00


RETURN(@rValue)
END

