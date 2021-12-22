










-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Group list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppUserGroupEdit 'Add' ,'mif','0','0354','TPA','New User Group 15' ,'New User Group 15 ','School','Update','X',  'testing for TPA','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppUserGroup_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10)	= null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(100) =null, 
	@GroupName		varchar(200) = null,
	@GroupType		varchar(10) =null,  
	@Permission		varchar(20) = null,
	@IsActive		varchar(20) = null,
	@Comments		varchar(250) = null
as 

set nocount on
 if @Operate ='Get'  
	begin
		select distinct
			 IDs
			,SchoolCode
			,AppID  
			,GroupID
			,GroupName
			,GroupType
			,Permission		
			,Active_flag as IsActive 
			,Comments
			,'No' as HasMemberT
			,'' as MemberID
		from [dbo].[SIC_sys_UserGroup_Members] 
		where  IDs = @IDs
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members]  where IDs = @IDs )-- GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID )
							 Update  [dbo].[SIC_sys_UserGroup_Members] 
							 set GroupName = @GroupName ,GroupType = @GroupType, Permission = @Permission, Active_flag = @IsActive, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where IDs = @IDs --and GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID
						else 
							select 'Group name ' + @GroupID + ' does not exists in the system' as rValue
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where schoolCode = @SchoolCode and GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID )
							 select 'Group name ' + @GroupID + ' exists in the system already' as rValue
							--select top  1 IDs as rValue  from [dbo].[SIC_sys_UserGroup_Members] where schoolCode = @SchoolCode and GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID
						else
							begin
								Insert into  [dbo].[SIC_sys_UserGroup_Members]
									(   SchoolCode, AppID, GroupID, GroupName, GroupType,  Permission, Active_flag, Comments,lu_Date, lu_User,lu_function)
								values( @SchoolCode,@AppID,@GroupID,@GroupName,@GroupType, @Permission,@IsActive,  @Comments, getdate(),@UserID,app_name() )
							 
							  set @newID = cast(@@IDENTITY as varchar(10))

							end
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where  schoolCode = @SchoolCode and GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID)
							delete [dbo].[SIC_sys_UserGroup_Members] where  schoolCode = @SchoolCode and GroupType = @GroupType  and AppID = @AppID and GroupID = @GroupID
						else
							select 'Group name ' + @GroupID + ' does not exists in the system' as rValue
 					end
				if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_Members] where IDs = @IDs)
							delete [dbo].[SIC_sys_UserGroup_Members] where IDs   =  @IDs
						else
							select 'Group name ' + cast( @IDs as varchar(10)) + ' does not exists in the system' as rValue
 					end
 			  Commit tran
 
 				Select 'Successfully' + @newID as rValue

	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
