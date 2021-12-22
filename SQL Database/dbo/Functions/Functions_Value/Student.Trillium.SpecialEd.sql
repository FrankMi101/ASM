

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	:  
-- Modify		: March 19, 2021 add trillium End date
-- Description	: get student trillium Special education info
-- ===================================================================================== 


CREATE FUNCTION [dbo].[Student.Trillium.SpecialEd]
(@personID varchar(13), 
@Schoolyear varchar(8),
@type varchar(20))

RETURNS varchar(100)
AS 
  BEGIN
     declare @rValue varchar(100)
     declare @rDate smalldatetime
     if @type ='ExcepID' 
        set @rValue = ( SELECT  top 1   exceptionality_id
 						FROM  	[dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear and end_date is null
						order by status
                      )  
     if @type ='ExcepCode' 
        set @rValue = (SELECT  top 1   ExcepCode
 						FROM  	[dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear   and end_date is null
							order by status
                      )  
     if @type ='Exceptionality' 
        set @rValue = (SELECT  top 1   Exceptionality
 						FROM  	[dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear   and end_date is null
							order by status
                      )  
     if @type ='PlacementID' 
        set @rValue = (SELECT  top 1   Spec_ed_setting_code 
 						FROM  [dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear  and end_date is null
							order by status
                      )  
     if @type ='PlacementCode' 
        set @rValue = ( SELECT  top 1   PlacementCode 
 						FROM  	[dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear  and end_date is null
							order by status
                      )  
     if @type ='Placement' 
        set @rValue = (  select top 1 Placement
						FROM  	[dbo].[tcdsb_SES_ExceptionalityTrillium]
        				WHERE person_id = @personID and school_year = @schoolyear  and end_date is null
							order by status
 						)
    
     if @type ='StartDate'
              set @rValue = ( select top 1  dbo.DateF(Start_date,'YYYYMMDD')
		    	            from [dbo].[tcdsb_SES_ExceptionalityTrillium]  
        					WHERE person_id = @personID and school_year = @schoolyear  
							order by  [status] , [start_date] DESC )
      if @type ='EndDate'
              set @rValue = ( select top 1  dbo.DateF(end_Date,'YYYYMMDD')
		    				 from [dbo].[tcdsb_SES_ExceptionalityTrillium]  
        					 WHERE person_id = @personID and school_year = @schoolyear  
							 order by [status]  , [start_date] DESC
						    )


 	RETURN(@rValue)
  END
