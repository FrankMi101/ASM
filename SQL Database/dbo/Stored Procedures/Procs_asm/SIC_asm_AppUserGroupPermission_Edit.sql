








 
 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Group list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserGroupManagement 'GetList' ,'mif','admin','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppUserGroupPermission_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@IDs			varchar(20) =null,
	@SchoolCode		varchar(8) =null,  
	@AppID			varchar(20) = null,
	@ModelID		varchar(20) =null, 
	@GroupID		varchar(200) =null, 
	@Permission		varchar(20) = null,
	@AccessSCope	varchar(20)= null,
	@Comments		varchar(250) = null
as 

set nocount on
declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4)
select @GoPage ='../PagesForms/Permission_Group.aspx' , @Target ='EditDIV',@Height='400',@Width ='600'
if @Operate ='Get'  
	begin

		select distinct
			 IDs
			,AppID  
			,GroupID
			,ModelID
			,Permission		
			,AccessScope 
			,Comments
		from [dbo].[SIC_sys_UserGroup_AppsPermission] 
		where  IDs = @IDs
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_AppsPermission]  where  IDs = @IDs ) -- SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID )
							 Update  [dbo].[SIC_sys_UserGroup_AppsPermission] 
							 set   Permission = @Permission, AccessScope = @AccessSCope, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where  IDs = @IDs -- SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID and ModelID = @ModelID
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_AppsPermission] where  SchoolCode = @SchoolCode  and AppID = @AppID  and ModelID = @ModelID and   GroupID = @GroupID )
							select 'There is a Group Permission for ' + @GroupID + ' in ' + @ModelID + ' of ' + @AppID + ' exists in the system already' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserGroup_AppsPermission]
									(  AppID, GroupID,ModelID,SchoolCode,  Permission, AccessScope, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@GroupID,@ModelID,@SchoolCode,  @Permission,@AccessSCope,@Comments, getdate(),@UserID,app_name() )
								
								set @newID = cast(@@IDENTITY as varchar(10))  
							end
 					end
				if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_AppsPermission] where IDs = @IDs ) -- SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID and ModelID =@ModelID)
							delete [dbo].[SIC_sys_UserGroup_AppsPermission] where IDs = @IDs -- SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID and ModelID = @ModelID
						else
							select 'There is no such Group Permission setup for ID ' + @IDs + ' in the system' as rValue
				 
 					end
 			  Commit tran
  
 				Select 'Successfully' + @newID as rValue

	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
