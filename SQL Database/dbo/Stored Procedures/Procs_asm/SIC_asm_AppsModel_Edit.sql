




-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Model list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppsModel_Edit 'DElete' ,'mif','304','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppsModel_Edit]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null ,
	@AppID			varchar(20) = null,
	@ModelID		varchar(20) =null, 
	@ModelName		varchar(300) = null,
	@Developer		varchar(150) = null,
	@Owners			varchar(250)= null,
	@StartDate		varchar(10) = null,
	@EndDate		varchar(10) = null,
	@Comments		varchar(500) = null

as 

set nocount on
 
if @Operate in ('Get','GetbyID')  
	begin
		select  
			 IDs 
			,AppID  
 			,ModelID
			,ModelName
			,Owners
			,Developer		
			,dbo.[Date.ToString](StartDate,'') as  StartDate 
			,dbo.[Date.ToString](EndDate,'') as  EndDate 
			,Comments
	 	from [dbo].[SIC_sys_AppsModels] 
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
						if exists (select 1 from dbo.[SIC_sys_AppsModels]  where  IDs = @IDs)
							 Update  dbo.[SIC_sys_AppsModels] 
							 set  AppID = @AppID, ModelID = @ModelID, ModelName = @ModelName ,Developer = @Developer, Owners = @Owners, StartDate = @StartDate, EndDate = @EndDate, Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where IDs =@IDs 
						else
							select 'Model name ' + @ModelID + ' does not exists in the system' as rValue
					 
					end
				if @Operate ='Add'
					begin
						if exists (select 1 from dbo.[SIC_sys_AppsModels] where IDs = @IDs )
							select 'Model name ' + @ModelID + ' exists in the system already' as rValue
						else
							begin
								Insert into  dbo.[SIC_sys_AppsModels]
									(  AppID, ModelID,ModelName, ModelAccess, Developer, Owners, StartDate, EndDate, Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@ModelID,@ModelName,'Implicit', @Developer,@Owners, @StartDate,@EndDate,@Comments, getdate(),@UserID,app_name() )
								
								set @newID = cast(@@IDENTITY as varchar(10)) 		 						 
						end
 					end
				if @Operate ='Remove'
					begin
						if exists (select 1 from dbo.[SIC_sys_AppsModels] where   ModelID = @ModelID and AppID = @AppID )
							begin
								delete [dbo].[SIC_sys_AppsModels] where  ModelID = @ModelID and AppID = @AppID 
 							end
						else
						     select 'Model name ' + cast(@IDs as varchar(10))  + ' does not exists in the system' as rValue
				 
 					end
 				if @Operate ='Delete'
					begin
						if exists (select 1 from dbo.[SIC_sys_AppsModels] where IDs =  @IDs ) -- ModelType = @ModelType  and AppID = @AppID and ModelID = @ModelID )
	 
								delete dbo.[SIC_sys_AppsModels] where IDs =  @IDs --  ModelType = @ModelType  and AppID = @AppID and ModelID = @ModelID
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
