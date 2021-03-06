



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Sept 23, 2021  
-- Description	: get staff work school selected
-- =====================================================================================

CREATE  proc [dbo].[SIC_asm_AppStaffWorkingSchools_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10)	= null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@StaffUserID	varchar(30) =null, 
	@AppID			varchar(30) =null, 
	@AppRole		varchar(30) =null 
  as 
 
set nocount on
if @Operate ='Get'  
	begin
		select distinct
			 IDs
			,GroupID as SchoolCode
			,UserID	 as StaffUserID 
			,UserName
			,StartDate
			,EndDate		
			,GroupType 
			,Activeflag as IsActive 
	 	from [dbo].[SIC_sys_UserWorkingSchools] 
		where  IDs = @IDs
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate in ('Edit','Add') 					 
					begin
						if exists (select 1 from [dbo].[SIC_sys_UserWorkingSchools]  where SchoolYear = @SchoolYear and GroupType ='School' and GroupID = @SchoolCode and UserID = @StaffUserID)
							delete  [dbo].[SIC_sys_UserWorkingSchools]  where  SchoolYear = @SchoolYear and GroupType ='School' and GroupID = @SchoolCode and UserID = @StaffUserID
						else
							begin
								Insert into  [dbo].[SIC_sys_UserWorkingSchools]
									(  SchoolYear,GroupType, GroupID,AppID,AppRole,UserID,UserName,  StartDate, EndDate,ActiveFlag, lu_Date,lu_user, lu_Function)
								values( @Schoolyear,'School',@SchoolCode,@AppID,@AppRole,@StaffUserID, [dbo].[Staff.Name](@StaffUserID,'Name'), getdate(), getdate() + 365, 'X',getdate(),@UserID,app_name() )
							 
								set @newID = cast(@@IDENTITY as varchar(10))

							end
 					end
				if @Operate ='Delete'
					begin
						if exists (select 1 from[dbo].[SIC_sys_UserWorkingSchools] where IDs = @IDs)
							delete [dbo].[SIC_sys_UserWorkingSchools] where IDs   =  @IDs
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
