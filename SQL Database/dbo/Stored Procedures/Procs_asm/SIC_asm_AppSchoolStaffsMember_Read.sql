

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc dbo.SIC_asm_AppSchoolStaffsMember_Read 'SAP' ,'mif','admin','20202021','0354' ,'00050347'
 
CREATE  proc [dbo].[SIC_asm_AppSchoolStaffsMember_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolCode		varchar(8) = null,
	@SchoolYear		varchar(8) = null,
	@CPNum			varchar(10) = null
as 

set nocount on
 
  
declare @StaffUserID varchar(30), @StaffPersonID varchar(20) , @P varchar(7) ,@jS varchar(10),@AppID varchar(20), @ModelID varchar(50) 
set @StaffUserID = dbo.[Staff.ID](@CPNum,'NetWorkUserID')
set @StaffPersonID =  dbo.[Staff.ID](@StaffUserID,'PersonID')
select @AppID ='SIC', @ModelID ='Pages'
if @Operate ='SAP' 
	begin
		declare @Saps as table
			(EmployeeID		varchar(20),
 			SchoolCode		varchar(8),
			SchoolName		varchar(250),
			EmployeeRole	varchar(20),
			JobDesc			varchar(200),
			PickedForGAL	varchar(10),
			Actions			varchar(500),
			EditAction		varchar(500),
			DeleteAction	varchar(500),
			RoleType		varchar(10),
			UserID			varchar(30),
			Comments			varchar(250)
			)
		insert into @Saps
 		select CPNum as EmployeeID  
			,SchoolCode  
			, OrgUnit_desc  as SchoolName 
			,[dbo].[Staff.Role.SAP](UserID) as EmployeeRole 
			,PositionDesc   as JobDesc
			,case PickedForGAL when 'x' then 'true' else 'false' end as PickedForGAL
 			,dbo.[ActionTask.ASM] ('TaskMenu','SAP','0',@SchoolYear,@SchoolCode, @AppID,  CPNum, UserID, FirstName + ' ' + LastName, [dbo].[Staff.Role.SAP](UserID))  as Actions
			,'' as EditAction
			,'' as DeleteAction
			,'SAP'
			,UserID
		    ,isnull(ClassTypeIDDesc,'')
	 	from  dbo.SIC_sys_Employee where   CPNum = @CPNum

		insert into @Saps
		select   E.CPNum as EmployeeID  
			,SchoolCode  
			,OrgUnit_desc  as SchoolName 
			,W.AppRole     as EmployeeRole 
			,W.Comments    as JobDesc
			,'false' as PickedForGAL
  			,dbo.[ActionTask.ASM]('TaskMenu','SAP',IDs, @SchoolYear,@SchoolCode,@AppID,E.CPNum,W.UserID,W.UserName,AppRole)  as Actions
			,dbo.[ActionTask.ASM]('Edit',    'SAP',IDs, @SchoolYear,@SchoolCode,@AppID,E.CPNum,W.UserID,W.UserName,AppRole ) as EditAction
			,dbo.[ActionTask.ASM]('Delete',  'SAP',IDs, @SchoolYear,@SchoolCode,@AppID,E.CPNum,W.UserID,W.UserName,AppRole ) as DeleteAction
			,'OverWrite'
			,W.UserID
			,[dbo].[DateF](StartDate,'YYYYMMDD') + ' - ' +  [dbo].[DateF](EndDate,'YYYYMMDD') + ' as ' + W.Comments
			from  dbo.SIC_sys_Employee		as E
		    inner join   dbo.SIC_sys_UserWorkingRoles as W on E.UserID = W.UserID
			where CPNum = @CPNum

		insert into @Saps
		select   E.CPNum as EmployeeID  
			,GroupID	 as SchoolCode  
			,[dbo].[School.Name](W.GroupID) + ' (' + W.GroupID + ')'   as SchoolName 
			,W.AppRole     as EmployeeRole 
			,isnull(W.Comments,'') + 'Working Role:' + W.AppRole    as JobDesc
			,'false'		as PickedForGAL
  			,dbo.[ActionTask.ASM]('TaskMenu','SAP',IDs, SchoolYear,GroupID,AppID,E.CPNum,W.UserID,W.UserName,W.AppRole)  as Actions
			,dbo.[ActionTask.ASM]('Edit',    'SAP',IDs, SchoolYear,GroupID,AppID,E.CPNum,W.UserID,W.UserName,W.AppRole ) as EditAction
			,dbo.[ActionTask.ASM]('Delete',  'SAP',IDs, SchoolYear,GroupID,AppID,E.CPNum,W.UserID,W.UserName,W.AppRole ) as DeleteAction
			,'OverWrite'
			,W.UserID
			,[dbo].[DateF](StartDate,'YYYYMMDD') + ' - ' +  [dbo].[DateF](EndDate,'YYYYMMDD') + ' as ' + isnull(W.Comments,'')
			from		 dbo.SIC_sys_Employee			 as E
		    inner join   dbo.[SIC_sys_UserWorkingSchools] as W on E.UserID = W.UserID
			where CPNum = @CPNum
 

		select *, ROW_NUMBER() OVER(ORDER BY RoleType Desc  ) AS RowNo 
		from  @Saps
		order by RowNo 
	end
else if @Operate ='SIS' 
 	begin
		declare @classess as table
		(ClassCode varchar(20),
		ClassName varchar(200),
		ClassType varchar(20),
		Semester	varchar(1),
		Term		varchar(10),
		StartDate   varchar(10),
		EndDate		varchar(10),
		Actions		varchar(350),
		EditAction	varchar(200),
		DeleteAction	varchar(200),
		RoleType		varchar(10)		
		)

		insert into @classess
		select distinct 
		 class_code			as ClassCode
		 ,full_name			as ClassName
		,class_homeroom_flag as ClassType
		,Semester as Semester
		,[dbo].[Student.Class.Info](school_year,school_code,'',class_code, Semester,  'Terms')  as Term
		,dbo.DateF(term_start,'YYYYMMDD')			as StartDate
		,dbo.DateF(term_end,'YYYYMMDD')			as EndDate 
   		,dbo.[ActionTask.ASM]('TaskMenu','SIS',IDs, School_Year,School_Code,@AppID,'Class',Class_code,full_name,Teacher_ID)  as Actions
		,dbo.[ActionTask.ASM]('Edit',    'SIS',IDs, School_Year,School_Code,@AppID,'Class',Class_code,full_name,Teacher_ID)  as EditAction
		,dbo.[ActionTask.ASM]('Delete',  'SIS',IDs, School_Year,School_Code,@AppID,'Class',Class_code,full_name,Teacher_ID) as DeleteAction
		,'SIS'
 		from [dbo].[SIC_sys_SchoolClasses] 
		where school_year = @SchoolYear and school_code =  @SchoolCode and Teacher_ID =   @StaffPersonID
		-- order by RowNo

		select *,
			ROW_NUMBER() OVER(ORDER BY ClassCode  ) AS RowNo 
		from @classess
		order by RowNo

	end
else if @Operate ='APP' 
	begin
  
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
			EditAction	varchar(500),
			DeleteAction	varchar(500)
			)

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
    		,dbo.[ActionTask.ASM]('TaskMenu','APP',T.IDs, @SchoolYear,T.SchoolCode,T.AppID,@ModelID,T.MemberID,T.GroupID, M.GroupType)  as Actions
			,dbo.[ActionTask.ASM]('Edit',    'APP',T.IDs, @SchoolYear,T.SchoolCode,T.AppID,@ModelID,T.MemberID,T.GroupID, M.GroupType ) as EditAction
			,dbo.[ActionTask.ASM]('Delete',  'APP',T.IDs, @SchoolYear,T.SchoolCode,T.AppID,@ModelID,T.MemberID,T.GroupID, M.GroupType ) as DeleteAction
 
 
 		from [dbo].[SIC_sys_UserGroup_MemberTeachers]		as T
		inner join  [dbo].[SIC_sys_UserGroup_Members]		as M on  T.SchoolCode = M.SchoolCode and T.AppID = M.AppID and T.GroupID = M.GroupID 
		left join [dbo].[SIC_sys_UserGroup_MemberStudents]	as S on  M.SchoolCode = S.SchoolCode and M.AppID = S.AppID and M.GroupID = S.GroupID and M.GroupType = S.GroupType
		where T.MemberID = @StaffUserID
   

		select *, ROW_NUMBER() OVER(ORDER BY AppID, GroupID ) AS RowNo 
		from @Apps
		order by RowNo
	end
else if @Operate ='SchoolYearDate'
	begin
		if exists (select * from dbo.SIC_sys_SchoolYear	where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode)
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
