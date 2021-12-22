












-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_Apps_Read 'GetListAll' ,'mif','0','admin','SAP' ,'0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_Apps_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null, 
	@UserRole		varchar(20) = null


as 

set nocount on
declare @GoPage varchar(100), @Type varchar(10),  @ModelID varchar(50),@iTarget varchar(50),@SchoolYear varchar(8),@SchoolCode varchar(8)
select @ModelID ='Pages', @Type ='Apps',@SchoolYear ='', @SchoolCode=''
if @Operate ='GetList' 
 	begin		 
		select distinct
			 AppID  
 			,AppName
			,Owners
			,Developer		
			,StartDate 
			,case ActiveFlag when 'x' then 'true' else 'false' end  as ActiveFlag
			,AppUrl
			,Comments
			,dbo.[ActionTask.ASM]('TaskMenu',@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,AppID,AppName,'Internal')	as Actions
			,dbo.[ActionTask.ASM]('Edit'	,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,AppID,AppName,'Internal')	as EditAction
		 	,dbo.[ActionTask.ASM]('Delete'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,AppID,AppName,'Internal')	as DeleteAction
		 	,dbo.[ActionTask.ASM]('SubFun'  ,@Type,IDs,@SchoolYear,@SchoolCode,AppID,@ModelID,AppID,AppName,'Internal')	as SubActions
 			,ROW_NUMBER() OVER(ORDER BY AppID ) AS RowNo 
		from   [dbo].[SIC_sys_Apps]
 		order by RowNo
	end
 
else if @Operate ='GetbyID'  
	begin
		select  
			 IDs 
			,AppID  
 			,AppName
			,Owners
			,Developer		
			,StartDate 
			,EndDate 
			,case ActiveFlag when 'x' then 'true' else 'false' end  as ActiveFlag
			,AppUrl
			,AppUrlTest
			,AppUrlTrain
			,Comments
	 	from [dbo].[SIC_sys_Apps] 
		where  IDs =   @IDs
	end
 	 
