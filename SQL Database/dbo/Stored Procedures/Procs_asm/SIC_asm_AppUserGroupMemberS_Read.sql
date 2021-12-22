



 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: July 31, 2021  
-- Description	: get Operate Student Group member   
-- ===================================================================================== 
CREATE  proc [dbo].[SIC_asm_AppUserGroupMemberS_Read]  
	@Operate		varchar(50),
	@UserID			varchar(30)= null,
	@UserRole		varchar(30) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(100) =null, 
	@MemberID		varchar(20) = null

as 

set nocount on
	set nocount on
	declare  @SchoolYear varchar(8), @Type varchar(20), @ModelID varchar(50) 
	-- select @GoPage ='Security_Group.aspx'  , @Target ='EditDIV',@Height='400',@Width ='600', @iPage ='SecurityGroupManageSub.aspx', @iTarget='IframeSubArea' -- , @GoPage ='../SICCommon/Security_Group.aspx' 
	select @SchoolYear ='20202021', @Type ='StudentMember' ,@ModelID ='Pages'

	if @Operate ='GroupListbyApp'
		select distinct
			 IDs
			,AppID  
			,GroupID
			,GroupType
			,MemberID		
			,StartDate
			,EndDate
			,Comments
		 	,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as TaskAction 
		 	,dbo.[ActionTask.ASM]('Edit',	 @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as EditAction 
		 	,dbo.[ActionTask.ASM]('Delete',  @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as DeleteAction 
		 	--,dbo.[ActionTask.Group.Member]('TaskMenu',	 IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Students')  as TaskAction 
		 	--,dbo.[ActionTask.Group.Member]('Edit',		 IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Students')  as EditAction 
		 	--,dbo.[ActionTask.Group.Member]('Delete',	 IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Students')  as DeleteAction 

 			,ROW_NUMBER() OVER(ORDER BY MemberID ) AS RowNo 
 			from  [dbo].[SIC_sys_UserGroup_MemberStudents]  
		where schoolCode = @SchoolCode and AppID = @AppID  
		order by RowNo
	else if @Operate ='GroupListbyGroup'
		select distinct
			 IDs
			,AppID    
			,GroupID
			,GroupType
			,MemberID		
			,StartDate
			,EndDate
			,Comments
		 	,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as TaskAction 
		 	,dbo.[ActionTask.ASM]('Edit',	 @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as EditAction 
		 	,dbo.[ActionTask.ASM]('Delete',  @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as DeleteAction 

 			,ROW_NUMBER() OVER(ORDER BY MemberID ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_MemberStudents]  
		where schoolCode = @SchoolCode and AppID = @AppID  and GroupID = @GroupID
		order by RowNo	 
	else if @Operate ='GroupListStudent'

		select	 IDs
				,AppID  
				,MemberID
				, GroupType + ' ' +  MemberID as MemberName
				, Comments 
		 		,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as TaskAction 
		 		,dbo.[ActionTask.ASM]('Edit',	 @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as EditAction 
		 		,dbo.[ActionTask.ASM]('Delete',  @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,MemberID,GroupID,GroupType)  as DeleteAction 
				,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
		from dbo.SIC_sys_UserGroup_MemberStudents as M
		where schoolcode = @SchoolCode and AppID =@AppID and GroupID = @GroupID 

 	else if @Operate ='GetMember'
		select distinct
			 S.IDs
			,S.AppID  
			,S.GroupID
			,S.GroupType
			,MemberID		
			,StartDate
			,EndDate
			,S.Comments
			--,dbo.[ActionTask.Group]('TaskMenu',	@UserID,@UserRole,@SchoolYear,@SchoolCode,S.AppID,S.GroupID,M.GroupType,S.IDs)	as TaskAction
			--,dbo.[ActionTask.Group]('Edit'	,	@UserID,@UserRole,@SchoolYear,@SchoolCode,S.AppID,S.GroupID,M.GroupType,S.IDs)	as EditAction
		 --	,dbo.[ActionTask.Group]('Delete' ,	@UserID,@UserRole,@SchoolYear,@SchoolCode,S.AppID,S.GroupID,M.GroupType,S.IDs)	as DeleteAction
		 --	,dbo.[ActionTask.Group]('SubFun' ,	@UserID,@UserRole,@SchoolYear,@SchoolCode,S.AppID,S.GroupID,M.GroupType,S.IDs)	as SubActions
		 	,dbo.[ActionTask.ASM]('TaskMenu',@Type,S.IDs,@SchoolYear,S.SchoolCode, S.AppID,@ModelID,MemberID,M.GroupID,M.GroupType)  as TaskAction 
		 	,dbo.[ActionTask.ASM]('Edit',	 @Type,S.IDs,@SchoolYear,S.SchoolCode, S.AppID,@ModelID,MemberID,M.GroupID,M.GroupType)  as EditAction 
		 	,dbo.[ActionTask.ASM]('Delete',  @Type,S.IDs,@SchoolYear,S.SchoolCode, S.AppID,@ModelID,MemberID,M.GroupID,M.GroupType)  as DeleteAction 
		 	,dbo.[ActionTask.ASM]('SubFun',  @Type,S.IDs,@SchoolYear,S.SchoolCode, S.AppID,@ModelID,MemberID,M.GroupID,M.GroupType)  as SubActions 

 			,ROW_NUMBER() OVER(ORDER BY MemberID ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_MemberStudents] as S 
		left join [dbo].[SIC_sys_UserGroup_Members]		as M on S.SchoolCode  = M.SchoolCode and S.GroupID = m.GroupID
		where S.schoolCode = @SchoolCode and S.AppID = @AppID   and S.GroupID = @GroupID and S.MemberID = @MemberID
		order by RowNo
  
