





-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Group list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_ListofSecurityGroups 'SecurityGroupList' ,'mif','admin','20202021','0354' , 'SIC','Grade 01 and 02 Student'

CREATE proc [dbo].[SIC_sys_ListofSecurityGroups]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(200) =null, -- Can be RoleType
	@IDs			varchar(10) = null
as 

set nocount on
declare @hSta  varchar(300), @hEnd varchar(200)
set @hSta='<a  target ="IframeSubArea" href="Loading.aspx?pID=SecurityManageSub.aspx&uRole=' + @UserRole + '&nwuID='+ @UserID + '&sName=&CPNum='
set @hEnd= '"><img src="../images/submenu.png" border="0" width="16" height="16"/>' + '</a>' 
 


 if @Operate ='SecurityGroupList' 
 	begin		 
 
		select distinct
			 M.AppID  
			,M.GroupID
			,M.GroupName
			,M.GroupType
			,M.Permission		
			,case isnull(M.Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,Comments
			,dbo.[ActionTask.Group]('TaskMenuGroup',M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID)  as Actions
			,dbo.[ActionTask.Group]('Edit',M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID)  as EditAction
			,dbo.[ActionTask.Group]('Delete',M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID)  as DeleteAction
			--,dbo.[ActionTask.Group]('SubFun' ,M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID)	as SubActions
			, @hSta  + '&sYear='  + @SchoolYear  + '&sCode='  + SchoolCode + '&appID=' + M.AppID  + '&gID=' + M.GroupID   + '&gType=' + M.GroupType +   @hEnd as SubActions  

 			,ROW_NUMBER() OVER(ORDER BY AppID, GroupID ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_Members]	as M  
		where   M.SchoolCode = @SchoolCode  and M.AppID = @AppID --and M.GroupID = @GroupID
	end
if @Operate ='SecurityGroupListStudents' 
   begin
		select M.MemberID, M.GroupType + ' ' + M.MemberID as MemberName, M.Comments 
		,dbo.[ActionTask.Group.Member]('Delete',M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID,M.MemberID,'Students')  as DeleteAction 
		,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
		from dbo.SIC_sys_UserGroup_MemberStudents as M
		where schoolcode = @SchoolCode and AppID =@AppID and GroupID = @GroupID 
   end 
if @Operate ='SecurityGroupListTeachers' 
   begin
		select [dbo].[Staff.Name](M.MemberID,'Name') as MemberName, M.Comments
		,dbo.DateF(M.StartDate,'YYYY-MM-DD') as StartDate
		,dbo.DateF(M.EndDate,'YYYY-MM-DD') as EndDate 
		,dbo.[ActionTask.Group.Member]('Delete',M.IDs, @UserRole, @SchoolYear, M.SchoolCode,M.AppID, M.GroupID,M.MemberID,'Teachers')  as DeleteAction
		,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
	     from dbo.SIC_sys_UserGroup_MemberTeachers as M
		where schoolcode = @SchoolCode and AppID =@AppID and GroupID = @GroupID 
   end 
   /*
if @Operate ='SecurityRoleList' 
 	begin		 
 
		select distinct
			 AppID  
			,RoleID
			,RoleName
			,RolePriority
			,Permission		
			,AccessScope 
			,Comments
			--,dbo.[ActionTask.Role]('TaskMenu', IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as Actions
			--,dbo.[ActionTask.Role]('EDit'	,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as EditAction
			--,dbo.[ActionTask.Role]('Delete' ,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as DeleteAction
			--,dbo.[ActionTask.Role]('SubFun' ,IDs,@UserID, @UserRole, AppID, RoleID, RoleName,RoleType)	as SubActions
			,dbo.[ActionTask.Role]('TaskMenu'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as EditAction
			,dbo.[ActionTask.Role]('Edit'	,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as EditAction
		 	,dbo.[ActionTask.Role]('Delete' ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as DeleteAction
		 	,dbo.[ActionTask.Role]('SubFun' ,@iPage,@iTarget,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',RoleID,RoleName,RoleType)	as SubActions

		 
 			,ROW_NUMBER() OVER(ORDER BY RolePriority ) AS RowNo 
 		from  [dbo].[SIC_sys_UserRole] 
		where  RoleType = @GroupID  and AppID = @AppID  
		order by RowNo
	end
	*/
