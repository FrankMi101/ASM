

-- =========================================================================
-- Author:		Frank Mi
-- Create date: January 25 2021,   
-- Description:	get information for Protocols for Prevalent Mdical Alert indicator
-- ========================================================================= 
 

CREATE FUNCTION [dbo].[Student.MedicalAlertID] (@personID varchar(13), @Schoolyear varchar(8) )
RETURNS varchar(10)
AS 
  BEGIN
     declare @rValue varchar(10)
	 if exists ( select *  FROM  medical_details as MD
						inner join person_medical_details as PMD on MD.medical_detail_id = PMD.medical_detail_id
       					where PMD.person_id = @PersonID and MD.active_flag ='x'  and MD.alert_flag ='x' 
						)
 			set @rValue =  'Yes'
     else
 			set   @rValue = 'No' 	
  
 	RETURN(@rValue)
  END

