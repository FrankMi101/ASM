


-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 29, 2016
-- Description:	get current school Region by schoolcode 
-- ===================================================================================


-- drop function School

CREATE Function [dbo].[School.Region](@SchoolCode char(4))
RETURNS varchar(20)
as
begin 
   declare @rValue varchar(20) 

   if exists (select * from  [dbo].[tcdsb_SES_School_Region] where  school_code =@SchoolCode)
         set @rValue = (select top 1  isnull(Area, ' ') 
						From [dbo].[tcdsb_SES_School_Region]
						WHERE school_code =@SchoolCode and Area !='SBSLT'
						)
   else
	    set @rValue = 'TCDSB'

    Return(@rValue)
 
end 
