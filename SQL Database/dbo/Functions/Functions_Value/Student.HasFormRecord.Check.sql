



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: November 08, 2021  
-- Description:	 get student list by class
-- =====================================================================================
CREATE FUNCTION [dbo].[Student.HasFormRecord.Check]
(	@Schoolyear varchar(8),
	@StudentID  varchar(15), 
	@FormName   varchar(30)
) 
 RETURNS int 
AS 
BEGIN 
	declare @rVal int
 	if @FormName ='IEP'
		set @rVal = (select count(*) from dbo.tcdsb_IEP_registration where school_year = @Schoolyear and person_id = @StudentID)
	else if @FormName ='IPRC'	
		set @rVal = (select count(*) from dbo.tcdsb_SSF_IPRCMeetingSummary where school_year = @Schoolyear and person_id = @StudentID)
	else if @FormName ='SBST'	
		set @rVal = (select count(*)  from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='SBST')
	else if @FormName ='SBSLT'	
		set @rVal = (select count(*)  from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='SBSLT')
	else if @FormName ='CCForm'	
		set @rVal = (select count(*)  from dbo.tcdsb_SSF_SchoolBasedSupport where school_year = @Schoolyear and person_id = @StudentID and Service_Type ='CC')
	else if @FormName ='IntakeForm'	
		set @rVal = (select count(*)  from dbo.tcdsb_SSF_intakeReferral where school_year = @Schoolyear and person_id = @StudentID)
	else if @FormName ='ReferralForm'	
		set @rVal = (select count(*)  from dbo.tcdsb_SSF_RequestServices where school_year = @Schoolyear and person_id = @StudentID)
	else if @FormName ='SSN'	
 		set @rVal = (select count(*)   from dbo.tcdsb_SSSN_Survey_Operation where school_year = @Schoolyear and person_id = @StudentID)
 	else if @FormName ='AlterRC'	
		set @rVal = (select count(*)   from dbo.tcdsb_SSF_RequestServices where school_year = @Schoolyear and person_id = @StudentID)
 	else if @FormName ='Gift'	
		set @rVal = (select count(*)   from dbo.tcdsb_SSF_RequestServices where school_year = @Schoolyear and person_id = @StudentID)
 	else
		set @rVal = 1


    RETURN  @rVal
 

end
