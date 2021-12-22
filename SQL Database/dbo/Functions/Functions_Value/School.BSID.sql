
-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015
-- Description:	  get school BSID  by schoolcode 
-- ===================================================================================


-- drop function School

CREATE Function [dbo].[School.BSID](@SchoolCode char(4))
RETURNS varchar(200)
as
begin 
   declare @rValue varchar(200)
   if exists (select * from dbo.schools where school_code = @SchoolCode)
         set @rValue = (select top 1  isnull(default_school_bsid, '') 
						From dbo.schools
						WHERE school_code =@SchoolCode
						)

   else  
   
        set @rValue =  'Other Board'
 
  
     Return(@rValue)
 
end 
