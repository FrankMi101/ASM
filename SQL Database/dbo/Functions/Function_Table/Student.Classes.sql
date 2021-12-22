
-- select * from dbo.[Student.Class.List]('00011116560','20212022')
--select * from dbo.[Student.Classes]('00011116560','20212022')
-- ============================================================================
-- Author:		Frank Mi
-- Create date: Sept 13, 2021  
-- Description:	Get Student classes only
-- =============================================================================  

CREATE FUNCTION [dbo].[Student.Classes]
	(@PersonID  varchar(13), 
	 @Schoolyear varchar(8)
	)
RETURNS   table   
--- Frank Mi
--- 2021.09.13 
AS 
  return
     
select   distinct Class_code,course_code 
	from dbo.[Student.Class.List](@PersonID,@Schoolyear)
 
   
