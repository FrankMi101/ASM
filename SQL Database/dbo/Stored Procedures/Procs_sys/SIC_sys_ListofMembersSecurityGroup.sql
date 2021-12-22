








 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 05, 2021  
-- Description	: get Group members
-- =====================================================================================

-- drop  proc dbo.SIC_sys_ListofMembersSecurityGroup 'ClassStudents' ,'mif','admin','20202021','0354' ,'06/2','SIC'

CREATE proc [dbo].[SIC_sys_ListofMembersSecurityGroup]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(20) = null,
	@GroupID		varchar(200) = null,
	@MemberID		varchar(50) = null
as 

set nocount on
  
		declare @Apps as table
			(AppID varchar(20),
			GroupID varchar(200),
			GroupName varchar(300),
			GroupType	varchar(30),
			Permission	varchar(20),
			MemberID	varchar(20),
			MemberName	varchar(100),
			IsActive	varchar(10),
			StartDate   varchar(10),
			EndDate		varchar(10))
	 
	 	declare @Match_Student_List  as table
			(School_year varchar(8),
			 school_code varchar(8),
			 Grade		 varchar(10),
			 Person_ID   varchar(20),
			 class_code	varchar(20)
		)

 if  @Operate ='GroupInformation'
	begin
		select distinct @SchoolYear, M.SchoolCode,M.AppID  
			,M.GroupID
			,M.GroupName
			,M.GroupType
			,M.Permission
			,M.Comments
 			,dbo.DateF(getdate(),'YYYY-MM-DD')			as StartDate
			,dbo.DateF(getdate(),'YYYY-MM-DD')			as EndDate 	
			,IDs
 		from [dbo].[SIC_sys_UserGroup_Members] as M 
		where   SchoolCode = @SchoolCode  and AppID = @AppID and GroupID = @GroupID
	
	end
 else if @Operate ='GroupTeachers' 
 	begin
		 
		Insert into @Apps
		select distinct M.AppID  
			,M.GroupID
			,M.GroupName
			,M.GroupType
			,M.Permission
			,T.MemberID 
			,dbo.[Staff.Name](T.MemberID,'Name') as MemberName
			,case isnull(M.Active_flag,'') when 'x' then 'true' else 'false' end as IsActive
			,dbo.DateF(T.StartDate,'YYYY-MM-DD')			as StartDate
			,dbo.DateF(T.EndDate,'YYYY-MM-DD')			as EndDate 		
 		from [dbo].[SIC_sys_UserGroup_MemberTeachers]	as T
		inner join [dbo].[SIC_sys_UserGroup_Members]	as M on   T.SchoolCode = M.SchoolCode and T.AppID = M.AppID and T.GroupID = M.GroupID 
		where    T.SchoolCode = @SchoolCode  and T.AppID = @AppID and T.GroupID = @GroupID
	
		select *, ROW_NUMBER() OVER(ORDER BY AppID, GroupID ) AS RowNo 
		from @Apps
		order by RowNo
	end
else if @Operate ='GroupStudents' 
	begin
		declare @GroupType varchar(20), @GroupValue varchar(20)

		select Top 1 @GroupType = S.GroupType, @GroupValue = @MemberID  -- S.MemberID  
  		from  [dbo].[SIC_sys_UserGroup_Members]	as M  
		left join [dbo].[SIC_sys_UserGroup_MemberStudents] as S on   M.SchoolCode = S.SchoolCode and M.AppID = S.AppID and M.GroupID = S.GroupID and M.GroupType = S.GroupType
 		where    M.SchoolCode = @SchoolCode and M.AppID  = @appID  and M.GroupiD = @GroupID 

	 
		
		if @GroupType ='School'
			insert into @Match_Student_List
			select  school_year, school_code, grade, person_id ,''
			from  dbo.SIC_sys_Students		
			where school_year = @SchoolYear and school_code =    @GroupValue
		if @GroupType ='Grade'
			insert into @Match_Student_List
			select  school_year, school_code, grade, person_id,''
			from  dbo.SIC_sys_Students		
			where school_year = @SchoolYear and school_code = @SchoolCode and Grade =   @GroupValue
		if @GroupType ='Class'
			insert into @Match_Student_List
			select  school_year, school_code, grade, person_id, class_code
			from  [dbo].[SIC_sys_StudentClasses]		
			where school_year = @SchoolYear and school_code = @SchoolCode and class_code  like ( @GroupValue + '%')

		select  
			 SS.person_ID							as StudentID, 
             replace( SS.Student_Name,'''','`')		as StudentName,
			 SS.Gender, SS.Grade, SS.school_code	as SchoolCode,
			 SS.[Status],
			 dbo.DateF(SS.birth_date,'YYYYMMDD')	as BirthDate,	 		 
 			 
             dbo.tcdsb_SES_FormatString('3-3-3',SS.student_no)  as StudentNo,
			 dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number) as OEN,
			-- [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Excep') as Exceptionality,
			-- [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Placement') as Placement,
			 SL.class_code  as ClassCode,
		 	 ROW_NUMBER() OVER(ORDER BY SS.Grade, SS.student_name  ) AS RowNo 

            from  dbo.SIC_sys_Students			as SS
			inner join @Match_Student_List		as SL  on SS.school_year = SL.school_year  and SS.school_code = SL.school_code and SS.Person_ID = SL.Person_id and SS.grade=SL.Grade 
 			order by RowNo  

	end
 else if @Operate ='ClassStudents' 
	begin			 
			insert into @Match_Student_List
			select  school_year, school_code, grade, person_id, class_code
			from  [dbo].[SIC_sys_StudentClasses]		
			where school_year = @SchoolYear and school_code = @SchoolCode and class_code  like ( @GroupID + '%')
 

		select  
			 SS.person_ID							as StudentID, 
             replace( SS.Student_Name,'''','`')		as StudentName,
			 SS.Gender, SS.Grade, SS.school_code	as SchoolCode,
			 SS.[Status],
			 dbo.DateF(SS.birth_date,'YYYYMMDD')	as BirthDate,	 		 
 			 
             dbo.tcdsb_SES_FormatString('3-3-3',SS.student_no)  as StudentNo,
			 dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number) as OEN,
			-- [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Excep') as Exceptionality,
			-- [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Placement') as Placement,
			 SL.class_code  as ClassCode,
		 	 ROW_NUMBER() OVER(ORDER BY SS.Grade, SS.student_name  ) AS RowNo 

            from  dbo.SIC_sys_Students			as SS
			inner join @Match_Student_List		as SL  on SS.school_year = SL.school_year  and SS.school_code = SL.school_code and SS.Person_ID = SL.Person_id and SS.grade=SL.Grade 
 			order by RowNo  

	end
