



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: March 28, 2021  
-- Description	: get staff list by search value
-- =====================================================================================


-- drop  proc dbo.SIC_sys_ListofStaffsSecurity '' ,'mif','admin','','','Teacher' , 'SurName','','Board'

CREATE proc [dbo].[SIC_sys_ListofStaffsSecurity]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
--	@Grade			varchar(20) = null,  -- Teacher/admi /support/principal
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null, 
	@Scope			varchar(20) =  null 
--	@Program		varchar(30) = null 
as 

set nocount on

declare @RelationBy  varchar(20) ,    @RelationValue varchar(50)	
 

if  @UserRole is null set @UserRole ='Principal'


if  @SchoolCode ='0000' 
    set @SchoolCode = left(@schoolCode,1) + '%'
else
    set @SchoolCode = @schoolCode  + '%'

declare @ClassCode  varchar(10) 
 
declare @ListMatchbyUser  as table
		(School_year varchar(8),
		 school_code varchar(8),
		 CPNum   varchar(23) 
		)


if @Scope ='Board' 
	set @SearchValue = isnull(@SearchValue,'a' ) + '%'
else
	set @SearchValue = isnull(@SearchValue,'' ) + '%'

if @SearchBy  = 'UserID'
	insert into @ListMatchbyUser
	select distinct  @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   UserID like @SearchValue

else if @SearchBy  = 'SurName'
	insert into @ListMatchbyUser
	select distinct  @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   LastName like @SearchValue

else if @SearchBy  = 'LastName'
	insert into @ListMatchbyUser
	select distinct  @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   LastName like @SearchValue

else if @SearchBy  = 'FirstName'
	insert into @ListMatchbyUser
	select distinct @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   FirstName like @SearchValue

else
	insert into @ListMatchbyUser
	select distinct @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and  CPNum = @SearchValue
	 
declare @hSta varchar(200) , @hEnd varchar(200)
set @hSta='<a  target ="IframeFunction" href="Loading.aspx?pID=SecurityManageGroupSub.aspx&appID=&gID=&gType=' 
set @hEnd= '"><img src="../images/submenu.png" border="0" width="18" height="18"/>' + '</a>'  
 
select Top 200 E.CPNum as EmployeeID  
        ,isnull(E.CPNum,'') as CPNum
        ,UserID
		-- @hSTR + '&nwuID=' +  E.UserID + '&CPNum=' +  E.CPNum  +  '&sName='+ [dbo].[Staff.Name](E.CPNum,'NameOK')  + '&sCode='  + SchoolCode + '&uRole=' + [dbo].[Staff.Role.SAP](UserID) + '" target ="IframeFunction">' +  [dbo].[Staff.Name](E.CPNum,'NameOK') + '</a>' as StaffName  
        , FirstName + ' '  + LastName as StaffName 
        ,FirstName 
        ,LastName 
        ,PositionDesc as Position
        ,SchoolCode   
		,E.OrgUnit_desc  as SchoolName 
		,[dbo].[Staff.Role.SAP](UserID) as EmployeeRole 
		,ClassTypeIDDesc  as JobDesc
		,case PickedForGAL when 'x' then 'true' else 'false' end as PickedForGAL
	--	[dbo].[Staff.ActionTask]('SMDetail',E.UserID, @UserRole,@SchoolYear,S.school_code, '', E.CPNum, [dbo].[Staff.Name](E.CPNum,'NameOK') ) as Actions,
	    , @hSta  + '&sYear='  + @SchoolYear  + '&sCode='  + SchoolCode + '&nwuID=' +  E.UserID + '&CPNum=' +  E.CPNum  +  '&sName='+ [dbo].[Staff.Name](E.CPNum,'NameOK') + '&uRole=' + [dbo].[Staff.Role.SAP](UserID)
		+ @hEnd as Actions,  
 
		 	 ROW_NUMBER() OVER(ORDER BY E.FirstName, E.LastName  ) AS RowNo 

         from  dbo.SIC_sys_Employee		as E
		 inner join @ListMatchbyUser		as S  on E.SchoolCode =S.school_code and E.CPNum =S.CPNum 
 		 order by RowNo 

			 
