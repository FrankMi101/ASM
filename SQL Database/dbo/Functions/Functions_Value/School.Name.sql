




-- =================================================================================
-- Author:		Frank Mi
-- Create date: October 21, 2015
-- Description:	to enhancement get school name by schoolcode 
-- ===================================================================================


-- drop function School

CREATE Function [dbo].[School.Name](@SchoolCode char(4))
RETURNS varchar(300)
as
begin 
   declare @rValue varchar(200)
   if @SchoolCode='0777'
        set @rValue ='Other board'
   else if exists (select * from dbo.schools where school_code =@SchoolCode)
         set @rValue = (select top 1  isnull(school_name, ' ') 
						From dbo.schools
						WHERE school_code =@SchoolCode
						)

   else if exists (select * from dbo.tcdsb_TPA_schools where school_code =@SchoolCode)
         set @rValue = (select top 1  isnull(school_name, ' ') 
						From dbo.tcdsb_TPA_schools
						WHERE school_code =@SchoolCode
						)
   else
        set @rValue =  'TCDSB - ' + @SchoolCode
 
  
     Return(@rValue)
 
end 

