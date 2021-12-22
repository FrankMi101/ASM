

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_Apps_Read 'GetListAll' ,'mif','0','admin','SAP' ,'0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppsModel_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null, 
	@UserRole		varchar(20) = null,
	@AppID			varchar(20) = null


as 

set nocount on
declare @GoPage varchar(100), @Type varchar(10),  @ModelID varchar(50),@iTarget varchar(50),@SchoolYear varchar(8),@SchoolCode varchar(8)
select @ModelID ='Pages', @Type ='Apps',@SchoolYear ='', @SchoolCode=''
if @Operate ='GetList' 
 	begin		 
		select distinct
			 AppID  
 			,ModelID
			,ModelName
			,Developer		
			,Owners		
			,dbo.[Date.ToString](StartDate,'') as  StartDate 
			,dbo.[Date.ToString](EndDate,'') as  EndDate 
			,Comments
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,ModelID,ModelID,ModelName,'Internal')	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,ModelID,ModelID,ModelName,'Internal')	as EditAction
		 	,case ModelID when 'Pages' then '' 
						  else dbo.[ActionTask.ASM]('Delete'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,ModelID,ModelID,ModelName,'Internal') end	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,ModelID,ModelID,ModelName,'Internal')	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY AppID ) AS RowNo 
		from   [dbo].[SIC_sys_AppsModels]
		where AppID = @AppID
 		order by RowNo
	end
 
else if @Operate ='GetbyID'  
	begin
		select  
			 IDs 
			,AppID  
 			,ModelID
			,ModelName
			,Owners
			,Developer		
			,dbo.[Date.ToString](StartDate,'') as  StartDate 
			,dbo.[Date.ToString](EndDate,'') as   EndDate  
			,Comments
	 	from [dbo].[SIC_sys_AppsModels] 
		where  IDs =   @IDs
	end
 	 
