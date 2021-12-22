


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: November 20, 2021  
-- Description	: Staff self request apps access permission 
-- =====================================================================================

CREATE  proc [dbo].[SIC_asm_AppPermission_SelfRequest]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@StaffID		varchar(30) = null,
	@StaffRole		varchar(30) = null,
	@AppID			varchar(20) = null,
	@ModelID		varchar(30) = null,
	@Permission		varchar(30) = null,
	@StartDate		varchar(10) = null,
	@EndDate		varchar(10) = null,
	@RequestType	varchar(20) = null, -- Role/Group/Access/scope
	@RequestValue	varchar(50) = null,
	@RequestScope	varchar(50) = null,
	@Comments		varchar(50) = null
as 
 
set nocount on
BEGIN
	-- select * from [dbo].[SIC_sys_UserRequestLog]
	insert into [dbo].[SIC_sys_UserRequestLog]
		   (RequestVerify, SchoolYear, SchoolCode, AppID, ModelID, Permission, StaffID, StartDate, EndDate, RequestType, RequestValue, RequestScope, Comments,lu_date,lu_user,lu_function )
	values ('Pending',	  @SchoolYear,@SchoolCode,@AppID,@ModelID,@Permission,@StaffID,@StartDate,@EndDate,@RequestType,@RequestValue,@RequestScope,@Comments,getdate(),@UserID,app_name())
 
	declare @AccessScope varchar(30), @RequestID int, @StaffName varchar(50)
	set @RequestID = @@IDENTITY
	set @StaffName = dbo.[Staff.Name](@StaffID,'')
	if @RequestType = 'AccessPermission'
		begin
			if @StaffRole = 'Other'
				update [dbo].[SIC_sys_UserRequestLog] set RequestVerify ='AdminCheck'
				where IDs = @RequestID
			else
				begin
					set @AccessScope =[dbo].[Staff.App.AccessScope](@StaffID,@AppID,@ModelID)
					set @Permission = [dbo].[Staff.APP.Permission](@StaffID,@StaffRole,@AppID,@ModelID)
					if @RequestValue != @Permission
						begin
							insert into dbo.SIC_sys_UserWorkingRoles
							(AppID, AppRole,UserID,UserName,ScopeBy,ScopeByValue,StartDate,EndDate,ActiveFlag,Comments,lu_date,lu_User,lu_Function)
							 
							select top 1 AppID,RoleID, @StaffID,@StaffName, AccessScope, @SchoolCode,@StartDate,@EndDate,'x',@Comments,getdate(),@UserID,app_name() 
							from SIC_sys_UserRole_AppsPermission
							where Permission = @RequestValue and AppID = @AppID and ModelID = @ModelID and AccessScope = @RequestScope
								and RoleID != @StaffRole and Permission != @Permission
								
							update [dbo].[SIC_sys_UserRequestLog] set RequestVerify ='Done', Actions = 'Auto Add user in Working role'
							where IDs = @RequestID	 
						end
				end
		end
	else if @RequestType ='AccessSchool'
		begin
			set @AccessScope =[dbo].[Staff.App.AccessScope](@StaffID,@AppID,@ModelID)
			if @AccessScope != @RequestValue 
				begin
					insert into dbo.SIC_sys_UserWorkingRoles
							(AppID, AppRole,UserID,UserName,ScopeBy,ScopeByValue,StartDate,EndDate,ActiveFlag,Comments,lu_date,lu_User,lu_Function)
							 
					values ( @AppID,@StaffRole, @StaffID,@StaffName, 'School', @SchoolCode,@StartDate,@EndDate,'x',@Comments,getdate(),@UserID,app_name() )
						 

					update [dbo].[SIC_sys_UserRequestLog] set RequestVerify ='Done', Actions = 'Auto Add to Working group in School group'
							where IDs = @RequestID	 
				end
 		end
	else if @RequestType ='AccessStudent'
		begin
			set @AccessScope =[dbo].[Staff.App.AccessScope](@StaffID,@AppID,@ModelID)
			if @AccessScope != @RequestValue 
				begin
					insert into dbo.SIC_sys_UserWorkingRoles
							(AppID, AppRole,UserID,UserName,ScopeBy,ScopeByValue,StartDate,EndDate,ActiveFlag,Comments,lu_date,lu_User,lu_Function)
							 
					values ( @AppID,@StaffRole, @StaffID,@StaffName, @RequestScope, @RequestValue,@StartDate,@EndDate,'x',@Comments,getdate(),@UserID,app_name() )
						 

					update  [dbo].[SIC_sys_UserRequestLog] set RequestVerify = 'Done', Actions = 'Auto Add to Working group in Student Group'
							where IDs = @RequestID	 
				end
 		end

END
