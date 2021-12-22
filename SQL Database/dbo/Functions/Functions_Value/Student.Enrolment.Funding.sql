
-- =================================================================================
-- Author:		Frank Mi
-- Create date: Mary 18, 2021
-- Description:	get student enrolment funding
-- ===================================================================================
  

CREATE  FUNCTION [dbo].[Student.Enrolment.Funding] (@SchoolYear varchar(8),@SchoolCode varchar(8),@PersonID varchar(13)  )  
RETURNS varchar(20) 
AS  
   BEGIN
		declare @rValue varchar(50)
		set @rValue = ( select top 1 isnull(funding_source_type,'') 
					 from dbo.student_enrolments
					 where school_year = @SchoolYear and person_id  = @PersonID and School_code = @SchoolCode and active_flag ='x'  and transaction_type_ind in ('1','2','3')  and funding_source_type is not null 
					 order by effective_date,  transaction_type_ind Desc
					)

		set  @rValue = isnull(@rValue,'' )   
       RETURN(@rValue)
  END
