










-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc dbo.[dbo].[SIC_sys_UserGroupMember] 'SecurityContentSIS' ,'mif','Support','20202021','0505' ,'00007742'
 
CREATE proc [dbo].[SIC_sys_UserGroupMember]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(10) = null,
	@GroupID		varchar(200) = null,
	@GroupName		varchar(350) = null,
	@GroupType		varchar(20) = null,
	@Permission		varchar(20) = null,
	@IsActive		varchar(10) =null,
	@Comments		varchar(300) = null,
	@StudentMember	varchar(50) = null
as 

set nocount on
begin
	declare @Result	varchar(500) ,  @HasMemberT bit
	if @Operate ='Get'
		begin
			if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents]   where   SchoolCode = @SchoolCode and GroupID = @GroupID and AppID = @AppID)
				set @StudentMember = (select top 1 MemberID from [dbo].[SIC_sys_UserGroup_MemberStudents]   where   SchoolCode = @SchoolCode and GroupID = @GroupID and AppID = @AppID)
			else 
				set @StudentMember = ''
			if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where   SchoolCode = @SchoolCode and GroupID = @GroupID and AppID = @AppID)
				set @HasMemberT = 1
			else
				set @HasMemberT = 0
 
			select distinct M.SchoolCode,M.AppID  
			,M.GroupID
			,M.GroupName
			,M.GroupType
			,M.Permission
			,M.Comments
 		--	,dbo.DateF(getdate(),'YYYY-MM-DD')			as StartDate
			--,dbo.DateF(getdate(),'YYYY-MM-DD')			as EndDate 	
			,IDs 
			,@StudentMember as StudentMember
			,@HasMemberT as HasMemberT
			,case isnull(M.Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
 			from [dbo].[SIC_sys_UserGroup_Members] as M 
			where   SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID
		end
	else if @Operate ='HasMember'
		begin
			if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where   SchoolCode = @SchoolCode and GroupID = @GroupID and AppID = @AppID)
				select 'Yes'
			else if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where   SchoolCode = @SchoolCode and GroupID = @GroupID and AppID = @AppID)
				select 'Yes'
			else
				select 'No'

		end
	else
		begin try
			  begin tran
			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID )
							 Update  [dbo].[SIC_sys_UserGroup_Members] 
							 set GroupName =@GroupName ,GroupType = @GroupType, Permission = @Permission, Active_flag = @IsActive, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID 
						if not exists(select * from [dbo].[SIC_sys_UserGroup_MemberStudents] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID and GroupType =@GroupType and MemberID = @StudentMember)
							 insert into [dbo].[SIC_sys_UserGroup_MemberStudents]
							 (SchoolCode, AppID, GroupID,GroupType,MemberID, Comments, lu_date,lu_user,lu_function)
							 values (@SchoolCode, @AppID,@GroupID, @GroupType,@StudentMember,@Comments, getdate(),@UserID,app_name())
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID )
							select 'This is a already a Group named ' + @GroupID + ' In the system' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserGroup_Members]
									(SchoolCode, AppID, GroupID,GroupName,GroupType,Permission, Active_flag, Comments,lu_Date, lu_User,lu_function)
								values(@SchoolCode, @AppID,@GroupID,@GroupName,@GroupType,@Permission,@IsActive,@Comments, getdate(),@UserID,app_name() )
								if @StudentMember !='' 
									begin
										if not exists(select * from [dbo].[SIC_sys_UserGroup_MemberStudents] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID and GroupType =@GroupType and MemberID = @StudentMember)
											 insert into [dbo].[SIC_sys_UserGroup_MemberStudents]
											 (SchoolCode, AppID, GroupID,GroupType,MemberID, Comments, lu_date,lu_user,lu_function)
											 values (@SchoolCode, @AppID,@GroupID, @GroupType,@StudentMember,@Comments, getdate(),@UserID,app_name())
									end
							end
 					end
				if @Operate ='Del'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID )
							begin
								declare @HasMember varchar(10) set @HasMember ='No'
								if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID )
									set @HasMember ='Yes'
								if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID )
									set @HasMember ='Yes'
								if @HasMember ='Yes'
									select 'The Group ' + @GroupID + 'include the group member' as rValue
								else
									delete [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID
							end
						else
							select 'This is no such Group named ' + @GroupID + ' In the system' as rValue
				 
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

 
