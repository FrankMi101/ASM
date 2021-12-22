
-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student Current level achievement 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.CurrentLevel] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(50)
 
AS  
   BEGIN
            declare @rValue varchar(50)
	if @Attr ='Math'   
         if exists ( select * from  [dbo].[tcdsb_IEP_subject_strand_Marks] 	
					where school_year = @SchoolYear and Person_id = @PersonID and subject ='Mathematics')   
		      set  @rValue = ( select  top 1 report_1  	from  [dbo].[tcdsb_IEP_subject_strand_Marks] 	
					where school_year = @SchoolYear and Person_id = @PersonID and subject ='Mathematics'  and Report_1 != '')
		 else
			  set  @rValue = '0'

	if @Attr ='Language'   
         if exists ( select * from  [dbo].[tcdsb_IEP_subject_strand_Marks] 	
					where school_year = @SchoolYear and Person_id = @PersonID and subject ='Language')   
		      set  @rValue = ( select  top 1 report_1  	from  [dbo].[tcdsb_IEP_subject_strand_Marks] 	
					where school_year = @SchoolYear and Person_id = @PersonID and subject ='Language' and Report_1 != '')
		 else
			  set  @rValue = '0'

	 
       RETURN(@rValue)
  END

