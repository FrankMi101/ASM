










 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserRoleManagement 'GetList' ,'mif','admin','20202021','0354' , 'SIC','','SAP' 
CREATE proc [dbo].[SIC_sys_UserRolePermission]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@AppID			varchar(20) = null,
	@RoleID			varchar(50) =null, 
	@RoleType		varchar(10) =null,  
	@ModelID		varchar(20) =null, 
	@AccessSCope	varchar(20)= null,
	@Permission		varchar(20) = null,
	@Comments		varchar(250) = null
as 

set nocount on
declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4)
select @GoPage ='../SICCommon/Security_RoleP.aspx' , @Target ='EditDIV',@Height='400',@Width ='600'
if @Operate ='GetList' 
 	begin	
		if @UserRole in ('Principal','VP')
			select distinct
			 P.AppID  
			,P.RoleID
			,P.ModelID
			,R.RoleName
			,P.Permission		
			,R.AccessScope 
			,P.Comments			 
 		 	,dbo.[ActionTask.Role]('Edit'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, P.AppID, P.ModelID,P.RoleID,R.RoleName,P.RoleType)	as EditAction
		 	,dbo.[ActionTask.Role]('Delete' ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, P.AppID, P.ModelID,P.RoleID,R.RoleName,P.RoleType)	as DeleteAction
 		 
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 			from  [dbo].[SIC_sys_UserRole_AppsPermission] as P    
			left join [dbo].[SIC_sys_UserRole]			  as R on  P.RoleType = R.RoleType and P.RoleID =R.RoleID 
			where  R.RoleType = @RoleType and P.AppID =   @AppID   and P.AccessScope in ('School','Class','Grade','Student')
			order by RowNo
		else
			select distinct
			 P.AppID  
			,P.RoleID
			,P.ModelID
			,R.RoleName
			,P.Permission		
			,R.AccessScope 
			,P.Comments
 		 	,dbo.[ActionTask.Role]('Edit'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, P.AppID, P.ModelID,P.RoleID,R.RoleName,P.RoleType)	as EditAction
		 	,dbo.[ActionTask.Role]('Delete' ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, P.AppID, P.ModelID,P.RoleID,R.RoleName,P.RoleType)	as DeleteAction
 		 
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 			from  [dbo].[SIC_sys_UserRole_AppsPermission] as P    
			left join [dbo].[SIC_sys_UserRole]			  as R on  P.RoleType = R.RoleType and P.RoleID =R.RoleID 
			where  R.RoleType = @RoleType and P.AppID =   @AppID  
			order by RowNo

		--select * from  [dbo].[SIC_sys_UserRole_AppsPermission] where   RoleType = 'SAP'  and  AppID = 'IEP'
		--select * from  [dbo].[SIC_sys_UserRole] where   RoleType = 'SAP'  and  AppID = 'IEP'
	end
 
else if @Operate ='Get'  
	begin
		select distinct
			 AppID  
			,RoleID
			,ModelID
			,Permission		
			,AccessScope 
			,Comments
		from [dbo].[SIC_sys_UserRole_AppsPermission] 
		where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID
	end
else
	begin
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission]  where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							 Update  [dbo].[SIC_sys_UserRole_AppsPermission] 
							 set   Permission = @Permission, AccessScope = @AccessSCope, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID = @ModelID
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID )
							select 'This is a already a Role named ' + @RoleID + ' In the system' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserRole_AppsPermission]
									(  AppID, RoleID,ModelID,RoleType,  Permission, AccessScope, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@RoleID,@ModelID,@RoleType,  @Permission,@AccessSCope,@Comments, getdate(),@UserID,app_name() )
							 
							end
 					end
				if @Operate ='Del'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserRole_AppsPermission] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID =@ModelID)
							delete [dbo].[SIC_sys_UserRole_AppsPermission] where  RoleType = @RoleType  and AppID = @AppID and RoleID = @RoleID and ModelID = @ModelID
						else
							select 'This is no such Role named ' + @RoleID + ' ' + @ModelID + ' In the system' as rValue
				 
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
