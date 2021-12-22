
-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 16, 2021
-- Description:	get current school Support Office by schoolcode 
-- ===================================================================================
 

CREATE Function [dbo].[School.SupportOffice](@SchoolCode char(4),@Type varchar(30),@appID varchar(30))
RETURNS varchar(100)
as
begin 
   declare @rValue varchar(100) 
   if @appID ='SES'
	  begin
		   if exists (select * from dbo.tcdsb_SES_Schools where  school_code = @SchoolCode)
				 set @rValue = (select top 1  isnull(School_supportOffice, ' ') 
								From dbo.tcdsb_SES_Schools
								WHERE school_code = @SchoolCode  )
		   else
				set @rValue = 'TCDSB'

			if @Type ='Name'
				set @rValue =(select top 1 short from dbo.tcdsb_SES_StandardCode where category ='SupportOffice' and Code = @rValue)
	end
		
	Return(@rValue)
 
end 
