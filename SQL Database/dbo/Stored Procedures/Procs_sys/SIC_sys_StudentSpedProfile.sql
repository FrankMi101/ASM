
 





-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: Edit student Special Education Program  
-- =====================================================================================
 
CREATE proc [dbo].[SIC_sys_StudentSpedProfile]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@StudentID		varchar(15) = null,
	@Exceptionality	varchar(15) = null,
	@Placement		varchar(10) = null,
	@Program		varchar(20) = null 
as 

set nocount on
begin
	declare @Result	varchar(500) ,  @HasMemberT bit
		begin try
			  begin tran
			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_Student_SpedProgramProfile] where  SchoolYear =@SchoolYear and StudentID  = @StudentID  )
							 Update  [dbo].[SIC_Student_SpedProgramProfile] 
							 set  Exceptionality =@Exceptionality, Placement = @Placement, 
								  lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where  SchoolYear =@SchoolYear and StudentID  = @StudentID 
						else
							 insert into [dbo].[SIC_Student_SpedProgramProfile]
							 (SchoolYear, StudentID, Exceptionality,Placement, lu_date,lu_user,lu_function)
							 values (@Schoolyear, @StudentID,@Exceptionality, @Placement,  getdate(),@UserID,app_name())
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_Student_SpedProgramProfile] where  SchoolYear =@SchoolYear and StudentID  = @StudentID   )
							select 'Student Special Education Profile Exists in System' as rValue
						else
							insert into [dbo].[SIC_Student_SpedProgramProfile]
							 (SchoolYear, StudentID, Exceptionality,Placement, lu_date,lu_user,lu_function)
							 values (@Schoolyear, @StudentID,@Exceptionality, @Placement,  getdate(),@UserID,app_name())
 					end
				if @Operate ='Del'
					begin
						if exists (select 1 from [dbo].[SIC_Student_SpedProgramProfile] where  SchoolYear =@SchoolYear and StudentID  = @StudentID   )							 
							delete [dbo].[SIC_Student_SpedProgramProfile] where  SchoolYear =@SchoolYear and StudentID  = @StudentID 
						else
							select 'This is no Student Profile ' as rValue			 
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

 
