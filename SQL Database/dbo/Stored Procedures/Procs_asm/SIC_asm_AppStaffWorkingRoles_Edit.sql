





 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Sept 23, 2021  
-- Description	: get staff work school selected
-- =====================================================================================

CREATE  proc [dbo].[SIC_asm_AppStaffWorkingRoles_Edit] -- 'Add','mif' ,'170', 'bonavoj','Section23','G. Bonavo,','2021-09-01','2022-06-30','x','new Center das a ad aa'
	@Operate		varchar(30) =null,
	@UserID			varchar(30) =null,
	@IDs			varchar(10) = null,
	@StaffUserID	varchar(30) = null,
	@WorkingRole	varchar(30) = null,
	@AppID			varchar(10) = null,
	@ScopeBy		varchar(30) = null,
	@ScopeByValue	varchar(50) = null,
	@StaffName		varchar(50) = null,
	@StartDate		varchar(10) = null,
	@EndDate		varchar(10) = null,
	@ActiveFlag		varchar(1) = null,
	@Comments		varchar(250) = null
as 

set nocount on 
if @Operate ='RoleListbyUserID'  	
	select   IDs
			,AppRole  as WorkingRole
			,UserName as StaffName
			,StartDate
			,EndDate
			,ActiveFlag
			,Comments
	from [dbo].[SIC_sys_UserWorkingRoles]	
	where UserID  = @StaffUserID
 
else if @Operate ='Get' 
		select top 1  IDs
			,AppRole  as WorkingRole
			,dbo.[Staff.Role.SAP](W.UserID) as SAPRole
			,W.UserID
			,E.FirstName + ' ' + E.LastName  as StaffName
			,E.CPNum
			,[dbo].[Date.ToString](StartDate,'YMD') as StartDate
			,[dbo].[Date.ToString](EndDate,'YMD') as EndDate
			,ActiveFlag
			,Comments
			,AppID
			,ScopeBy
			,ScopeByValue
		from [dbo].[SIC_sys_UserWorkingRoles]   as W
		inner join dbo.SIC_sys_Employee			as E on W.UserID = E.UserID
		where IDs  =   @IDs
		 
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 					 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserWorkingRoles]  where IDs = @IDs)
							update  [dbo].[SIC_sys_UserWorkingRoles]  
							set AppID = @AppID, AppRole = @WorkingRole, ScopeBy = @ScopeBy, ScopeByValue = @ScopeByValue,
							StartDate =dbo.DateFC(@StartDate,'YYYYMMDD'), EndDate =dbo.DateFC(@EndDate,'YYYYMMDD'), 
								ActiveFlag =@ActiveFlag,Comments =@Comments, lu_date =getdate(), lu_User = @UserID,lu_Function =app_name()
							where IDs = @IDs
						else
							select 'User ' + @StaffUserID + ' does not exists in the Working Role ' + @WorkingRole  as rValue		  
							 
 					end
				if @Operate ='Add'  					 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserWorkingRoles]  where UserID  = @StaffUserID and AppRole = @WorkingRole )
								select 'User ' + @StaffUserID + ' is a member of ' + @WorkingRole + ' exists in the system'  as rValue		
						else
							begin
								Insert into  [dbo].[SIC_sys_UserWorkingRoles]
									( AppID, AppRole, UserID,UserName,ScopeBy,ScopeByValue,  StartDate, EndDate,ActiveFlag, Comments, lu_Date,lu_user, lu_Function)
								values(@AppID, @WorkingRole, @StaffUserID, @StaffName, @ScopeBy, @ScopeByValue, dbo.DateFC(@StartDate,'YYYYMMDD'),dbo.DateFC(@EndDate,'YYYYMMDD'),
								@ActiveFlag, @Comments,getdate(),@UserID,app_name() )
							 
								set @newID = cast(@@IDENTITY as varchar(10))

							end
 					end
				if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserWorkingRoles] where IDs = @IDs)
							delete [dbo].[SIC_sys_UserWorkingRoles] where IDs   =    @IDs
						else
							select 'User App Role Rccord ' + cast( @IDs as varchar(10)) + ' does not exists in the system' as rValue
 					end
 			  Commit tran
 				Select 'Successfully' + @newID as rValue

	   end try
	   begin catch
			   Rollback tran
			   Select   ERROR_MESSAGE() as rValue --  'Failed' as rValue
		end catch		
	end
