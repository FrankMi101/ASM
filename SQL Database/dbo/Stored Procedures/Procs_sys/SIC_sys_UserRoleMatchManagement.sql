



 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_UserRoleMatchManagement 'GetList' ,'mif','admin','Teacher','ClassDesc'
CREATE proc [dbo].[SIC_sys_UserRoleMatchManagement]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@AppID			varchar(20) =null, 
	@RoleID			varchar(20) =null, 
	@RoleType		varchar(50) =null, 
	@MatchDesc		varchar(200) =null, 
	@MatchRole		varchar(20) =null,  
	@MatchScope		varchar(20) = null 
as 

set nocount on
 
if @Operate ='GetList' 
 	begin		
		declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4), @iPage varchar(100),@iTarget varchar(50)
		select @GoPage ='../SICCommon/Security_RoleMatch.aspx'  , @Target ='EditDIV',@Height='250',@Width ='450'
		select @iPage ='SecurityRoleManageSub.aspx', @iTarget='IframeSubArea'
		if @RoleType ='PositionDesc' 
			begin
				if @RoleID ='Other'
					select distinct
						 UserRole as MatchRole  
						,UserScope as MatchScope
						,PositionDesc as MatchDesc 
			 			--,dbo.[ActionTask.Role]('RoleMatchEdit',0,@UserID, @UserRole,  UserScope, UserRole,PositionDesc,@RoleType)	as EditAction 		 
						,dbo.[ActionTask.Role]('Edit',@GoPage,@Target,@Height,@Width,@UserID, @UserRole, UserRole, UserScope,PositionDesc,PositionDesc,@RoleType)	as EditAction
 						,ROW_NUMBER() OVER(ORDER BY PositionDesc ) AS RowNo 
 	 	 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
					where UserRole not in (select RoleID from  [dbo].[SIC_sys_UserRole])   
					order by RowNo
				else
					select distinct
						 UserRole as MatchRole  
						,UserScope as MatchScope
						,PositionDesc as MatchDesc 
			 		--	,dbo.[ActionTask.Role]('RoleMatchEdit',0,@UserID, @UserRole,  UserScope, UserRole,PositionDesc,@RoleType)	as EditAction 		 
 						,dbo.[ActionTask.Role]('Edit',@GoPage,@Target,@Height,@Width,@UserID, @UserRole, UserRole, UserScope,PositionDesc,PositionDesc,@RoleType)	as EditAction
						,ROW_NUMBER() OVER(ORDER BY PositionDesc ) AS RowNo 
 	 	 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
					where UserRole =   @RoleID  
					order by RowNo
			end
		else if @RoleType ='ClassDesc'
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,ClassTypeIDDesc as MatchDesc 
				--,dbo.[ActionTask.Role]('RoleMatchEdit',0,@UserID, @UserRole, UserScope, UserRole, ClassTypeIDDesc,@RoleType)	as EditAction 		 
				,dbo.[ActionTask.Role]('Edit',@GoPage,@Target,@Height,@Width,@UserID, @UserRole, UserRole, UserScope,ClassTypeIDDesc,ClassTypeIDDesc,@RoleType)	as EditAction
 				,ROW_NUMBER() OVER(ORDER BY ClassTypeIDDesc ) AS RowNo 
 			from  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
			where UserRole = @RoleID  
			order by RowNo
	end
else if @Operate ='Get'  
	begin
		if @RoleType ='PositionDesc' 
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,PositionDesc as MatchDesc
				 
 			from  [dbo].[SIC_sys_UserProfileMatch_PositionDesc]
			where  PositionDesc = @MatchDesc
			 
		else if @RoleType ='ClassDesc'
			select distinct
				 UserRole as MatchRole  
				,UserScope as MatchScope
				,ClassTypeIDDesc as MatchDesc 			 
 			from  [dbo].[SIC_sys_UserProfileMatch_ClassTypeDesc]
			where  ClassTypeIDDesc = @MatchDesc
	 
	end
else
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
