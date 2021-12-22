










 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: July 31, 2021  
-- Description	: get Operate Student Group member   
-- ===================================================================================== 
--          [dbo].[SIC_asm_AppUserGroupMemberS_Edit]  'Add','tester','0','0354','SIC','Primary Student Work group','06','Grade','2020-09-01','2021-06-30','Test '
CREATE  proc [dbo].[SIC_asm_AppUserGroupMemberS_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30)= null,
	@IDs			varchar(10)	= null ,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(100) = null, 
	@MemberID		varchar(20) = null,
	@GroupType		varchar(10) = null,  
--	@StartDate		varchar(10) = null,
--	@EndDate		varchar(10) = null,
	@Comments		varchar(250) = null
as 

set nocount on
	set nocount on
if @Operate ='Get'  
	begin
		select distinct
			 SchoolCode
			,AppID  
			,GroupID
			,MemberID
			,GroupType
			,StartDate	
			,EndDate 
			,Comments
		from [dbo].[SIC_sys_UserGroup_MemberStudents]
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
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where   AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID ) -- IDs = @IDs )
							 Update  [dbo].[SIC_sys_UserGroup_MemberStudents]
							 set MemberID = @MemberID , Comments = @Comments -- ,  StartDate = @StartDate, EndDate = @EndDate
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where   AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID 
						else
							select 'Group member ' + @MemberID + ' does not exists in the system' as rValue				 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID  )
							  select 'Group member ' + @memberID  + ' exists in the system already' as rValue
							-- select top 1 IDs as rValue  from [dbo].[SIC_sys_UserGroup_MemberStudents] where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID 
						else
							Insert into  [dbo].[SIC_sys_UserGroup_MemberStudents]
									(   SchoolCode, AppID, GroupID, GroupType, MemberID,    Comments, lu_Date, lu_User,lu_function)
								values( @SchoolCode,@AppID,@GroupID,@GroupType,@MemberID,    @Comments, getdate(),@UserID,app_name() )			 
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID )
							delete [dbo].[SIC_sys_UserGroup_MemberStudents]  where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID 
						else
							select 'Group member ' + @MemberID + ' does not exists in the system' as rValue
 
 					end
				if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents] where IDs = @IDs)
							delete [dbo].[SIC_sys_UserGroup_MemberStudents] where IDs = @IDs
						else
							select 'Group member ' +  cast( @IDs as varchar(10)) + ' does not exists in the system' as rValue
				 
 					end
 			  Commit tran
 			  	if @Operate ='Add'  set @newID = cast(@@IDENTITY as varchar(10))  

 				Select 'Successfully' + @newID as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
