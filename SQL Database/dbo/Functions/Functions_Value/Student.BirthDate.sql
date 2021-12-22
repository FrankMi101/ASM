




-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 16, 2016
-- Description:	get student Birth date by person id 
-- ===================================================================================



CREATE FUNCTION [dbo].[Student.BirthDate] (@Person_id char(13))  
RETURNS  smalldatetime
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
            declare @rValue smalldatetime
	  
  	 
		   set @rValue = ( select top 1   birth_date from persons
				where  person_id =@person_id)
		 
	 
		  -- set @rValue = ( select top 1 convert(varchar(10), birth_date,111)	from persons
				--where  person_id =@person_id)
		 

       RETURN(@rValue)
  END

