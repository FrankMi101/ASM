










-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppRole_Read 'GetListAll' ,'mif','0','admin','SAP' ,'0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppRole_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null, 
	@UserRole		varchar(20) = null,
	@RoleType		varchar(10) =null, 
	@RoleID			varchar(50) =null,
	@AppID			varchar(10)= null

as 

set nocount on
declare @GoPage varchar(100), @Type varchar(10),  @ModelID varchar(50),@iTarget varchar(50),@SchoolYear varchar(8),@SchoolCode varchar(8)
select @ModelID ='Pages', @Type ='Role',@SchoolYear ='', @SchoolCode=''
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
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
		from  [dbo].[SIC_sys_UserRole] 
		where  RoleType = @RoleType  and AppID = @AppID  
		order by RowNo
	end
else if @Operate ='GetListAll' 
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
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as SubActions 
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		from  [dbo].[SIC_sys_UserRole] 
		order by RowNo
	end
else if @Operate ='GetListbyType' 
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
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		from  [dbo].[SIC_sys_UserRole] 
		where  RoleType = @RoleType --and AppID = @AppID
		order by RowNo
	end
else if @Operate ='GetListbyRoleID' 
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
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,RoleID,RoleName,RoleType)	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		from  [dbo].[SIC_sys_UserRole] 
		where RoleID = @RoleID
		order by RowNo
	end
else if @Operate ='GetbyID'  
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
 	 
