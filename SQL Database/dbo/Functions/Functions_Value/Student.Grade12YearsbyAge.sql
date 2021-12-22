


-- =================================================================================
-- Author:		Frank Mi
-- Create date: April 26, 2016
-- Description:	get   age by grade  
-- ===================================================================================

 
CREATE  FUNCTION [dbo].[Student.Grade12YearsbyAge]
 (
  @Grade varchar(2),
  @Age  int
  )  
RETURNS  varchar(1)
--- Frank Mi
--- April 26, 2016
  
AS  
   BEGIN
       declare @rValue varchar(1)   

	   if @Grade ='12' 
			  set  @rValue = case @Age	when 17 then '0'
									when 18 then '1'
									when 19 then '2'
									when 20	then '3'
									when 21 then '4'
									when 22 then '5'
									else '6' end
      
		else if @Grade ='11' 	
		  set  @rValue = case @Age	when 17 then '1'
									when 18 then '2'
									when 19 then '3'
									when 20	then '4'
									when 21 then '5'
									when 22 then '6'
									else '7' end
	    else 
	      set @rValue =''

	 	set  @rValue = isnull(@rValue, '')   
      RETURN(@rValue)
  END



