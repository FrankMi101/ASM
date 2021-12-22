






-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student Special Education Information 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.SE] 
	(@PersonID varchar(13), 
	 @SchoolYear varchar(8), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(70)
 
AS  
   BEGIN
      declare @rValue varchar(70)
	  if @Attr ='IPRC'   
          if exists ( select  * 	from  [dbo].[tcdsb_SES_ExceptionalityIPRC]  	where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue ='Y' 
 		 else
		      set  @rValue =''   
	  if @Attr ='IEP'   
          if exists ( select  * 	from  [dbo].[tcdsb_SES_ExceptionalityIEP]   	where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue ='Y' 
 		 else
		      set  @rValue =''   
	 
	  if @Attr ='Accommodation'   
          if exists ( select  * 	from [dbo].[tcdsb_IEP_subject_strand]  	where school_year = @SchoolYear and Person_id = @PersonID and accomodation ='1')    
		      set  @rValue ='Y' 
 		 else
		      set  @rValue =''   
	  if @Attr ='Modification'   
          if exists ( select  * 	from  [dbo].[tcdsb_IEP_subject_strand]   	where school_year =  @SchoolYear and Person_id = @PersonID  and [modify] ='1')     
		      set  @rValue ='Y' 
 		 else
		      set  @rValue =''   
	  if @Attr ='Alternative'   
          if exists ( select  * 	from  [dbo].[tcdsb_IEP_subject_strand]   	where school_year =  @SchoolYear and Person_id = @PersonID   and [Alternatives] ='1')    
		      set  @rValue ='Y' 
 		 else
		      set  @rValue =''   
	  if @Attr ='Excep1'   
          if exists ( select * 	from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue = ( select  top 1 Excep_Text from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID order by Status )
 		 else
		      set  @rValue =''   
	 
	  if @Attr ='Excep2'   
          if exists ( select * 	from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue = ( select  top 1 Excep2_Text from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID  order by Status)
 		 else
		      set  @rValue =''   
	 
	  if @Attr ='Excep3'   
          if exists ( select * 	from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue = ( select  top 1 Excep3_Text from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID  order by Status)
 		 else
		      set  @rValue =''   
	 
	  if @Attr ='Placement'   
          if exists ( select * 	from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID)    
		      set  @rValue = ( select  top 1 IPRC_Text from  [dbo].[tcdsb_SES_ExceptionalityIEP] where school_year =  @SchoolYear and Person_id = @PersonID  order by Status)
 		 else
		      set  @rValue =''   
	 
       RETURN(@rValue)
  END
    

