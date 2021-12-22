





-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student French informatino 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.French] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(50)
--- Frank Mi
--- March 24 2016
--- @perason_id   
AS  
   BEGIN
            declare @rValue varchar(50)

         if exists ( select  * 	from  [dbo].[tcdsb_IEP_subject_strand] 	where school_year = @SchoolYear and Person_id = @PersonID)    
		      set  @rValue ='No' 
         else if exists ( select * from   [dbo].[tcdsb_IEP_EQAOTest]  where school_year =  @SchoolYear and person_id = @PersonID and  (reading =1 or writing =1 or mathematics =1 ))
			  set  @rValue ='Yes'   
		 else
		      set  @rValue ='Unkonw'   
	 
       RETURN(@rValue)
  END




