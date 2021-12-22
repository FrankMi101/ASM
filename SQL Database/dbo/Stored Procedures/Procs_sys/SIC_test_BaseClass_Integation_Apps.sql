





-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: Base Class Unit and Integration test
-- =====================================================================================

-- drop  proc dbo.SIC_asm_Apps_Edit 'DElete' ,'mif','304','20202021','0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_test_BaseClass_Integation_Apps]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null ,
	@AppID			varchar(20) = null,
	@AppName		varchar(300) = null,
	@Owners			varchar(250)= null,
	@Developer		varchar(150) = null,
	@ActiveFlag		varchar(1)	=null, 
	@StartDate		varchar(10) = null,
	@Comments		varchar(500) = null

as 

set nocount on
declare @SchoolYear varchar(8), @SchoolCode varchar(8)
select @SchoolYear ='20212022', @SchoolCode ='0000'
 if @Operate  = 'List'  
 			select distinct
			 AppID  
 			,AppName
			,Owners
			,Developer		
			,StartDate 
			,case ActiveFlag when 'x' then 'true' else 'false' end  as ActiveFlag
			,AppUrl
			,Comments
			,dbo.[ActionTask.ASM]('TaskMenu','Apps',IDs,@SchoolYear,@SchoolCode,AppID,'Pages',AppID,AppName,'Internal')	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,'Apps',IDs,@SchoolYear,@SchoolCode,AppID,'Pages',AppID,AppName,'Internal')	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'  ,'Apps',IDs,@SchoolYear,@SchoolCode,AppID,'Pages',AppID,AppName,'Internal')	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,'Apps',IDs,@SchoolYear,@SchoolCode,AppID,'Pages',AppID,AppName,'Internal')	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY AppID ) AS RowNo 

	 	from [dbo].[SIC_test_BaseClass_IntegrationTest] 
		order by RowNo
else if @Operate  = 'GetbyID'  
 
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
	 	from [dbo].[SIC_test_BaseClass_IntegrationTest] 
		where  IDs =   @IDs
 
else
	begin
		declare @newID varchar(10)  
		set @newID=''
		begin try
			  begin tran			   
				if @Operate ='Edit' 
					begin
						if exists (select 1 from dbo.[SIC_test_BaseClass_IntegrationTest]  where  IDs = @IDs)
							 Update  dbo.[SIC_test_BaseClass_IntegrationTest] 
							 set  AppID = @AppID,  AppName = @AppName ,Developer = @Developer, Owners = @Owners, ActiveFlag =@ActiveFlag,  StartDate = @StartDate,  Comments = @Comments
								 ,lu_date = getdate(),lu_user = @UserID, lu_function = app_name()
							 where IDs =@IDs 
						else
							select 'Model name ' + @AppID + ' does not exists in the system' as rValue
					 
					end
				else if @Operate ='Add'
					begin
						if exists (select * from dbo.[SIC_test_BaseClass_IntegrationTest] where IDs = @IDs )
							select 'Model name ' + @AppID + ' exists in the system already' as rValue
						else
							begin
								Insert into  dbo.[SIC_test_BaseClass_IntegrationTest]
									(  AppID,  AppName,Developer, Owners, StartDate,ActiveFlag,Comments,lu_Date, lu_User,lu_function)
								values( @AppID,@AppName,@Developer,@Owners, @StartDate,@ActiveFlag,  @Comments, getdate(),@UserID,app_name() )
								
								set @newID = cast(@@IDENTITY as varchar(10)) 		 						 
						end
 					end
 
 				else if @Operate ='Delete'
					begin
						if exists (select * from dbo.[SIC_test_BaseClass_IntegrationTest] where IDs =  @IDs ) -- ModelType = @ModelType  and AppID = @AppID and ModelID = @AppID )
	 
								delete dbo.[SIC_test_BaseClass_IntegrationTest] where IDs =  @IDs --  ModelType = @ModelType  and AppID = @AppID and ModelID = @AppID
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
