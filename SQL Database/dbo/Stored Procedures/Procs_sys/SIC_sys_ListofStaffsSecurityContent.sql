




 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc dbo.SIC_sys_ListofStaffsSecurityContent 'SecurityContentAPP' ,'mif','Support','20202021','0361' ,'00016478'

CREATE proc [dbo].[SIC_sys_ListofStaffsSecurityContent]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@CPNum			varchar(10) = null
as 

set nocount on
 
  
declare @StaffUserID varchar(30), @StaffPersonID varchar(20) , @P varchar(7)
set @StaffUserID = dbo.[Staff.ID](@CPNum,'NetWorkUserID')
set @StaffPersonID =  dbo.[Staff.ID](@StaffUserID,'PersonID')
set @P = ''','''
declare @hSta varchar(200) , @hEnd varchar(200), @delAction  varchar(200)
set @hSta='<a  target ="IframeFunction" href="Loading.aspx?pID=SecurityManageGroupSub.aspx' 
set @hEnd= '"><img src="../images/submenu.png" border="0" width="16" height="16"/>' + '</a>' 
set @delAction = '<a href="javascript:RemoveUserFromGroup(''IDsIDs'')"> <img src="../images/delete.png" border="0" width="14" height="14"/> </a>'
if @Operate ='SecurityContentSAP' 
	begin
		select Top 20 E.CPNum as EmployeeID  
			,isnull(E.CPNum,'') as CPNum
			,UserID
			 , FirstName + ' '  + LastName as StaffName 
			 ,PositionDesc as Position
			,SchoolCode  
			, OrgUnit_desc  as SchoolName 
			,[dbo].[Staff.Role.SAP](UserID) as EmployeeRole 
			,ClassTypeIDDesc  as JobDesc
			,case PickedForGAL when 'x' then 'true' else 'false' end as PickedForGAL
 			, @hSta  + '&sYear='  + @SchoolYear  + '&sCode='  + SchoolCode + '&nwuID=' +  E.UserID + '&CPNum=' +  E.CPNum  +  '&sName='+ [dbo].[Staff.Name](E.CPNum,'NameOK') + '&uRole=' + [dbo].[Staff.Role.SAP](UserID)
			+ @hEnd as Actions  
 	 		, ROW_NUMBER() OVER(ORDER BY E.FirstName, E.LastName  ) AS RowNo 

		from  dbo.SIC_sys_Employee		as E
		where CPNum = @CPNum
		order by RowNo 
	end
else if @Operate ='SecurityContentSIS' 
 	begin
		declare @classess as table
		(ClassCode varchar(20),
		ClassName varchar(200),
		ClassType varchar(20),
		Semester	varchar(1),
		Term		varchar(10),
		StartDate   varchar(10),
		EndDate		varchar(10),
		Actions		varchar(350))
		insert into @classess
		select distinct 
		 class_code			as ClassCode
		 ,full_name			as ClassName
		,class_homeroom_flag as ClassType
		,Semester as Semester
		,[dbo].[Student.Class.Info](school_year,school_code,'',class_code, Semester,  'Terms')  as Term
		,dbo.DateF(term_start,'YYYYMMDD')			as StartDate
		,dbo.DateF(term_end,'YYYYMMDD')			as EndDate 
		,[dbo].[ActionTask.Class]('TaskMenu',@UserID,@UserRole, school_year,school_code, class_code,semester,term,full_name ) as Actions 
		--, ROW_NUMBER() OVER(ORDER BY class_code  ) AS RowNo 
		from [dbo].[SIC_sys_SchoolClasses] 
		where school_year = @SchoolYear and school_code =  @SchoolCode and Teacher_ID =   @StaffPersonID
		-- order by RowNo
		select *,
			ROW_NUMBER() OVER(ORDER BY ClassCode  ) AS RowNo 
		from @classess
		order by RowNo

	end
else if @Operate ='SecurityContentAPP' 
	begin
	    set @hSta='<a href="javascript:RemoveUserFromGroup(''' 
		set @hEnd= ''')"> <img src="../images/delete.png" border="0" width="14" height="14"/> </a>'
 
		declare @Apps as table
			(AppID varchar(20),
			GroupID varchar(200),
			GroupName varchar(300),
			GroupType	varchar(30),
			Permission	varchar(20),
			MemberID	varchar(20),
			IsActive	varchar(10),
			StartDate   varchar(10),
			EndDate		varchar(10),
			Actions		varchar(500),
			DeleteAction	varchar(200))
		Insert into @Apps
		select distinct M.AppID  
			,M.GroupID
			,M.GroupName
			,M.GroupType
			,M.Permission
			,S.MemberID
			,case isnull(M.Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,dbo.DateF(T.StartDate,'YYYYMMDD')			as StartDate
			,dbo.DateF(T.EndDate,'YYYYMMDD')			as EndDate 
			--,dbo.[ActionTask.Group]('TaskMenu',T.MemberID, @UserRole, @SchoolYear, T.SchoolCode,T.AppID, T.GroupID)  as Actions
			,dbo.[ActionTask.Group.Member] ('TaskMenu',@UserID, @UserRole, @SchoolYear, S.SchoolCode,S.AppID, S.GroupID,S.MemberID, S.GroupType  )  as Actions
			--,replace(@delAction,'IDsIDs',cast(T.IDs as varchar(10))) as DeleteAction
			,@hSta + @UserID + @P + @UserRole + @P + @SchoolYear + @P + T.SchoolCode + @P + T.AppID +@P + T.GroupID + @P + T.MemberID +  @hEnd as DeleteAction
 		from [dbo].[SIC_sys_UserGroup_MemberTeachers]		as T
		inner join [dbo].[SIC_sys_UserGroup_Members]		as M on  T.SchoolCode = M.SchoolCode and T.AppID = M.AppID and T.GroupID = M.GroupID 
		left join [dbo].[SIC_sys_UserGroup_MemberStudents]	as S on  M.SchoolCode = S.SchoolCode and M.AppID = S.AppID and M.GroupID = S.GroupID and M.GroupType = S.GroupType
		where T.MemberID = @StaffUserID
 
 		select *,		
			ROW_NUMBER() OVER(ORDER BY AppID, GroupID ) AS RowNo 
		from @Apps
		order by RowNo
	end
else if @Operate ='SchoolYearDate'
	begin
		if exists (select 1 from dbo.SIC_sys_SchoolYear	where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode)
		   select top 1 dbo.DateF(StartDate,'YYYYMMDD')			as StartDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as EndDate 
				,dbo.DateF(getdate(),'YYYYMMDD')			as TodayDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode
		else
		   select top 1 dbo.DateF(StartDate,'YYYYMMDD')			as StartDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as EndDate 
				,dbo.DateF(getdate(),'YYYYMMDD')			as TodayDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode in ('0204','0501') 
	end
