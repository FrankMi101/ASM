






 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserRoleMatchManagement 'GetList' ,'mif','admin','Teacher','ClassDesc'
CREATE  proc [dbo].[SIC_asm_AppRoleMatch_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@RoleID			varchar(20) =null, 
	@RoleType		varchar(50) =null, 
	@MatchDesc		varchar(200) =null, 
	@MatchRole		varchar(20) =null,  
	@MatchScope		varchar(20) = null 
as 

set nocount on
 
	begin
		begin try
			 begin tran		
				 if @RoleType ='PositionDesc' 
					begin
						if @Operate ='Edit' 
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_PositionDesc]  where  PositionDesc = @MatchDesc)
									 Update  [dbo].[SIC_sys_UserProfileMatch_PositionDesc] 
									 set UserRole  = @MatchRole , UserScope =@MatchScope
										 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
									 where   PositionDesc = @MatchDesc 
					 
							end
						if @Operate ='Add'
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_PositionDesc] where   PositionDesc = @MatchDesc )
									select 'This is a already a Role named ' + @MatchDesc + ' In the system' as rValue
								else
									begin
										Insert into  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
											(  PositionDesc,UserRole, UserScope,lu_Date, lu_User,lu_function)
										values( @MatchDesc,@MatchRole,@MatchScope, getdate(),@UserID,app_name() )
							 
									end
 							end
						if @Operate ='Del'
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_PositionDesc] where  PositionDesc = @MatchDesc  )
									delete [dbo].[SIC_sys_UserProfileMatch_PositionDesc] where  PositionDesc = @MatchDesc 
								else
									select 'This is no such Role named ' + @MatchDesc + ' In the system' as rValue
				 
 							end
					end
				else if @RoleType ='ClassDesc' 
					begin
						if @Operate ='Edit' 
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]  where  ClassTypeIDDesc  = @MatchDesc)
									 Update  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc] 
									 set UserRole  = @MatchRole , UserScope =@MatchScope 
									 where   ClassTypeIDDesc = @MatchDesc 
					 
							end
						if @Operate ='Add'
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc] where   ClassTypeIDDesc = @MatchDesc )
									select 'This is a already a Role named ' + @MatchDesc + ' In the system' as rValue
								else
									begin
										Insert into  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
											(  ClassTypeIDDesc,UserRole, UserScope )
										values( @MatchDesc,@MatchRole,@MatchScope  )
							 
									end
 							end
						if @Operate ='Del'
							begin
								if exists (select 1 from [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc] where  ClassTypeIDDesc = @MatchDesc  )
									delete [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc] where  ClassTypeIDDesc = @MatchDesc 
								else
									select 'This is no such Role named ' + @MatchDesc + ' In the system' as rValue
				 
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
