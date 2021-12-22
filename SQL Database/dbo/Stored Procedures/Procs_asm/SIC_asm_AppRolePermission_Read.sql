









 
 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppRolePermission_Read 'GetListbyRoleID' ,'mif','admin','ITFTeacher', 'PositionDEsc'
CREATE  proc [dbo].[SIC_asm_AppRolePermission_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@RoleID			varchar(50) =null, 
	@RoleType		varchar(10) =null  
	--@ModelID		varchar(20) =null, 
	--@AccessSCope	varchar(20)= null,
	--@Permission		varchar(20) = null,
	--@Comments		varchar(250) = null
as 

set nocount on
declare @GoPage varchar(100), @Type varchar(20),  @ModelID varchar(50),@SchoolYear varchar(8), @SchoolCode varchar(8)
--select @GoPage ='../PagesForms/Permission_Role.aspx' , @Target ='EditDIV',@Height='400',@Width ='600'
select @ModelID ='Pages', @Type ='RolePermission', @Schoolyear ='20202021',@SchoolCode = '0000'

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
  			,dbo.[ActionTask.ASM]('Edit'  ,@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as EditAction
  			,dbo.[ActionTask.ASM]('Delete',@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as DeleteAction

 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		 	from  [dbo].[SIC_sys_UserRole_AppsPermission] as P    
			left join [dbo].[SIC_sys_UserRole]			  as R on  P.RoleType = R.RoleType and P.RoleID =R.RoleID 
			where  R.RoleType = @RoleType    and P.AccessScope in ('School','Class','Grade','Student')
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
  			,dbo.[ActionTask.ASM]('Edit'  ,@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as EditAction
  			,dbo.[ActionTask.ASM]('Delete',@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as DeleteAction
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 			from  [dbo].[SIC_sys_UserRole_AppsPermission] as P    
			left join [dbo].[SIC_sys_UserRole]			  as R on  P.RoleType = R.RoleType and P.RoleID =R.RoleID 
			where  R.RoleType = @RoleType --and P.AppID =   @AppID  
			order by RowNo

		--select * from  [dbo].[SIC_sys_UserRole_AppsPermission] where   RoleType = 'SAP'  and  AppID = 'IEP'
		--select * from  [dbo].[SIC_sys_UserRole] where   RoleType = 'SAP'  and  AppID = 'IEP'
	end
else if @Operate ='GetListbyRoleID'  
			select distinct
			 P.IDs
			,P.AppID  
			,A.AppName
			,P.ModelID
			,P.Permission		
			,P.AccessScope 
			,P.Comments
  			,dbo.[ActionTask.ASM]('Edit'  ,@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as EditAction
  			,dbo.[ActionTask.ASM]('Delete',@Type,P.IDs,@SchoolYear,@SchoolCode,P.AppID, P.ModelID,P.RoleID,P.AccessScope,P.RoleType)	as DeleteAction
 			,ROW_NUMBER() OVER(ORDER BY P.roleID, P.ModelID ) AS RowNo 
 			from  [dbo].[SIC_sys_UserRole_AppsPermission] as P    
			left join [dbo].[SIC_sys_UserRole]			  as R on  P.RoleType = R.RoleType and P.RoleID =R.RoleID 
			left join [dbo].[SIC_sys_Apps]				  as A on P.AppID = A.AppID	
			Where P.RoleID = @RoleID
		--select * from  [dbo].[SIC_sys_UserRole_AppsPermission] where   RoleType = 'SAP' -- and  AppID = 'IEP'
		--select * from  [dbo].[SIC_sys_UserRole] where   RoleType = 'SAP' -- and  AppID = 'IEP' 
	 
else if @Operate ='Get'  
	begin
		select distinct
			 IDs
			,AppID  
			,RoleID
			,ModelID
			,Permission		
			,AccessScope 
			,Comments
			,RoleType
		from [dbo].[SIC_sys_UserRole_AppsPermission] 
		where  RoleType = @RoleType   and RoleID = @RoleID -- and AppID = @AppID
	end
 
