





 
	

 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: July 31, 2021  
-- Description	: get Operate Student Group member   
-- ===================================================================================== 
CREATE  proc [dbo].[SIC_asm_AppStaffWorkingGroup_Read]  -- 'GroupListTeacher','mif','Admin','0000','SIC','All Board Schools'
	@Operate		varchar(30),
	@UserID			varchar(30)= null,
	@UserRole		varchar(30) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(100) =null, 
	@MemberID		varchar(20) = null,
	@IDs			varchar(10)	= null 

as 

set nocount on
	
declare @GoPage varchar(100), @Target varchar(50),@Type varchar(10),@SchoolYear varchar(8),@ModelID varchar(50) 
select  @SchoolYear ='20202021', @Type ='WorkingGroup', @ModelID ='Pages' -- @iPage ='GroupManageSub.aspx', @iTarget='IframeSubArea' ,
	  
	if @Operate ='GroupListTeacher'

		 select 
		 [dbo].[Staff.Name]( MemberID,'Name') as MemberName, 
		  Comments
		,dbo.DateF( StartDate,'YYYY-MM-DD') as StartDate
		,dbo.DateF( EndDate,'YYYY-MM-DD') as EndDate 
		,dbo.[ActionTask.ASM]('Edit',  @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as EditAction
		,dbo.[ActionTask.ASM]('Delete',@Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as DeleteAction
		,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
	    from dbo.SIC_sys_UserGroup_MemberTeachers 
		where schoolcode = @SchoolCode and AppID =@AppID and GroupID = @GroupID 

	else if @Operate ='GroupListbyApp'

		 select 
		 [dbo].[Staff.Name]( MemberID,'Name') as MemberName, 
		  Comments
		,dbo.DateF( StartDate,'YYYY-MM-DD') as StartDate
		,dbo.DateF( EndDate,'YYYY-MM-DD') as EndDate 
		,dbo.[ActionTask.ASM]('Edit',  @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as EditAction
		,dbo.[ActionTask.ASM]('Delete',@Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as DeleteAction
 		,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
	     from dbo.SIC_sys_UserGroup_MemberTeachers 
		where schoolcode = @SchoolCode and AppID =@AppID 

	else if @Operate ='GroupListbyGroup'

		 select 
		 [dbo].[Staff.Name]( MemberID,'Name') as MemberName, 
		  Comments
		,dbo.DateF( StartDate,'YYYY-MM-DD') as StartDate
		,dbo.DateF( EndDate,'YYYY-MM-DD') as EndDate 
		,dbo.[ActionTask.ASM]('Edit',  @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as EditAction
		,dbo.[ActionTask.ASM]('Delete',@Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as DeleteAction
		,ROW_NUMBER() OVER(ORDER BY MemberID) AS RowNo 
	     from dbo.SIC_sys_UserGroup_MemberTeachers 
		where schoolcode = @SchoolCode and AppID =@AppID and GroupID = @GroupID 
	else if @Operate ='GetMemberListbyGroup'
		select distinct
			 AppID  
			,GroupID
			,MemberID		
			,StartDate
			,EndDate
			,Comments		
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as TaskAction
			,dbo.[ActionTask.ASM]('Edit',    @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as EditAction
			,dbo.[ActionTask.ASM]('Delete',  @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as DeleteAction
 
 			,ROW_NUMBER() OVER(ORDER BY MemberID ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_MemberTeachers] 
		where schoolCode = @SchoolCode and AppID = @AppID  and GroupID = @GroupID
		order by RowNo


 	else if @Operate ='GetMember'
		select distinct
			 AppID  
			,GroupID
			,MemberID		
			,StartDate
			,EndDate
			,Comments
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as TaskAction
			,dbo.[ActionTask.ASM]('Edit',    @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as EditAction
			,dbo.[ActionTask.ASM]('Delete',  @Type,IDs,@SchoolYear, SchoolCode, AppID,@ModelID,MemberID,GroupID,'Teachers')  as DeleteAction
			--,dbo.[ActionTask.Group.Member]('TaskMenu', IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Teachers')  as TaskAction
			--,dbo.[ActionTask.Group.Member]('Edit', IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Teachers')  as EditAction
			--,dbo.[ActionTask.Group.Member]('Delete', IDs, @UserRole, @SchoolYear,  SchoolCode, AppID,  GroupID, MemberID,'Teachers')  as DeleteAction

 			,ROW_NUMBER() OVER(ORDER BY MemberID ) AS RowNo 
 		from  [dbo].[SIC_sys_UserGroup_MemberTeachers] 
		where schoolCode = @SchoolCode and AppID = @AppID   and GroupID = @GroupID and MemberID = @MemberID
		order by RowNo
	else  if @Operate ='GetMemberbyID'  
		begin
			select distinct
			 SchoolCode
			,AppID  
			,GroupID
			,MemberID
			,StartDate	
			,EndDate 
			,Comments
			from [dbo].[SIC_sys_UserGroup_MemberTeachers]
			where  IDs = @IDs		
	end		
  
