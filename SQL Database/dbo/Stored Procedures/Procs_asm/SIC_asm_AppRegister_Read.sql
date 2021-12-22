








-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 06, 2021  
-- Description	: get Role list
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppRole_Read 'GetListAll' ,'mif','0','admin','SAP' ,'0354' , 'SIC','','SAP' 
CREATE  proc [dbo].[SIC_asm_AppRegister_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30) = null,
	@IDs			varchar(10) = null, 
	@UserRole		varchar(20) = null


as 

set nocount on
declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4), @iPage varchar(100),@iTarget varchar(50)
select @GoPage ='../PagesForms/ApplicationManage.aspx'  , @Target ='EditDIV',@Height='400',@Width ='600' -- , @GoPage ='../SICCommon/Security_Role.aspx' 
select @iPage ='ApplicationManage.aspx', @iTarget='IframeSubArea'

if @Operate ='GetList' 
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
			,dbo.[ActionTask.Role]('TaskMenu',@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',AppID,AppName,Owners)	as Actions
			,dbo.[ActionTask.Role]('Edit'	 ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',AppID,AppName,Owners)	as EditAction
		 	,dbo.[ActionTask.Role]('Delete'  ,@GoPage,@Target,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',AppID,AppName,Owners)	as DeleteAction
		 	,dbo.[ActionTask.Role]('SubFun'  ,@iPage,@iTarget,@Height,@Width,@UserID, @UserRole, AppID, 'Pages',AppID,AppName,Owners)	as SubActions

 			,ROW_NUMBER() OVER(ORDER BY AppName ) AS RowNo 
 		from  [dbo].[SIC_sys_Apps] 
 		order by RowNo
	end
 
else if @Operate ='GetbyID'  
	begin
		select distinct
			IDs
			,AppID  
			,RoleID
			,RoleName
			,RolePriority
			,Permission		
			,AccessScope 
			,Comments
	 	from [dbo].[SIC_sys_UserRole] 
		where  IDs =   @IDs
	end
 	 
