






-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: July 31, 2021  
-- Description	: get Operate Student Group member   
-- ===================================================================================== 
--  [dbo].[SIC_asm_AppUserGroupMemberT_Edit]   'AddUserToSchool','mif','0','0354','SIC',' Kindergarten Students Work Group', '00010051','2020-09-01','2021-06-30','Test'
CREATE  proc [dbo].[SIC_asm_AppStaffWorkingGroups_Edit]    
	@Operate		varchar(30),
	@UserID			varchar(30)= null,
	@IDs			varchar(10)	= null ,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(100) =null, 
	@MemberID		varchar(20) = null,
	@StartDate		varchar(10) = null,
	@EndDate		varchar(10) = null,
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
			,MemberID
			,StartDate	
			,EndDate 
			,Comments
	 		from [dbo].[SIC_sys_UserGroup_MemberTeachers]
			where  IDs = @IDs		
	end		
else
	begin
		declare @Result	varchar(500), @GroupType  varchar(30),@StaffUserID varchar(30),@newID varchar(10) ,@SchoolYear varchar(8), @AppRole varchar(30)
		set @StaffUserID = dbo.[Staff.ID](@MemberID,'NetWorkUserID') 
		select @GroupType = (select top 1 GroupType  from dbo.SIC_sys_UserGroup_Members  where GroupID = @GroupID )
			 , @SchoolYear = dbo.[Current.SchoolYear](getdate())
			 , @newID=''
			 , @AppRole = [dbo].[Staff.Role](@StaffUserID,@AppID )

		begin try
			  begin tran	
				if @Operate = 'AssignNewSchool'
					begin
						if exists (select * from [dbo].[tcdsb_LTO_Principal_NewSchool_BeforeSept1] where school_year = @SchoolYear and School_code = @SchoolCode and Userid = @UserID)
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
						if exists (select * from dbo.SIC_sys_Employee_OverWriteSAP   where SchoolYear = @SchoolYear and GroupID = @SchoolCode and UserID = @StaffUserID and AppID =@AppID )
							select 'User Already exists' as rValue
						else
							Insert into [dbo].[SIC_sys_Employee_OverWriteSAP]
								 (SchoolYear, GroupID,GroupType, CPNum, UserID,FirstName, LastName,AppID,AppRole,StartDate,EndDate,ActiveFlag, lu_Date, lu_User,lu_function)
							select @SchoolYear,@SchoolCode, @GroupType, @MemberID, @StaffUserID, FirstName, LastName, @AppID, @AppRole,@StartDate, @EndDate,'X',getdate(),@UserID,app_name()
							from dbo.SIC_sys_employee
							where userid = @StaffUserID

						  --  values (@SchoolYear,@SchoolCode,@StaffUserID, dbo.[Staff.Name](@StaffUserID,'Name'), @AppID,@UserRole,
							--		 @StartDate, @EndDate,'X',getdate(),@UserID,app_name()) 
							--		dbo.DateFC(@StartDate,'YYYYMMDD'),dbo.DateFC(@EndDate,'YYYYMMDD'),'x',getdate(),@UserID,app_name()) 
					end
				else if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where   AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID ) -- IDs = @IDs )
							 Update  [dbo].[SIC_sys_UserGroup_MemberTeachers]
							 set MemberID = @MemberID ,  StartDate =dbo.DateFC(@StartDate,'YYYYMMDD'), EndDate =dbo.DateFC(@EndDate,'YYYYMMDD'), Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where   AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID 
						else
							select 'Group member ' + @MemberID + ' does not exists in the system' as rValue				 
					end
				else if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID  )
							select 'Group member ' + @memberID  + ' exists in the system already' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_UserGroup_MemberTeachers]
									(   SchoolCode, AppID, GroupID,MemberID,Comments, StartDate,EndDate,lu_Date, lu_User,lu_function)
								values( @SchoolCode,@AppID,@GroupID,@StaffUserID, @Comments, dbo.DateFC(@StartDate,'YYYYMMDD'),dbo.DateFC(@EndDate,'YYYYMMDD'), getdate(),@UserID,app_name() )

								set @newID = cast(@@IDENTITY as varchar(10))  
							end	
 					end
				else if @Operate ='Remove'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID )
							delete [dbo].[SIC_sys_UserGroup_MemberTeachers]  where  AppID = @AppID and SchoolCode = @SchoolCode and GroupID = @GroupID and MemberID = @MemberID 
						else
							select 'Group member ' + @MemberID + ' does not exists in the system' as rValue
 
 					end
				else if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberTeachers] where IDs = @IDs)
							delete [dbo].[SIC_sys_UserGroup_MemberTeachers] where IDs = @IDs
						else
							select 'Group member ' +  cast( @IDs as varchar(10)) + ' does not exists in the system' as rValue
				 
 					end
 			  Commit tran
 
 				Select 'Successfully' + @newID as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select  ERROR_MESSAGE() as rValue -- 'Failed' as rValue
		end catch		
	end
