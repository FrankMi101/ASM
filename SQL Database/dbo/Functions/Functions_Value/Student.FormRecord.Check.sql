

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: November 08, 2021  
-- Description:	 get student list by class
-- =====================================================================================
CREATE FUNCTION [dbo].[Student.FormRecord.Check]
(	@Schoolyear varchar(8),
	@StudentID  varchar(15), 
	@CheckType   varchar(30)
) 
 RETURNS varchar(10) 
AS 
BEGIN 
	declare @rVal varchar(3)
	set @rVal ='No'
	if @CheckType ='IEP'
		if exists (select top 1 school_year from dbo.tcdsb_IEP_registration where school_year = @Schoolyear and person_id = @StudentID)
			set @rVal ='Yes'
	else if @CheckType ='IPRC'	
		if exists (select top 1 school_year from dbo.tcdsb_SSF_IPRCMeetingSummary where school_year = @Schoolyear and person_id = @StudentID)
			set @rVal ='Yes'
	else if @CheckType ='SBST'	
		if exists (select top 1 school_year from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='SBST')
			set @rVal ='Yes'
	else if @CheckType ='SBSLT'	
		if exists (select top 1 school_year from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='SBSLT')
			set @rVal ='Yes'
	else if @CheckType ='CC'	
		if exists (select top 1 school_year from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='CC')
			set @rVal ='Yes'
	else if @CheckType ='Intake'	
 		if exists (select top 1 school_year from dbo.tcdsb_SSF_intakeReferral where school_year = @Schoolyear and person_id = @StudentID)
			set @rVal ='Yes'
 		 
	else
		set @rVal ='Yes'
     RETURN  @rVal
 

end
