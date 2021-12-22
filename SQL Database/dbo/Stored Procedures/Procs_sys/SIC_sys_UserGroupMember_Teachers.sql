









-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc [dbo].[SIC_sys_UserGroupMember_Teachers] 'GrantPermission' ,'mif','admin','20202021','0361' ,'00016478','SIC','All Students Work Group','Update','2021-04-04','2021-06-30','Test'

CREATE proc [dbo].[SIC_sys_UserGroupMember_Teachers]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(10) = null,
	@GroupID		varchar(200) = null,
	@MemberID		varchar(30) = null,
	@AppRole		varchar(20) = null,
	@StartDate		varchar(10)   = null,
	@EndDate		Varchar(10)   = null,
	@Comments		varchar(300) = null
as 

set nocount on
begin
	declare @Result	varchar(500), @GroupType  varchar(30),@StaffUserID varchar(30)
	set @StaffUserID = dbo.[Staff.ID](@MemberID,'NetWorkUserID')

 	begin try
		  begin tran
				if @Operate = 'AssignNewSchool'
					begin
						if exists (select 1 from [dbo].[tcdsb_LTO_Principal_NewSchool_BeforeSept1] where school_year = @SchoolYear and School_code = @SchoolCode and Userid = @UserID)
							select * from [dbo].[tcdsb_LTO_Principal_NewSchool_BeforeSept1] where school_year = @SchoolYear and School_code = @SchoolCode and Userid = @UserID
						else
							insert into  [dbo].[tcdsb_LTO_Principal_NewSchool_BeforeSept1]
							(School_Year,school_code,School,Principal_Name, FirstName, LastName, UserID, CPNum,CSchool, Position,Status, Active)
							select top 1  @SchoolYear,@SchoolCode, dbo.[School.Name](@SchoolCode), FirstName + ' ' + LastName, FirstName,LastName, UserID,CPNum, schoolCode, 'Principal','3-Active','X'
							from [dbo].[SIC_sys_Employee]
							Where UserID = @StaffUserID
					end
				else if @Operate = 'AddUserToSchool'
					begin	
						set @GroupType = (select top 1 GroupType  from dbo.SIC_sys_UserGroup_Members  where GroupID = @GroupID )
						if exists (select 1 from dbo.SIC_sys_Employee_OverWriteSAP   where SchoolYear = @SchoolYear and GroupID = @SchoolCode and UserID = @StaffUserID and AppID =@AppID )
							select 'User Already exists' as rValue
						else
							Insert into [dbo].[SIC_sys_Employee_OverWriteSAP]
								 (SchoolYear, GroupID,GroupType, UserID,FirstName, LastName,AppID,AppRole,StartDate,EndDate,ActiveFlag, lu_Date, lu_User,lu_function)
							select @SchoolYear,@SchoolCode, @GroupType, @StaffUserID, FirstName, LastName, @AppID, @AppRole,@StartDate, @EndDate,'X',getdate(),@UserID,app_name()
							from dbo.SIC_sys_employee
							where userid = @StaffUserID

						  --  values (@SchoolYear,@SchoolCode,@StaffUserID, dbo.[Staff.Name](@StaffUserID,'Name'), @AppID,@UserRole,
							--		 @StartDate, @EndDate,'X',getdate(),@UserID,app_name()) 
							--		dbo.DateFC(@StartDate,'YYYYMMDD'),dbo.DateFC(@EndDate,'YYYYMMDD'),'x',getdate(),@UserID,app_name()) 
					end
 
				else if @Operate in ('GrantPermission','Add') 
					begin				 
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID and MemberID = @StaffUserID)
							select 'User Already exists in Group' as rValue
						else
							begin
								if not exists(select  * from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID)
									insert into  [dbo].[SIC_sys_UserGroup_Members]
									( SchoolCode, AppID, GroupID, GroupName, GroupType,Permission, Active_flag,lu_Date, lu_User,lu_function)
									select top 1  @SchoolCode, AppID, GroupID, GroupName, GroupType,Permission, Active_flag, getdate(),@UserID,app_name()
									from [dbo].[SIC_sys_UserGroup_Members]
									where  SchoolCode = '0000' and AppID = 'SIC' and GroupID = @GroupID

 								Insert into  [dbo].[SIC_sys_UserGroup_MemberTeachers]
									   ( SchoolCode, AppID, GroupID, MemberID,    Comments, StartDate, EndDate,lu_Date, lu_User,lu_function)
								values(@SchoolCode, @AppID,@GroupID,@StaffUserID,@Comments,@StartDate,@EndDate, getdate(),@UserID,app_name())
							end
 					end

				else if @Operate ='Edit'
					begin				 
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where  SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID and MemberID = @StaffUserID)
							update [dbo].[SIC_sys_UserGroup_MemberTeachers]  set StartDate = @StartDate, EndDate =@EndDate , Comments =@Comments,
									lu_date =getdate(),lu_user = @UserID, lu_function =App_name()
							where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID and MemberID = @StaffUserID
					END

				else if @Operate in ('RemoveUserFromGroup','Delete')
					if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers]  where SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID and MemberID = @MemberID )
						delete [dbo].[SIC_sys_UserGroup_MemberTeachers]  where SchoolCode =@SchoolCode and AppID = @AppID and GroupID = @GroupID and MemberID = @StaffUserID 
 		

	Commit tran
 		  Select 'Successfully' as rValue
    end try
       
   begin catch
           Rollback tran
           Select 'Failed' as rValue
		
    end catch
end

 
