


-- =================================================================================
-- Author:		Frank Mi
-- Create date: January 05, 2021
-- Description:	get student class information  
-- ===================================================================================

CREATE FUNCTION [dbo].[Student.Class.Info] 
(@SchoolYear varchar(8),@SchoolCode varchar(8),@PersonID varchar(13),@ClassCode varchar(10), @Semster varchar(10),  @InfoType varchar(20) )  
RETURNS varchar(50)

AS  
   BEGIN
         declare @rValue varchar(50)
		if @InfoType ='Teacher'
			begin	
				select top 1 @rValue = [dbo].[Person.Name](reporting_teacher,'Full')
			 	from [dbo].[tcdsb_Trillium_School_Classes_All]  
 				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode and semester =   @Semster
			end
		else if @InfoType = 'Semester'
			begin
				select top 1 @rValue = Semester from [dbo].[tcdsb_Trillium_School_Classes_Term]
				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode 
			end
		else if @InfoType ='Terms'
			begin	
				declare @Terms SingleFieldTable
				insert into @Terms
				select distinct Term 
				from   [dbo].[tcdsb_Trillium_School_Classes_All]  
 				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode and semester =   @Semster and term_start < getdate()
				order by Term
				set @rValue = [dbo].[ConvertRecordsToString](@Terms,',' )

				--select top 1 @rValue = isnull(T1.term +',','') + isnull(T2.term +',','') + isnull(T3.term +',','') + isnull(T4.term +',','')
				--from [dbo].[tcdsb_Trillium_School_Classes_Term] as T1 
				--left join [dbo].[tcdsb_Trillium_School_Classes_Term] as T2 on T1.School_year =T2.School_year and T1.School_code =T2.School_Code and T1.Class_Code =T2.Class_code and T1.semester = T2.semester and T2.term ='2'
				--left join [dbo].[tcdsb_Trillium_School_Classes_Term] as T3 on T1.School_year =T3.School_year and T1.School_code =T3.School_Code and T1.Class_Code =T3.Class_code and T1.semester = T3.semester and T3.term ='3'
				--left join [dbo].[tcdsb_Trillium_School_Classes_Term] as T4 on T1.School_year =T4.School_year and T1.School_code =T4.School_Code and T1.Class_Code =T4.Class_code and T1.semester = T4.semester and T4.term ='4'
				--where T1.school_year = @SchoolYear and T1.school_code = @SchoolCode and T1.class_code = @ClassCode and T1.semester = @Semster and T1.term = '1'
			end
		else if @InfoType ='Periods'
			begin
				declare @Periods SingleFieldTable
				insert into @Periods
				select distinct school_period 
				from   [dbo].[tcdsb_Trillium_School_Classes_All]  
 				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode and semester =   @Semster  and term_start < getdate()
				order by school_period

				set @rValue = [dbo].[ConvertRecordsToString](@Periods,',' )
			end
		else if @InfoType ='Days'
			begin
				declare @Days SingleFieldTable
				insert into @Days
				select distinct school_cycle_day
				 from   [dbo].[tcdsb_Trillium_School_Classes_All]  
 				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode and semester =   @Semster  and term_start < getdate()
				order by school_cycle_day

				set @rValue = [dbo].[ConvertRecordsToString](@Days,',' )
			end
		else if @InfoType ='Room#'
			begin
				select top 1  @rValue = Room_no from [dbo].[tcdsb_Trillium_School_Classes_Room]
				where school_year = @SchoolYear and school_code = @SchoolCode and class_code = @ClassCode -- 'VAWD/S34M--B'
			end
 
       RETURN(@rValue)
  END

  /*

  select * from [dbo].[tcdsb_Trillium_School_Classes_All]   where school_year ='20202021' and school_code ='0531' and class_code ='HRE2O1-01'
 -- select * from dbo.student_program_class_tracks  where school_year ='20202021' and school_code ='0531'

select * from [dbo].[tcdsb_Trillium_School_Classes_Room]  where school_year ='20202021' and school_code ='0531' and class_code = 'HRE2O1-01'

select * from [dbo].[tcdsb_Trillium_School_Classes_Teacher] where school_year ='20202021' and school_code ='0531' and class_code = 'HRE2O1-01'


select * from [dbo].[tcdsb_Trillium_School_Classes_Term] where school_year ='20202021' and school_code ='0531' and class_code ='HRE2O1-01'



select * from [dbo].[tcdsb_Trillium_School_TimeLines]  where school_year ='20202021' and school_code ='0531' and class_code ='HRE2O1-01'


select * from [dbo].[tcdsb_Trillium_Student_TimeTable_currentSchoolyear]
where school_year ='20202021' and school_code ='0531' 
GO


select * from [dbo].[school_timeline_periods]
where school_year ='20202021' and school_code ='0531'

*/
