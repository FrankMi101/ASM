











-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 13, 2021  
-- Description	: push a grup from one app to another app
-- =====================================================================================
 
 
CREATE  proc [dbo].[SIC_asm_AppUserGroup_Push]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(10) = null,
	@GroupID		varchar(200) = null,
	@AppIDTo		varchar(10) = null,
	@IncludeStudent	varchar(10) = null, 
	@IncludeTeacher	varchar(10) = null 
as 

set nocount on
begin
	if @Operate ='Push'
		begin try
			  begin tran
				 if not exists (select * from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode = @SchoolCode and AppID = @AppIDTo and GroupID = @GroupID)
					begin
						insert into  [dbo].[SIC_sys_UserGroup_Members]
							(SchoolCode, AppID, GroupID,GroupName,GroupType,Permission, Active_flag, Comments,lu_Date, lu_User,lu_function)
						select  SchoolCode, @AppIDTo, GroupID,GroupName,GroupType,Permission, Active_flag, Comments,getdate(),@UserID,app_name()
						from [dbo].[SIC_sys_UserGroup_Members] where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID

						if @InCludeStudent ='true'
							begin
								 insert into [dbo].[SIC_sys_UserGroup_MemberStudents]
										(SchoolCode, AppID, GroupID,GroupType,MemberID, Comments, lu_date,lu_user,lu_function) 
								 select SchoolCode, @AppIDTo, GroupID,GroupType,MemberID, Comments, getdate(),@UserID,app_name()
								 from  [dbo].[SIC_sys_UserGroup_MemberStudents]
								 where SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID
							end
						if @InCludeTeacher ='true'
							begin
								 insert into [dbo].[SIC_sys_UserGroup_MemberTeachers]
										(SchoolCode, AppID, GroupID, MemberID,StartDate,EndDate, Comments, lu_date,lu_user,lu_function) 
								 select   SchoolCode, @AppIDTo, GroupID,MemberID,StartDate,EndDate, Comments, getdate(),@UserID,app_name()
								 from  [dbo].[SIC_sys_UserGroup_MemberTeachers]
								 where SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID
							end
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

 
