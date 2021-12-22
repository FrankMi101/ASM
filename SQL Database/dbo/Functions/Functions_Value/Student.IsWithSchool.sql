

-- =================================================================================
-- Author:		Frank Mi
-- Create date: September 21, 2021  Extend  from dbo.tcdsb_Student_WithSchool
-- Description:	to Student with school status 
-- ===================================================================================
  
 /********************* Basic Info of Enrolments ***********************************************************************************************
	 select transaction_type_ind, description from dbo.transaction_types_desc where locale ='EN_CA'
	 select transaction_type_ind, description from dbo.transaction_types_desc where locale ='EN_CA'
	1	Entry		: Student first time entry TCDSB school / Student transfer from one school to other School (demit school --> entry school) /  Student departure from our board to other board and come back.
	2	Enrolment	: Student rollover from last year. No need Entry and Funding Records
	3	Funding		: Every Entry Record must have a Funding Record.
	4	Arrival		: Student must have a Arrival record every year and every school.
	5	Departure	: Student demit from one school to other school or other board 
	8	Share		:
	9	Transfer	: Tempary Record if a student transfer from one school to other school. between demit and accept 
 ****************************************************************************************************************** */  

CREATE Function [dbo].[Student.IsWithSchool]
(	@schoolYear varchar(8),
	@schoolCode varchar(8),
	@PersonID varchar(13),
	@CountDate datetime
)
RETURNS varchar(10)
as
begin 
	declare @rValue varchar(10),  @SchoolYearStartdate date, @EntryDate datetime, @DemitDate datetime

	if  exists ( select * from dbo.student_enrolments where  active_flag ='X' and  transaction_type_ind ='5' and school_year =@SchoolYear and school_code = @SchoolCode and Person_ID = @PersonID )
		begin
            set @EntryDate = (select top 1 effective_date from dbo.student_enrolments   
							where school_year = @SchoolYear and school_code = @SchoolCode and Person_ID = @PersonID and active_flag ='X' 
							and transaction_type_ind in  ('1','2','3','4')
							order by  effective_date  )
 
            set @DemitDate = (select top 1 effective_date from dbo.student_enrolments   
							 where school_year = @SchoolYear and school_code = @SchoolCode and Person_ID = @PersonID 
							and active_flag ='X' and transaction_type_ind = '5'
							order by  effective_date DESC)
		end		
	else
		begin
            set @EntryDate = (select top 1 effective_date from dbo.student_enrolments   
							where school_year =@SchoolYear and school_code = @SchoolCode and Person_ID = @PersonID 
							and active_flag ='X' and transaction_type_ind in ('1','2','3','4') order by  effective_date  )

            set  @SchoolYearStartdate = (select top 1 [start_date]  from dbo.school_years where school_year = @SchoolYear and school_code = @SchoolCode)
            set  @DemitDate =  (select top 1 [end_date]  from dbo.school_years where school_year = @SchoolYear and school_code = @SchoolCode)

            if @SchoolYearStartdate > GETDATE()    set @EntryDate = @CountDate  
		end	 

	 if @CountDate between @EntryDate and @DemitDate
			set @rValue ='Here' 
	 else 
			set @rValue ='Other'  
 
      Return(@rValue)

end 
