

-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 07, 2021
-- Description:	Get Student course marks average 
-- =================================================================================
 
Create FUNCTION [dbo].[Student.Mark.Average.Final](
@Type			varchar(30) = 'MarksAvg', -- '6Course', -- /Flag/Result/Progress/Name/Level/Class
@SchoolYear		varchar(8) ='20202021',
@SchoolCode		varchar(8), 
@PersonID		varchar(13)
)
RETURNS varchar(20)
AS 
BEGIN
	declare @rValue varchar(20)  , @CourseCount int , @TotalMark numeric(10,2), @Average numeric(8,2)
	declare @StudentMarcks as table (school_year varchar(8),school_code varchar(8), Course_code varchar(20),  Mark  numeric(8,2), Credit numeric(6,2) )

	-- Include Day school, Saturday school marks. highest marks always on top to pick up  

	if @Type = 'CourseCount'
		set @Average  = (select count(*) 
						 from [dbo].[tcdsb_Trillium_Students_Course_Marks_Final]
						 where School_year  = @SchoolYear and person_id = @PersonID and earned_credit_value > 0)
	else if @Type ='Credit'
		 set @Average  = (select sum (earned_credit_value)
						 from [dbo].[tcdsb_Trillium_Students_Course_Marks_Final]
						 where School_year  = @SchoolYear and person_id = @PersonID and earned_credit_value > 0)
	else if @Type = 'HighMark'
		 set @Average  = (select top 1 convert(decimal(6,0),Marks) 
						  from [dbo].[tcdsb_Trillium_Students_Course_Marks_Final]
						   where School_year  = @SchoolYear and person_id = @PersonID and earned_credit_value > 0
						   order by Marks  Desc)

	else if @Type = 'LowMark'
		 set @Average  = (select top 1 convert(decimal(6,0),Marks) 
						  from [dbo].[tcdsb_Trillium_Students_Course_Marks_Final]
						   where School_year  = @SchoolYear and person_id = @PersonID and earned_credit_value > 0
						   order by Marks )
	else if @Type ='MarksAvg'
		begin
 			insert into @StudentMarcks
 					select   school_year, school_code, course_code, convert(decimal(6,0),Marks),earned_credit_value 
 					from  [dbo].[tcdsb_Trillium_Students_Course_Marks_Final]
					where School_year  = @SchoolYear and person_id = @PersonID and earned_credit_value > 0				
	 
			set @CourseCount = (select count(*)  from @StudentMarcks)
			set @TotalMark = (select sum (Mark) from @StudentMarcks )
 			set @Average = @TotalMark / @CourseCount 

		end
 
  RETURN   @rValue

END

