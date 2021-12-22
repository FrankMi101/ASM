







 
 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppUserGroupPermission_Read 'GetListbyGroup' ,'mif','admin','0354','SIC','All Students Work Group'
CREATE  proc [dbo].[SIC_asm_AppUserGroupPermission_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolCode		varchar(8) =null,  
	@AppID			varchar(20) = null,
	@GroupID		varchar(200) =null 
	--@ModelID		varchar(20) =null, 
	--@AccessSCope	varchar(20)= null,
	--@Permission		varchar(20) = null,
	--@Comments		varchar(250) = null
as 

set nocount on
declare @GoPage varchar(100) 
select @GoPage ='../PagesForms/Security_UserGroupP.aspx'  
declare  @Type varchar(10),  @ModelID varchar(50),@iTarget varchar(50),@SchoolYear varchar(8) 
select @ModelID ='Pages', @Type ='GroupPermission',@SchoolYear ='' 


if @Operate ='GetList' 
 	begin		 
			select distinct
			 P.IDs
			,P.AppID  
			,P.GroupID
			,P.ModelID
			,M.GroupName
			,P.Permission		
			,P.AccessScope 
			,P.Comments
    		,dbo.[ActionTask.ASM]('Edit'  ,@Type,P.IDs,@SchoolYear, P.SchoolCode,P.AppID, P.ModelID,P.GroupID,M.GroupName,M.GroupType)	as EditAction
  			,dbo.[ActionTask.ASM]('Delete',@Type,P.IDs,@SchoolYear, P.SchoolCode,P.AppID, P.ModelID,P.GroupID,M.GroupName,M.GroupType)	as DeleteAction
		 
 			,ROW_NUMBER() OVER(ORDER BY P.GroupID ) AS RowNo 
			from  [dbo].[SIC_sys_UserGroup_AppsPermission]	as P    
			left join [dbo].[SIC_sys_UserGroup_Members]		as M on  P.AppID = M.AppID and P.GroupID =M.GroupID and P.SchoolCode = M.SchoolCode 
			where  P.SchoolCode = @SchoolCode and P.AppID =   @AppID  
			order by RowNo

		-- select * from  [dbo].[SIC_sys_UserGroup_AppsPermission] --where   RoleType = 'SAP'  and  AppID = 'IEP'
		-- select * from  [dbo].[SIC_sys_UserGroup_Members] --where  -- RoleType = 'SAP'  and  AppID = 'IEP'
	end
else if @Operate ='GetListbyGroup' 
 	begin		 
			select distinct
			 P.IDs
			,P.AppID  
			,A.AppName
			,P.ModelID
			,P.Permission		
			,P.AccessScope 
			,P.Comments
    		,dbo.[ActionTask.ASM]('Edit'  ,@Type,P.IDs,@SchoolYear, P.SchoolCode,P.AppID, P.ModelID,P.GroupID,M.GroupName,M.GroupType)	as EditAction
  			,dbo.[ActionTask.ASM]('Delete',@Type,P.IDs,@SchoolYear, P.SchoolCode,P.AppID, P.ModelID,P.GroupID,M.GroupName,M.GroupType)	as DeleteAction
		 		 
 			,ROW_NUMBER() OVER(ORDER BY A.AppName, P.ModelID ) AS RowNo 
 			from  [dbo].[SIC_sys_UserGroup_AppsPermission]	as P    
			left join [dbo].[SIC_sys_UserGroup_Members]		as M on  P.AppID = M.AppID and P.GroupID =M.GroupID and P.SchoolCode = M.SchoolCode 
			left join [dbo].[SIC_sys_Apps]					as A on P.AppID = A.AppID
			where  P.SchoolCode = @SchoolCode and P.GroupID =   @GroupID  
			order by RowNo

		-- select * from  [dbo].[SIC_sys_UserGroup_AppsPermission] --where   RoleType = 'SAP'  and  AppID = 'IEP'
		-- select * from  [dbo].[SIC_sys_UserGroup_Members] --where  -- RoleType = 'SAP'  and  AppID = 'IEP'
	end
  
else if @Operate ='Get'  
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
		where SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID
	end
 
