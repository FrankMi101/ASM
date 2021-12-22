






 


-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_ListofStudents '' ,'mif','admin','20202021','0501','10','','','School','',0,0

CREATE proc [dbo].[SIC_sys_ListofStudents]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null, 
	@Scope			varchar(20) =  null,
	@Program		varchar(30) = null,
	@Term			varchar(10) = null,
	@Semester		varchar(10) = null 

as 

set nocount on

declare @RelationBy  varchar(20) ,@IPRC varchar(10),@IEP varchar(10),@ITFcode varchar(10)
declare @RelationValue varchar(50)	

select @IPRC ='No', @IEP='No',@ITFcode ='00'

if @Program ='IEP'  set @IEP ='Yes'
if @Program ='IPRC'  set @IPRC ='Yes'
if @Program ='Gift'  set @ITFcode ='ITF'
if @Program ='Autism'  set @IPRC ='Yes'

if @IPRC is null set @IPRC ='No'

if  @UserRole is null set @UserRole ='Principal'

declare @ClassCode  varchar(10) 
if  @Grade ='ZZ'  
	set  @ClassCode ='%'
else
	set @ClassCode = REPLACE (@Grade,'ZZ-','') + '%'
   	 
if left(@Grade,2) <> 'ZZ' set @ITFcode ='00'
if @ITFcode ='' set @ITFcode ='00' 


if  @Scope ='Board'
	select @SchoolCode = left(@schoolCode,1) + '%' 
else
	select  @SchoolCode = @schoolCode  + '%' 

if left(@Grade,2) in ('00','99') 
	set @Grade ='%'
else
    set @Grade = @Grade +'%'

declare @Match_Student_List  as table
		(School_year varchar(8),
		 school_code varchar(8),
		 Grade		 varchar(8),
		 Person_ID   varchar(23) 
		)


if @SearchBy ='OEN'
	begin
 		insert into @Match_Student_List
		select  School_year, school_code,Grade,Person_ID
		from dbo.SIC_sys_Students
		where school_year = @SchoolYear and school_code like (@SchoolCode) and  oen_number = replace(@SearchValue,'-','')
	end
else if @SearchBy ='StudentNo'
	begin
		 
		insert into @Match_Student_List
		select  School_year, school_code,Grade,Person_ID
		from  dbo.SIC_sys_Students
		where school_year = @SchoolYear and school_code like (@SchoolCode) and student_no = replace(@SearchValue,'-','')
	end
else if @SearchBy ='FirstName'
	begin
 		insert into @Match_Student_List
		select  School_year, school_code,Grade,Person_ID
		from dbo.SIC_sys_Students
		where school_year = @SchoolYear and school_code like (@SchoolCode) and ( preferred_first_name like (@SearchValue +'%')  or  legal_first_name like (@SearchValue +'%'))
	end
else if @SearchBy ='LastName'
	begin
 		insert into @Match_Student_List
		select    School_year, school_code,Grade,Person_ID
		from dbo.SIC_sys_Students
		where school_year = @SchoolYear and school_code like (@SchoolCode) and ( preferred_surname like (@SearchValue +'%')  or  legal_surname like (@SearchValue +'%') )
	end

else if @SearchBy ='Age'
	begin
 		insert into @Match_Student_List
		select  School_year, school_code,Grade,Person_ID
		from dbo.SIC_sys_Students
		where school_year = @SchoolYear and school_code like (@SchoolCode) and dbo.[Student.Age.Today](person_id) = @SearchValue
	end
else if @SearchBy ='Class'
	begin
		insert into @Match_Student_List
		select School_year, school_code,Grade,Person_ID
		from [dbo].[Student.List.byClass](@SchoolYear,@SchoolCode,@SearchValue) 
		set @Grade ='%'
		set @SearchValue ='%' 
	end
else
	begin
 			insert into @Match_Student_List
			select School_year, school_code,Grade,Person_ID
			from dbo.SIC_sys_Students where school_year = @SchoolYear and school_code like (@SchoolCode)
		--	from dbo.tcdsb_SES_getStudentListbyUser5_ITF(@SchoolYear,@SchoolCode,@Grade,@UserID,@UserRole,@ITFcode, @ClassCode,@IPRC,@IEP,@SearchValue) 
 	end
 
  
-- select  * from  @Match_Student_List
  
  	select  top 200 
			 SS.person_ID							as StudentID, 
             replace( SS.Student_Name,'''','`')		as StudentName,
			 SS.Gender, SS.Grade, SS.school_code	as SchoolCode,
			 [dbo].[School.Name](SS.school_code)	as SchoolName,			 
			 [dbo].[School.Name_Brief](SS.school_code)	as SchoolBrief,			 
			 dbo.DateF(SS.birth_date,'YYYYMMDD')	as BirthDate,	 		 
 			 [dbo].[Student.HomeRoom] (SS.Person_id,SS.School_year,SS.School_Code,'Class' )	as HomeRoom,
             dbo.tcdsb_SES_FormatString('3-3-3',SS.student_no)  as StudentNo,
			 dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number) as OEN,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Excep') as Exceptionality,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Placement') as Placement,
			 ' Some comments ' as Comments,
			 [dbo].[ActionTask.Student]('TaskMenu',@UserID, @UserRole, SS.School_Year, SS.School_code,SS.Grade, SS.Person_ID, dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number),SS.student_name) as Actions,
			 [dbo].[Student.IsInProgram]('Gift',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsGift,
			 [dbo].[Student.IsInProgram]('IEP', @Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsIEP,
			 [dbo].[Student.IsInProgram]('IPRC',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsIPRC,
			 [dbo].[Student.IsInProgram]('SSN', @Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsSSN,
			 [dbo].[Student.IsInProgram]('ESL', @Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsESL,
		 	 [dbo].[Student.IsInProgram]('Alternative',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)	as IsAlternative, 

		 	 ROW_NUMBER() OVER(ORDER BY SS.Grade, SS.student_name  ) AS RowNo 

            from  dbo.SIC_sys_Students			as SS
			inner join @Match_Student_List		as SL  on SS.school_year = SL.school_year  and SS.school_code = SL.school_code and SS.Person_ID = SL.Person_id and SS.grade=SL.Grade 
  			-- where SS.school_year = @SchoolYear  and SS.school_code like (@SchoolCode)
		 	where SS.Grade  like (@Grade)   -- and  SS.student_name like (@SearchValue)
			order by RowNo 


 
