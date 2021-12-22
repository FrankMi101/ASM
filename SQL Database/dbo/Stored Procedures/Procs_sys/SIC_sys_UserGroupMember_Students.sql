









-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc [dbo].[SIC_sys_UserGroupMemberStudents]    'SecurityContentSIS' ,'mif','Support','20202021','0505' ,'00007742'

CREATE proc [dbo].[SIC_sys_UserGroupMember_Students]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(10) = null,
	@GroupID		varchar(200) = null,
	@MemberID		varchar(20) = null,
	@AppRole		varchar(20) = null,
	@GroupType		varchar(20) = null,
	@Comments		varchar(300) = null
	--@StartDate		varchar(10) = null,
	--@EndDate		varchar(10) = null,
as 

set nocount on
begin
	declare @Result	varchar(500)
	begin try
		  begin tran
			 if @Operate in ('AddGroupStudents','Add')
				begin	
					if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents]  where  SchoolCode =  @SchoolCode and AppID = @AppID and GroupID = @GroupID  and GroupType = @GroupType and MemberID = @MemberID )
						 update [dbo].[SIC_sys_UserGroup_MemberStudents] 
						 set Comments =@Comments,  lu_date=getdate(),lu_user=@UserID, lu_function =app_name()
						-- StartDate = dbo.DateFC(@StartDate,'YYYYMMDD'), EndDate = dbo.DateFC(@EndDate,'YYYYMMDD'),
						 where  GroupID = @SchoolCode and AppID = @AppID and GroupID = @GroupID  and GroupType = @GroupType and MemberID = @MemberID
					else
						Insert into [dbo].[SIC_sys_UserGroup_MemberStudents]
							 (SchoolCode,AppID, GroupID,GroupType,MemberID,Comments,  lu_Date, lu_User,lu_function)
					    values (@SchoolCode,@AppID,@GroupID,@GroupType,@MemberID,@Comments,getdate(),@UserID,app_name())
							--	dbo.DateFC(@StartDate,'YYYYMMDD'),dbo.DateFC(@EndDate,'YYYYMMDD'),) 
			 
 				end
			if @Operate = 'Delete'
				if exists (select 1 from [dbo].[SIC_sys_UserGroup_MemberStudents]  where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID  and MemberID = @MemberID )
						delete [dbo].[SIC_sys_UserGroup_MemberStudents]  where  SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID   and MemberID = @MemberID 

 		  Commit tran
 		  Select 'Successfully' as rValue
	     --	 select dbo.tcdsb_LTO_choiseInterviewCandidate(@SchoolYear,@PositionID) as rValue
   end try
       
   begin catch
           Rollback tran
           Select 'Failed' as rValue
		
    end catch
end

 
