



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: June 17, 2021  
-- Description	: get school principals list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_ListofSchoolPrincipals '' ,'mif','admin','20202021','0544','Teacher' , 'SurName','','School'

CREATE     proc [dbo].[SIC_sys_ListofSchoolPrincipals]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(20) = null,  -- Teacher/admi /support/principal
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null, 
	@Scope			varchar(20) =  null 
--	@Program		varchar(30) = null 
as 

set nocount on

declare @RelationBy  varchar(20) ,    @RelationValue varchar(50)	, @positionDesc varchar(50)

set  @positionDesc ='%Principal%'

if  @UserRole is null set @UserRole ='Principal'

if  @Scope ='Board'  or @SchoolCode ='0000'
    set @SchoolCode = left(@schoolCode,1) + '%'
else
    set @SchoolCode = @schoolCode  + '%'

declare @ClassCode  varchar(10) 
 
declare @ListMatchbyUser  as table
		(School_year varchar(8),
		 school_code varchar(8),
		 CPNum   varchar(23) 
		)

if @Grade ='VP' 
set  @positionDesc ='%vice%'
if @Grade ='PreSY'
	begin
		if @SearchBy  = 'SurName'
			insert into @ListMatchbyUser
			select  distinct  @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where  PositionDesc like (@positionDesc) and  SchoolCode like ( @SchoolCode) and   LastName like @SearchValue 
			and userid in (select userID from dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where School_Year = dbo.[Current.SchoolYear]('LTO'))
		else if @SearchBy  = 'FistName'
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where  PositionDesc like (@positionDesc) and   SchoolCode like ( @SchoolCode) and   FirstName like @SearchValue
			and userid in (select userID from dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where School_Year = dbo.[Current.SchoolYear]('LTO'))
		else if @SearchBy ='SIN'
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where SchoolCode like ( @SchoolCode) and  [SIN] = @SearchValue
			and userid in (select userID from dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where School_Year = dbo.[Current.SchoolYear]('LTO'))	 
		else
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where SchoolCode like ( @SchoolCode) and  CPNum = @SearchValue
			and userid in (select userID from dbo.tcdsb_LTO_Principal_NewSchool_BeforeSept1 where School_Year = dbo.[Current.SchoolYear]('LTO'))
	end
else
	begin
		if @SearchBy  = 'SurName'
			insert into @ListMatchbyUser
			select  distinct  @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where  PositionDesc like (@positionDesc) and  SchoolCode like ( @SchoolCode) and   LastName like @SearchValue
		else if @SearchBy  = 'FistName'
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where  PositionDesc like (@positionDesc) and   SchoolCode like ( @SchoolCode) and   FirstName like @SearchValue
		else if @SearchBy ='SIN'
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where SchoolCode like ( @SchoolCode) and  [SIN] = @SearchValue
 		else
			insert into @ListMatchbyUser
			select distinct @SchoolYear, schoolCode,CPNum
			from  dbo.SIC_sys_Employee
			where SchoolCode like ( @SchoolCode) and  CPNum = @SearchValue
	 end

 
  	select E.CPNum as EmployeeID  
        ,isnull(E.CPNum,'') as CPNum
		,[SIN]
        ,isnull(OCTNum,'') as OCTNum  
        ,UserID 
        ,FirstName + ' '  + LastName as StaffName 
        ,FirstName 
        ,LastName 
        ,PositionDesc as Position 
        ,'' as Gender 
        , '' as Status 
        , BoardSeniorityDate as HireDate  
        ,SchoolCode
		,dbo.[School.Name](schoolCode) as SchoolName
        , [dbo].[Staff.eMailAddress](UserID)   as Email 
        ,[dbo].[Staff.Area](UserID)  as Area 
        , 'some comeents' Comments , 
		[dbo].[Staff.Role](UserID,'SIC') as StaffType,
		[dbo].[Staff.Role.SAP](UserID) as EmployeeRole,
		ClassTypeIDDesc  as JobDesc,
		[dbo].[Staff.ActionTask]('TaskMenu',E.UserID, @UserRole,@SchoolYear,@SchoolCode, @Scope, E.CPNum,E.FirstName + ' ' + E.LastName ) as Actions,
 
		 	 ROW_NUMBER() OVER(ORDER BY E.FirstName, E.LastName  ) AS RowNo 

         from  dbo.SIC_sys_Employee		as E
			inner join @ListMatchbyUser		as S  on E.SchoolCode =S.school_code and E.CPNum =S.CPNum 
 -- 			where E.SchoolCode like ( @SchoolCode)  
			order by RowNo 

			 
