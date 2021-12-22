


-- ============================================================================
-- Author:		Frank Mi
-- Create date: June 24, 2020 
-- Description:	get Login User profile. such as user role, user postion, and permission
-- =============================================================================
 
CREATE proc [dbo].[SIC_sys_LoginUserProfile] -- 'LoginUserEmployeeID','bellisa03'
	@Operate   varchar(30),
	@UserID    varchar(30),
	@Role 	   varchar(30) = null

as

set nocount on
declare  @gRole 	varchar(30)
declare @gPermission  varchar(30)
-- set @UserID = dbo.tcdsb_Login(@UserID,'UserID')
if @Operate ='CurrentSchoolYear'
     begin 
		if exists (select 1 from [dbo].[SIC_sys_UsersActionTrack]  where UserID =   @UserID)
			select   [dbo].[Current.SchoolYear]('SIC')       --select dbo.EPA_CurrentSchoolYear(8,25) as rValue
			from [dbo].[SIC_sys_UsersActionTrack]  where UserID = @UserID
		else
		    select dbo.[Current.SchoolYear]('SIC' ) as rValue
	  end
else if @Operate ='Role'
        select [dbo].[User.Role.Base](@UserID,'Employee')
else if @Operate ='Scope'
        select [dbo].[User.Scope.Base](@UserID,'Employee') 
else if @Operate ='Position'
     select   top 1  PositionDesc
	 from [dbo].[SIC_sys_Employee] 
	 where UserID = @UserID 
else if @Operate ='LoginUserEmployeeID'
     select top 1   CPNum
	 from [dbo].[SIC_sys_Employee] 
	 where UserID = @UserID 

else if @Operate ='LoginUserName'
	select top 1 FirstName + ' ' + LastName
			from [dbo].[SIC_sys_Employee] 
			 where UserID = @UserID
 
 else if @Operate = 'Permission'
   begin
      if @Role is null
          set @Role = [dbo].[Staff.Role](@UserID,'Employee')
  
      --set @gPermission = (select top 1 Permission from dbo.EPA_sys_securityUsersPermission where GroupID = @UserID and GrantType ='User')
      --if @gPermission is null 
      --   set @gPermission = ( select top 1 Permission from dbo.EPA_sys_securityUsersPermission where GroupID = @Role and GrantType ='Group')
      --set @gPermission = isnull(@gPermission,'Deny')
      select 'Update' as  rValue 

   end  
else 
    select top 1 CPNum 
	 from [dbo].[SIC_sys_Employee] 
	 where UserID = @UserID 
  


