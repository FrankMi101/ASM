














-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_ListofSchoolStaffs '' ,'mif','admin','20202021','0544','Teacher' , 'SurName','','School'

CREATE     proc [dbo].[SIC_sys_ListofSchoolStaffs]  
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

declare @RelationBy  varchar(20) ,    @RelationValue varchar(50)	
 

if  @UserRole is null set @UserRole ='Principal'

if  @Scope ='Board' 
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

if @SearchBy  = 'SurName'
	insert into @ListMatchbyUser
	select distinct  @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   LastName like @SearchValue
else if @SearchBy  = 'FistName'
	insert into @ListMatchbyUser
	select distinct @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and   FirstName like @SearchValue
else
	insert into @ListMatchbyUser
	select distinct @SchoolYear, schoolCode,CPNum
	from  dbo.SIC_sys_Employee
	where SchoolCode like ( @SchoolCode) and  CPNum = @SearchValue
	 
 
  	select E.CPNum as EmployeeID  
        ,isnull(E.CPNum,'') as CPNum
		,[SIN]
		,FTE
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
        , UserID + '@tcdsb.org'  as Email 
        , 'School area'  as Area 
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

			 
