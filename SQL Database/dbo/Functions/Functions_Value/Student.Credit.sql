
			 

-- ================================================================================================
-- Author		: Frank Mi
-- Create date	: July 20,  2021  
-- Description	: Get Studdent accumulation credit. Request by Research Department Andrew Portal 
-- ================================================================================================
CREATE FUNCTION [dbo].[Student.Credit] 
(@OBJ_attribt varchar(30),
 @schoolYear varchar(8), 
 @PersonID varchar(13),
 @CreditDate smalldatetime
  )  
RETURNS varchar(8)
--- Frank Mi
--- Febuary 10, 2021
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
      declare @rValue varchar(8)
      declare @CreditT   numeric(6,2)
      declare @CreditTnew numeric (8,2)
      declare @Grade  varchar(2)   
	  
      if @OBJ_attribt = 'Accumulation'
            set @CreditT=(SELECT    sum(isnull(earned_credit_value,0))
						FROM  fs_secondary_course_credit  
                        WHERE   person_id  = @PersonID  and credit_flag ='x' and transcript_date <= @CreditDate )  
 
      else if @OBJ_attribt = 'CreditbyYear'
           set @CreditT=(SELECT  sum(isnull(earned_credit_value,0))
						 FROM  fs_secondary_course_credit  
        	             WHERE  school_year = @SchoolYear and  person_id  = @PersonID  and credit_flag ='x'  and transcript_date <= @CreditDate   )  
      else
          set @CreditT=(SELECT   sum(isnull(earned_credit_value,0))
						FROM  fs_secondary_course_credit  	 
                        WHERE   person_id  = @PersonID  and credit_flag ='x'  and transcript_date <= @CreditDate ) 
						

       set @rValue = cast(@CreditT as varchar(8))
    
	    RETURN(@rValue)
	End
