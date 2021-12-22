




-- =================================================================================
-- Author		: Frank Mi
-- Create date	: Febuary 26, 2021
-- Description	: get Staff Email Address
-- ===================================================================================
 
CREATE Function [dbo].[Staff.TCDSB.eMailAddress]
( @UserID varchar(20))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
	if left(@UserID,1) ='0' set @UserID = (select top 1 Exchange_NTUserID from dbo.tcdsb_vSAP_GAL where   CPNum = @UserID)

    if exists (select 1 from  dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )
        set @rValue = (select top 1 isnull(Email,'')  from   dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )
    else
		 set @rValue = @UserID + '@TCDSB.ORG'
		 				 
   set @rValue = isnull(@rValue,  '')

  Return(@rValue)
 
end 
 
