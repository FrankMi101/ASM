






 

 
 
-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Group list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppUserGroup_Read 'GroupList' ,'mif','admin', '0000' , 'SIC' 
CREATE  proc [dbo].[SIC_asm_AppUserGroup_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30) =null,
	@UserRole		varchar(30) =null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) =null


as 

set nocount on
 declare @GoPage varchar(100), @Target varchar(50),@Type varchar(10),@SchoolYear varchar(8),@ModelID varchar(50)
select @GoPage ='Security_Group.aspx' -- , @Target ='EditDIV',@Height='400',@Width ='600' -- , @GoPage ='../SICCommon/Security_Group.aspx' 
select  @SchoolYear ='20202021', @Type ='Group', @ModelID ='Pages' -- @iPage ='GroupManageSub.aspx', @iTarget='IframeSubArea' ,
  
 
 
if @Operate ='GroupList'
	select distinct
			  IDs	
			, AppID  
			, GroupID
			, GroupName
			, GroupType
			, Permission		
			,case isnull( Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,Comments
			,'true' as HasMemberT
			,'00' as MemberID
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)  as Actions
			,dbo.[ActionTask.ASM]('Edit',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as EditAction
			,dbo.[ActionTask.ASM]('View',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as ViewAction
			,dbo.[ActionTask.ASM]('Delete',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as DeleteAction
			,dbo.[ActionTask.ASM]('SubFun', @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as SubActions
 		 
 			,ROW_NUMBER() OVER(ORDER BY AppID, GroupID ) AS RowNo 
 	 	from  [dbo].[SIC_sys_UserGroup_Members]	   
		where    SchoolCode = @SchoolCode  and  AppID = @AppID --and  GroupID = @GroupID
 
else if @Operate ='GetList' 
 	begin		 
		select distinct
			 IDs
			,AppID  
			,GroupID
			,GroupName
			,GroupType
			,Permission		
			,case isnull(Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,Comments
			,'true' as HasMemberT
			,'00' as MemberID
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)  as Actions
			,dbo.[ActionTask.ASM]('Edit',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as EditAction
			,dbo.[ActionTask.ASM]('View',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as ViewAction
			,dbo.[ActionTask.ASM]('Delete',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as DeleteAction
			,dbo.[ActionTask.ASM]('SubFun', @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as SubActions
 	 
 			,ROW_NUMBER() OVER(ORDER BY GroupType, GroupName ) AS RowNo 
		from  [dbo].[SIC_sys_UserGroup_Members]  
		where  schoolCode = @SchoolCode
		order by RowNo
	end
else if @Operate ='GetListbyApp' 
	begin
		select distinct
			IDs
			,AppID  
			,GroupID
			,GroupName
			,GroupType
			,Permission		
			,case isnull(Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,Comments
			,'true' as HasMemberT
			,'00' as MemberID
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)  as Actions
			,dbo.[ActionTask.ASM]('Edit',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as EditAction
			,dbo.[ActionTask.ASM]('View',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as ViewAction
			,dbo.[ActionTask.ASM]('Delete',	@Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as DeleteAction
			,dbo.[ActionTask.ASM]('SubFun', @Type,IDs,@SchoolYear,SchoolCode, AppID,@ModelID,GroupID,GroupName,GroupType)	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY GroupType, GroupName ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_Members]  
		where schoolCode = @SchoolCode and AppID = @AppID
		order by RowNo
	end
