




-- =====================================================================================
-- Author:		Frank Mi
-- Create date: November 27, 2020  
-- Description:	 get student tasks complete status
-- =====================================================================================


CREATE FUNCTION [dbo].[Student.Tasks.Completed] 
(@TaskType	varchar(20),
@SchoolYear varchar(8),
@SchoolCode varchar(8),
@personID	varchar(15)
)
RETURNS  varchar(20) 
AS 
  BEGIN
     declare @rValue varchar(20)  
	 set  @rValue = 'InCompleted'
	 if @TaskType ='IEPForm'
 			set @rValue = dbo.tcdsb_SES_iepCompleted(@schoolyear, @schoolCode, @PersonID) -- Return Value is Completed
	 else if @TaskType ='IPRC'
		begin
			if exists (select * from tcdsb_SSF_IPRCMeetingSummary where school_year ='20202021' and school_code =@SchoolCode and Person_id =@personID)
				set @rValue ='Completed'
			else
				set @rValue ='InCompleted'
		end
	 else if @TaskType ='SSN'
			set @rValue =  case  dbo.tcdsb_SES_getSurvey(@schoolyear, @schoolCode, @PersonID) when '2' then 'Completed' else 'InCompleted' end
	 else if @TaskType = 'ReportCard'
		begin
			set @rValue = 'InCompleted'
		end
	else
		set @rValue = 'InCompleted'

 	RETURN(@rValue)
  END
   

