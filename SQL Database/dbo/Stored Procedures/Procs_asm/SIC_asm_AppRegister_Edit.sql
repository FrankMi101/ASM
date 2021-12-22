














-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get App list
-- =====================================================================================

-- drop  proc dbo.SIC_sys_AppApp 'GetList' ,'mif','admin','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppRegister_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null ,
	@AppID			varchar(20) = null,
	@AppName		varchar(200) = null,
	@Owner			varchar(100) = null,
	@Developer		varchar(100) = null,
	@StartDate		varchar(10) = null,
	@EndDate		varchar(10) = null,
	@IsActive		varchar(1) = null,
	@Comments		varchar(250) = null

as 

set nocount on
 
if @Operate in ('Get','GetbyID')  
	begin
		select distinct
			 IDs
			,AppID  
			,AppName
			,Owners
			,Developer
			,StartDate		
			,EndDate
			,ActiveFlag as IsAvtive
			,Comments
			from [dbo].[SIC_sys_Apps] 
		where  IDs =   @IDs
	end
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from [dbo].[SIC_sys_Apps]  where    AppID = @AppID )
							 Update  [dbo].[SIC_sys_Apps] 
							 set AppName = @AppName ,Owners = @Owner, Developer = @Developer, StartDate = @StartDate, EndDate =@EndDate, ActiveFlag =@IsActive, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where AppID = @AppID  
						else
							select 'App name ' + @AppID + ' does not exists in the system' as rValue
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from [dbo].[SIC_sys_Apps] where  AppID = @AppID )
							select 'App name ' + @AppID + ' exists in the system already' as rValue
						else
							begin
								Insert into  [dbo].[SIC_sys_Apps]
									(  AppID,AppName, Owners,Developer,StartDate,EndDate,ActiveFlag, Comments,lu_Date, lu_User,lu_function)
								values(@AppID,@AppName,@Owner,@Developer, @StartDate,@EndDate,@IsActive, @Comments, getdate(),@UserID,app_name() )
								
								-- insert a default AppApp permission record from UserRole  
								insert into [dbo].[SIC_sys_UserRole_AppsPermission]
								(RoleType, RoleID, AppID,ModelID,Permission,AccessScope,Comments,lu_date,lu_user,lu_function)
								select  RoleType, RoleID,@AppID, 'Pages',Permission,AccessScope,@Comments,getdate(),@UserID,App_name() 
								from dbo.SIC_sys_UserRole
								 
							end
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from [dbo].[SIC_sys_Apps] where  AppID = @AppID )
							begin
								delete [dbo].[SIC_sys_UserRole_AppsPermission] where AppID = @AppID
								delete [dbo].[SIC_sys_Apps] where   AppID = @AppID
							end
						else
						     select 'App name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
 				if @Operate ='Delete'
					begin
						if exists (select 1 from [dbo].[SIC_sys_Apps] where IDs =  @IDs ) -- AppType = @AppType  and AppID = @AppID and AppID = @AppID )
							delete [dbo].[SIC_sys_Apps] where IDs =  @IDs --  AppType = @AppType  and AppID = @AppID and AppID = @AppID
						else
						     select 'App name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
		  Commit tran
				if @Operate ='Add'  set @newID = cast(@@IDENTITY as varchar(10))  
			 
 				Select 'Successfully' + @newID as rValue
			 --	 select dbo.tcdsb_LTO_choiseInterviewCandidate(@SchoolYear,@PositionID) as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select 'Failed' as rValue
		end catch		
	end
