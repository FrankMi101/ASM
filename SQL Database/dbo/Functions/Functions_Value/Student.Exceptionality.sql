
-- =====================================================================================
-- Author		: Frank Mi
-- Create date	:  
-- Modify		: by Frank at March 19, 2021. add IEPEnd Date  
-- Description	: get student IEP Special education info
-- ===================================================================================== 

CREATE FUNCTION [dbo].[Student.Exceptionality] (@personID varchar(13), @Schoolyear varchar(8),@type varchar(20))
RETURNS varchar(100)
AS 
  BEGIN
     declare @rValue varchar(100)
     declare @rDate smalldatetime
     if @type ='Default' 
        set @rValue = ( SELECT  top 1    Excep_Text
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Excep1' 
        set @rValue = (SELECT  top 1   Excep_Text 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Exce2' 
        set @rValue = (SELECT  top 1   Excep2_text 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Excep3' 
        set @rValue = ( SELECT  top 1   Excep3_text 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Placement' 
        set @rValue = (  select top 1 IPRC_Text
						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
 						)
    if @type ='Excep1Code' 
        set @rValue = (SELECT  top 1   Excep_Code 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Exce2Code' 
        set @rValue = (SELECT  top 1   Excep2_Code 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='Excep3Code' 
        set @rValue = ( SELECT  top 1   Excep3_Code 
 						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
                      )  
     if @type ='PlacementCode' 
        set @rValue = (  select top 1 IPRC_Code
						FROM  	[dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear 
 						)
     if @type ='IPRCDate'
        begin  
             set @rDate = ( select top 1 IPRC_Date
		    	            from [dbo].[tcdsb_IEP_Registration_Exceptionality]  
        				WHERE person_id = @personID and school_year = @schoolyear  )
             set @rValue =     dbo.DateF(@rDate,'YYYYMMDD') --      convert(varchar(10), @rDate,111)
        end
     if @type ='IEPEndDate'
        begin  
             set @rDate = ( select top 1 IEP_End
		    	            from  [dbo].[tcdsb_IEP_Registration_Excep]  
        				WHERE person_id = @personID and school_year = @schoolyear and IEP_End is not null  )
             set @rValue =     dbo.DateF(@rDate,'YYYYMMDD') --      convert(varchar(10), @rDate,111)
        end
    if @type ='YesNo'
         if exists (select * from tcdsb_iep_registration where school_year = @schoolyear and person_id = @personid  and isnull(IEP_End, getdate()+1) > getdate())
            set @rValue =  'Yes'
         else
 			set @rValue = 'No' 	
  
 	RETURN(@rValue)
  END

