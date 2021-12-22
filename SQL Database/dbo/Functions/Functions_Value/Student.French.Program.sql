

-- =================================================================================
-- Author:		Frank Mi
-- Create date: August  108, 2021    
-- Description:	to get Student French informatin from SIS
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.French.Program] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8) 
	 )  
RETURNS varchar(20) 
AS  
   BEGIN
         declare @rValue varchar(20)
		 if  exists( select * from   dbo.fs_student_fsl_programs where school_year= @SchoolYear  and person_id = @PersonID and other_fsl_instruction in  ('Extended','Immersion','Core','Exempted'))
			 set @rValue = (select top 1 other_fsl_instruction  from dbo.fs_student_fsl_programs where school_year= @SchoolYear  and person_id = @PersonID and other_fsl_instruction in  ('Extended','Immersion','Core','Exempted'))
		 else
			set @rValue =''  
	 
       RETURN(@rValue)
  END
