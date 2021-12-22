


-- =================================================================================
-- Author:		Frank Mi
-- Create date: May 16, 2018
-- Description:	to get current school principal email address 
-- ===================================================================================
 
CREATE Function [dbo].[School.Principal.eMailAddress]
(@SchoolCode varchar(8),
 @UserID varchar(20))
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50)
 
   --  set Monsignor Fraser College  school ='0500,0532,0533,0534,0539,0557,0558,0564,0566,0567' 
  if @SchoolCode in ('0500','0532','0533','0534','0539','0557','0558','0564','0566','0567' )
      set @SchoolCode ='0533'
  if @UserID =''   set @UserID = (select top 1 UserID from dbo.tcdsb_TPA_TCDSBPrincipals
						where LocationID = @SchoolCode  and Status  = '3-Active'
						order by Title, PerNo desc )
  if exists(select * from   dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )
      set @rValue = (select top 1 isnull(Email,'')  from   dbo.tcdsb_z_ADAccounts where  studentFlag = 0  and ADUsername = @UserID  )

						 
   set @rValue = isnull(@rValue,  '')

  Return(@rValue)
 
end 
 
