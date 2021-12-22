





 
-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_asm_AppSchoolStaffs_Read '' ,'mif','admin','0354','SurName','b','School'

CREATE  proc [dbo].[SIC_asm_AppSchoolStaffs_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolCode		varchar(8) = null,
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null, 
	@Scope			varchar(20) =  null 
as 

set nocount on
  	
declare @GoPage varchar(100), @Target varchar(50),@Type varchar(10),@SchoolYear varchar(8),@ModelID varchar(50),@AppID varchar(10)
select  @SchoolYear ='20202021', @Type ='SchoolStaff', @ModelID ='Pages' , @AppID ='SIC'-- @iPage ='GroupManageSub.aspx', @iTarget='IframeSubArea' ,
	 
--declare @hSta varchar(200) , @hEnd varchar(200)
--set @hSta='<a  target ="IframeSubArea" href="Loading.aspx?pID=StaffManageSub.aspx&appID=&gID=&gType=' 
--set @hEnd= '"><img src="../images/submenu.png" border="0" width="18" height="18"/>' + '</a>'  
-- select @GoPage ='Security_Group.aspx' -- , @Target ='EditDIV',@Height='400',@Width ='600' -- , @GoPage ='../SICCommon/Security_Group.aspx' 
 
 -- select @iPage ='StaffManageSub.aspx', @iTarget='IframeSubArea' , @SchoolYear ='20202021'


if  @UserRole is null set @UserRole ='Principal'
if @SchoolCode ='0000'   set @Scope = 'Board' 

if  @Scope ='Board' 
    set @SchoolCode = left(@schoolCode,1) + '%'
else
    set @SchoolCode = @schoolCode  + '%'


declare @ClassCode  varchar(10) 
 
declare @ListMatchbyUser  as table
		(IDs		int,
		 SchoolYear varchar(8),
		 SchoolCode varchar(8),
		 CPNum   varchar(23) 
		)


if @Scope ='Board' 
	set @SearchValue = isnull(@SearchValue,'a' ) + '%'
else
	set @SearchValue = isnull(@SearchValue,'' ) + '%'


if @SearchBy in ( 'SurName','LastName')
	insert into @ListMatchbyUser
	select distinct ROW_NUMBER()  OVER(ORDER BY CPNum) AS RowNo , @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   LastName like @SearchValue
 
else if @SearchBy  = 'FirstName'
	insert into @ListMatchbyUser
	select distinct ROW_NUMBER()  OVER(ORDER BY CPNum) AS RowNo  , @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   FirstName like @SearchValue
else
	insert into @ListMatchbyUser
	select distinct ROW_NUMBER()  OVER(ORDER BY CPNum) AS RowNo , @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and  CPNum = @SearchValue
	 

select Top 200 E.CPNum as EmployeeID  
        ,isnull(E.CPNum,'') as CPNum
        ,UserID
		-- @hSTR + '&nwuID=' +  E.UserID + '&CPNum=' +  E.CPNum  +  '&sName='+ [dbo].[Staff.Name](E.CPNum,'NameOK')  + '&sCode='  + SchoolCode + '&uRole=' + [dbo].[Staff.Role.SAP](UserID) + '" target ="IframeFunction">' +  [dbo].[Staff.Name](E.CPNum,'NameOK') + '</a>' as StaffName  
        , FirstName + ' '  + LastName as StaffName 
        ,FirstName 
        ,LastName 
        ,PositionDesc as Position
        ,E.SchoolCode   
		,E.OrgUnit_desc  as SchoolName 
		,[dbo].[Staff.Role.SAP](UserID) as EmployeeRole 
		,ClassTypeIDDesc  as JobDesc
		,case PickedForGAL when 'x' then 'true' else 'false' end as PickedForGAL
 
 		--,dbo.[ActionTask.Staff]('SubFun',@UserID, @UserRole, @SchoolYear, SchoolCode,E.CPNum, UserID,  [dbo].[Staff.Name](E.CPNum,'NameOK'),[dbo].[Staff.Role.SAP](UserID))	 as SubAction
 		--,dbo.[ActionTask.Staff]('View'  ,@UserID, @UserRole, @SchoolYear, SchoolCode,E.CPNum, UserID,  [dbo].[Staff.Name](E.CPNum,'NameOK'),[dbo].[Staff.Role.SAP](UserID))	 as ViewAction
		,dbo.[ActionTask.ASM]('SubFun', 'SAP'    ,IDs,@SchoolYear,E.SchoolCode,@AppID,E.CPNum, E.UserID,[dbo].[Staff.Name](E.CPNum,'NameOK'),[dbo].[Staff.Role.SAP](UserID)) as SubAction
		,dbo.[ActionTask.ASM]('SubFunM','Schools',IDs,@SchoolYear,E.SchoolCode,@AppID,E.CPNum, E.UserID,[dbo].[Staff.Name](E.CPNum,'NameOK'),[dbo].[Staff.Role.SAP](UserID)) as ViewAction

		, ROW_NUMBER() OVER(ORDER BY E.FirstName, E.LastName  ) AS RowNo 
         from  dbo.SIC_sys_Employee		as E
		 inner join @ListMatchbyUser	as S  on E.SchoolCode =S.SchoolCode and E.CPNum =S.CPNum 
 		 order by RowNo 
 
