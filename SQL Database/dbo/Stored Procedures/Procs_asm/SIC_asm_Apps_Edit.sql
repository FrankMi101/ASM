




-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Model list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_Apps_Edit 'DElete' ,'mif','304','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_Apps_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null ,
	@AppID			varchar(20) = null,
	@AppName		varchar(300) = null,
	@Owners			varchar(250)= null,
	@Developer		varchar(150) = null,
	@ActiveFlag		varchar(1) =null, 
 	@AppUrl			varchar(200) = null,
	@AppUrlTest		varchar(200) = null,
	@AppUrlTrain	varchar(200) = null,
	@StartDate		varchar(10) = null,
	@Comments		varchar(500) = null

as 

set nocount on
 
if @Operate in ('Get','GetbyID')  
	begin
		select  
			 IDs 
			,AppID  
 			,AppName
			,Owners
			,Developer		
			,dbo.[Date.ToString](StartDate,'') as  StartDate
			,EndDate 
			,case ActiveFlag when 'x' then 'true' else 'false' end  as ActiveFlag
			,AppUrl
			,AppUrlTest
			,AppUrlTrain
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
						if exists (select 1 from dbo.[SIC_sys_Apps]  where  IDs = @IDs)
							 Update  dbo.[SIC_sys_Apps] 
							 set  AppID = @AppID,  AppName = @AppName ,Developer = @Developer, Owners = @Owners, ActiveFlag =@ActiveFlag, Appurl = @AppUrl, AppUrlTest =@AppUrlTest,  AppUrlTrain = @AppUrlTrain,  StartDate = @StartDate,  Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where IDs =@IDs 
						else
							select 'Model name ' + @AppID + ' does not exists in the system' as rValue
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from dbo.[SIC_sys_Apps] where IDs = @IDs )
							select 'Model name ' + @AppID + ' exists in the system already' as rValue
						else
							begin
								Insert into  dbo.[SIC_sys_Apps]
									(  AppID,  AppName,Developer, Owners, StartDate,ActiveFlag, AppUrl, AppUrlTest, AppUrlTrain, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@AppName,@Developer,@Owners, @StartDate,@ActiveFlag, @AppUrl, @AppUrlTest, @AppUrlTrain, @Comments, getdate(),@UserID,app_name() )
								
								set @newID = cast(@@IDENTITY as varchar(10)) 
								
								EXEC dbo.SIC_asm_AppsModel_Edit 'Add',@UserID,'0',@AppID,'Pages','All Application Pages',@Developer,@Owners,@StartDate,null,'General Model adding by Adding new Apps action.'
						end
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from dbo.[SIC_sys_Apps] where   AppID = @AppID  )
							begin
								delete [dbo].[SIC_sys_Apps] where    AppID = @AppID 
 							end
						else
						     select 'Model name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
 				if @Operate ='Delete'
					begin
						if exists (select 1 from dbo.[SIC_sys_Apps] where IDs =  @IDs ) -- ModelType = @ModelType  and AppID = @AppID and ModelID = @AppID )
	 
								delete dbo.[SIC_sys_Apps] where IDs =  @IDs --  ModelType = @ModelType  and AppID = @AppID and ModelID = @AppID
 						else
						     select 'Model name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
		  Commit tran			 
 				Select 'Successfully' + @newID as rValue
			 --	 select dbo.tcdsb_LTO_choiseInterviewCandidate(@SchoolYear,@PositionID) as rValue
	   end try
       
	   begin catch
			   Rollback tran
			   Select   'Failed' as rValue -- ERROR_MESSAGE() as rValue --
		end catch		
	end
