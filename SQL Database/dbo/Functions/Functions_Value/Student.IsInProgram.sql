



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 check student is exists in program
-- =====================================================================================


CREATE FUNCTION [dbo].[Student.IsInProgram] 
(@Type		varchar(30),
@Program	varchar(50),
@SchoolYear varchar(8),
@SchoolCode varchar(20),
@Grade		varchar(10),
@personID	varchar(13),
@Term		varchar(10),
@Semester	varchar(10)
)
RETURNS  varchar(10) 
AS 
  BEGIN
     declare @rValue varchar(10)   
     if @Type ='IEP' 
		begin
			 if exists(select * from dbo.tcdsb_IEP_registration where person_id = @personID and school_year = @schoolyear  )
				set @rValue = 'true'
			 else
				set @rValue = 'false'
		end
     else if @type ='IPRC' 
		begin
			 if exists(select * from dbo.tcdsb_IEP_registration where person_id = @personID and school_year = @schoolyear and IEPReason ='0101' )
			   set @rValue = 'true'
			 else
				set @rValue = 'false'
		end
     else if @type ='SSN' 
		begin
			 if exists(select * from dbo.tcdsb_SSSN_Survey_Operation  where person_id = @personID and school_year = @schoolyear and completed ='9' and Type ='Operational' )
			   set @rValue = 'true'
			 else
				set @rValue = 'false'
		end
      else if @type ='ESL' 
		begin
			   set @rValue = 'false'
		end
    else if @type ='Gift' 
		begin
		   -- dbo.[tcdsb_eprc_gifted_program] has no index. the check the Alternative cause lost time  
		   set @rValue = 'false'
 		--	if exists(select * from [dbo].[tcdsb_eprc_gifted_program]  where school_year = @schoolyear and school_code = @SchoolCode and person_id = @personID and Term =@Term)
			--	set @rValue = 'true'
			--else
			--	set @rValue = 'false'
		end
    else if @type ='Autism' 
		begin
		   if exists(select * from dbo.tcdsb_IEP_registration where person_id = @personID and school_year = @schoolyear and IEPReason ='0101' and Excep1 ='010' )
			set @rValue = 'true'
			 else
				set @rValue = 'false'
		end
     else if @type ='Alternative' 
		begin
		   -- dbo.tcdsb_eprc_AlternateReportCard has no index. the check the Alternative cause lost time  
		   set @rValue = 'false'
			 -- if exists(select  * from dbo.tcdsb_eprc_AlternateReportCard where  school_year =  @schoolyear and school_code = @SchoolCode and person_id = @personID and Term = @Term   )
				--   set @rValue = 'true'
			 --else
				--set @rValue = 'false'
				 
		end
 	RETURN(@rValue)
  END



