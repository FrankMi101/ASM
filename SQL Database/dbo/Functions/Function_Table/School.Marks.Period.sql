



-- ============================================================================
-- Author:		Frank Mi
-- Create date: June 3, 2021  
-- Description:	Get  School classess list by school  
-- =============================================================================  

CREATE FUNCTION [dbo].[School.Marks.Period]
	(
		@SchoolYear	varchar(8) = null,
		@SchoolCode	varchar(8) = null
	 )
 
RETURNS @Marks  TABLE 
		(Mark_code varchar(10),
		 Mark_title varchar(50) 
		)
 
AS 
BEGIN 
	if isnull(@SchoolCode,'0000') ='0000' 
		insert into @Marks
		select '0' as Mark_code, 'All Period' as Markcourse_title
		union
		select  distinct  report_period, report_period
		from  dbo.tcdsb_Trillium_Students_Course_Marks
		where  school_year = @SchoolYear and school_Code in ('0501','0569')  
	else
		insert into @Marks
		select '0' as Mark_code, 'All Period' as Mark_title
		union
		select  distinct  report_period, report_period
		from  dbo.tcdsb_Trillium_Students_Course_Marks
		where  school_year = @SchoolYear and school_Code = @SchoolCode  

	Return 
 End
  
