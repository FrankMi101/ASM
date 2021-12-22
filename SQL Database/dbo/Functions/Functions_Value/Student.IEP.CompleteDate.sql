
-- =================================================================================
-- Author:		Frank Mi
-- Create date: Febuary 17, 2021 
-- Description:	get student IEP completed date 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.IEP.CompleteDate](
@PersonID varchar(13),
@SchoolYear varchar(8),
@DateType	varchar(1) -- 1 -- IEP Complete Date / 2-- Placement Date 
)
RETURNS smalldatetime 
AS 
BEGIN
	declare @rValue smalldatetime
	if exists (select * from dbo.tcdsb_iep_student_provincialAssessment   
	           where school_year = @SchoolYear and person_ID = @PersonID and exceptionality_type  = 'IEP0903' and Sequence_no = @DateType)
		select  top 1 @rValue = Date_of_iprc 
		from   dbo.tcdsb_iep_student_provincialAssessment
		where school_year = @SchoolYear and person_ID = @PersonID and exceptionality_type  = 'IEP0903' and Sequence_no = @DateType
	else
		set @rValue = null

		 
	RETURN(@rValue)
END
 