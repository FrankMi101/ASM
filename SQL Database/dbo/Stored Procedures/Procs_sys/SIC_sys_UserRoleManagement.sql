











 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserRoleManagement 'GetList' ,'mif','admin','20202021','0354' , 'SIC','','SAP' 
CREATE proc [dbo].[SIC_sys_UserRoleManagement]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@AppID			varchar(20) = null,
	@RoleID			varchar(50) =null, 
	@RoleType		varchar(10) =null,  
	@RoleName		varchar(100) = null,
	@RolePriority	varchar(10) = null,
	@AccessSCope	varchar(20)= null,
	@Permission		varchar(20) = null,
	@Comments		varchar(250) = null
as 

set nocount on
 declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4), @iPage varchar(100),@iTarget varchar(50)
select @GoPage ='Security_Role.aspx'  , @Target ='EditDIV',@Height='400',@Width ='600' -- , @GoPage ='../SICCommon/Security_Role.aspx' 
select @iPage ='SecurityRoleManageSub.aspx', @iTarget='IframeSubArea'
if @Operate ='GetList' 
 	begin		 
		select distinct
			 AppID  
			,RoleID
			,RoleName
			,RolePriority
			,Permission		
			,AccessScope 
			,Comments
			,dbo.[ActionTask.Role]('TaskMenu'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as EditAction
			,dbo.[ActionTask.Role]('Edit'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.Role]('Delete' ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.Role]('SubFun' ,@iPage,@iTarget,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as SubActions

			--,dbo.[ActionTask.Role]('TaskMenu', IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as Actions
			--,dbo.[ActionTask.Role]('Edit'	,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as EditAction
			--,dbo.[ActionTask.Role]('Delete' ,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as DeleteAction
			--,dbo.[ActionTask.Role]('SubFun' ,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as SubActions
 	 
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		from  [dbo].[SIC_sys_UserRole] 
		where  RoleType = @RoleType  and AppID = @AppID  
		order by RowNo
	end
else if @Operate ='Get'  
	begin
		select distinct
			 AppID  
			,RoleID
			,RoleName
			,RolePriority
			,Permission		
			,AccessScope 
			,Comments
		from [dbo].[SIC_sys_UserRole] 
		where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID
	end
else
	begin
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole]  where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							 Update  [dbo].[SIC_sys_UserRole] 
							 set RoleName = @RoleName ,RolePriority = @RolePriority, Permission = @Permission, AccessScope = @AccessSCope, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID 
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							select 'This is a already a Role named ' + @RoleID + ' In the system' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserRole]
									(  AppID, RoleID,RoleName,RoleType, RolePriority, Permission, AccessScope, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@RoleID,@RoleName,@RoleType,@RolePriority, @Permission,@AccessSCope,@Comments, getdate(),@UserID,app_name() )
							 
							end
 					end
				if @Operate ='Del'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							delete [dbo].[SIC_sys_UserRole] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID
						else
							select 'This is no such Role named ' + @RoleID + ' In the system' as rValue
				 
 					end
 			  Commit tran
 			  Select 'Successfully' as rValue
			 --	 select dbo.tcdsb_LTO_choiseInterviewCandidate(@SchoolYear,@PositionID) as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
