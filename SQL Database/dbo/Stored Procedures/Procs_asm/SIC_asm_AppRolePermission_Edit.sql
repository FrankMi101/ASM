





-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppRolePermission_Edit 'GetbyID' ,'mif','20','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppRolePermission_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@IDs			varchar(10) = null,
	@AppID			varchar(20) = null,
	@RoleID			varchar(50) =null, 
	@ModelID		varchar(20) =null, 
	@RoleType		varchar(10) =null,  
	@Permission		varchar(20) = null,
	@AccessSCope	varchar(20)= null,
	@Comments		varchar(250) = null
as 

set nocount on
declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4)
select @GoPage ='../PagesForms/Permission_Role.aspx' , @Target ='EditDIV',@Height='400',@Width ='600'
if @Operate in ('Get','GetbyID')  
	begin
		select distinct
			 P.IDs
			,P.AppID  
			,P.RoleID
			,P.ModelID
			,P.Permission		
			,P.AccessScope 
			,P.Comments
			,R.RoleName
		from [dbo].[SIC_sys_UserRole_AppsPermission]	as P
		left join [dbo].SIC_sys_UserRole				as R on P.RoleID = R.RoleID --  and p.AppID = R.AppID
		where P. IDs =   @IDs
 
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission]  where  IDs = @IDs ) --  AppID = @AppID and RoleID = @RoleID )
							 Update  [dbo].[SIC_sys_UserRole_AppsPermission] 
							 set   Permission = @Permission, AccessScope = @AccessSCope, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where IDs = @IDs --  AppID = @AppID and RoleID = @RoleID and ModelID = @ModelID
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID = @ModelID )
							select 'Role Permission ' + @RoleID + ' in ' + @ModelID + ' of ' +  + @AppID + ' exists in the system already' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserRole_AppsPermission]
									(  AppID, RoleID,ModelID,RoleType,  Permission, AccessScope, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@RoleID,@ModelID,@RoleType,  @Permission,@AccessSCope,@Comments, getdate(),@UserID,app_name() )
							 
							    set @newID = cast(@@IDENTITY as varchar(10)) 
							end
 					end
				if @Operate = 'Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission] where ids = @IDs ) -- 33  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID =@ModelID)
							delete [dbo].[SIC_sys_UserRole_AppsPermission] where ids =    @IDs -- RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID = @ModelID
						else
							select 'There is no Role Permission setup for IDs '  + @IDs   as rValue
				 
 					end
 			  Commit tran
 				Select 'Successfully' + @newID as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
