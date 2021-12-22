



	
-- =================================================================================
-- Author:		Frank Mi
-- Create date: Dec 17, 2018
-- Description:	to get current school principal email address 
-- ===================================================================================
 
CREATE Function [dbo].[Staff.eMailAddress]
(
 @UserID varchar(20)
 )
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
  
   if exists(select 1 from   dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )
      set @rValue = (select top 1 isnull(Email,'')  from   dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )
   else
      set @rValue =''
						 
   set @rValue = isnull(@rValue,  '')

  Return(@rValue)
 
end 
 

