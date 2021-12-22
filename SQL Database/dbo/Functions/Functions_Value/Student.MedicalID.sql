
-- =========================================================================
-- Author:		Frank Mi
-- Create date: June 24 2019,   
-- Description:	get information for Protocols for Prevalent Mdical Condisitons
-- ========================================================================= 
 

CREATE FUNCTION [dbo].[Student.MedicalID] (@personID varchar(13), @Schoolyear varchar(8) )
RETURNS varchar(10)
AS 
  BEGIN
     declare @rValue varchar(10)
     
          if exists (select * from tcdsb_iep_registration where school_year = @schoolyear and person_id = @personid)
            set @rValue =  'Yes'
         else
 	    set   @rValue = 'No' 	
  
 	RETURN(@rValue)
  END

