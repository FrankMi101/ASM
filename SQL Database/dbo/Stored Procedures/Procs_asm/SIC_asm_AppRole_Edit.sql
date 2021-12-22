



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppRole_Edit 'DElete' ,'mif','304','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppRole_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null ,
	@AppID			varchar(20) = null,
	@RoleID			varchar(50) =null, 
	@RoleType		varchar(10) =null,  
	@RoleName		varchar(100) = null,
	@RolePriority	varchar(10) = null,
	@AccessScope	varchar(20)= null,
	@Permission		varchar(20) = null,
	@Comments		varchar(250) = null

as 

set nocount on
 
if @Operate in ('Get','GetbyID')  
	begin
		select distinct
			IDs
			,AppID  
			,RoleID
			,RoleName
			,RolePriority
			,Permission		
			,AccessScope 
			,Comments
		from [dbo].[SIC_sys_UserRole] 
		where  IDs =   @IDs
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole]  where  IDs = @IDs) -- RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							 Update  [dbo].[SIC_sys_UserRole] 
							 set RoleName = @RoleName ,RolePriority = @RolePriority, Permission = @Permission, AccessScope = @AccessSCope, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where  IDs = @IDs -- RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID 
						else
							select 'Role name ' + @RoleID + ' does not exists in the system' as rValue
					 
					end
				if @Operate ='Add'
					begin
					    if len(isnull(@RoleID,'')) < 1 
							select 'Invalid Role ID' as rValue
						else if exists (select 1 from [dbo].[SIC_sys_UserRole] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							select 'Role name ' + @RoleID + ' exists in the system already' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserRole]
									(  AppID, RoleID,RoleName,RoleType, RolePriority, Permission, AccessScope, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@RoleID,@RoleName,@RoleType,@RolePriority, @Permission,@AccessSCope,@Comments, getdate(),@UserID,app_name() )
								
								set @newID = cast(@@IDENTITY as varchar(10)) 

								-- insert a default AppRole permission record AppID = SIC ModelID =Page 
								insert into [dbo].[SIC_sys_UserRole_AppsPermission]
								(RoleType,RoleID,AppID,ModelID,Permission,AccessScope,Comments,IDs_Role,lu_date,lu_user,lu_function)
								Values (@RoleType,@RoleID,'SIC','Pages',@Permission,@AccessScope,@Comments,@@IDENTITY,getdate(),@UserID,App_name())						 

							end
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole] where   RoleType = @RoleType  and RoleID = @RoleID and AppID = @AppID )
							begin
								delete [dbo].[SIC_sys_UserRole_AppsPermission] where RoleType = @RoleType and RoleID = @RoleID and AppID = @AppID 
								delete [dbo].[SIC_sys_UserRole] where  RoleType = @RoleType and RoleID = @RoleID and AppID = @AppID
							end
						else
						     select 'Role name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
 				if @Operate ='Delete'
					begin
					    if exists (select 1 from [dbo].[SIC_sys_UserRole] where IDs =  @IDs ) -- RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							begin
								delete [dbo].[SIC_sys_UserRole_AppsPermission] 
								where  RoleID + RoleType + AppID = ( select top 1  RoleID + RoleType + AppID from [dbo].[SIC_sys_UserRole] where IDs =  @IDs)

								delete [dbo].[SIC_sys_UserRole] where IDs =  @IDs --  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID
							end
						else
						     select 'Role name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
		  Commit tran			 
 				Select 'Successfully' + @newID as rValue
			 --	 select dbo.tcdsb_LTO_choiseInterviewCandidate(@SchoolYear,@PositionID) as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select   'Failed' as rValue -- ERROR_MESSAGE() as rValue --
		end catch		
	end
