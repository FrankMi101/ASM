

 
-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_StudentList '' ,'mif','admin','20192020','0325','00', 'SurName','','School'

CREATE  proc [dbo].[SIC_sys_StudentListbyGrade]  
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null 

as 

set nocount on

declare @RelationBy  varchar(20) ,@IPRC varchar(10),@IEP varchar(10),@ITFcode varchar(10)
declare @RelationValue varchar(50)	
declare @UserRole varchar(20), @SearchBy varchar(30), @SearchValue varchar(50),@Scope varchar(20),@Program varchar(10), @Term varchar(10) , @Semester varchar(10) 

select @IPRC ='No', @IEP='No',@ITFcode ='00'

if @Program ='IEP'  set @IEP ='Yes'
if @Program ='IPRC'  set @IPRC ='Yes'
if @Program ='Gift'  set @ITFcode ='ITF'
if @Program ='Autism'  set @IPRC ='Yes'

if @IPRC is null set @IPRC ='No'

if  @UserRole is null set @UserRole ='Principal'

if  @Scope ='Board'
    set @SchoolCode = left(@schoolCode,1) + '%'
else
    set @SchoolCode = @schoolCode  + '%'

declare @ClassCode  varchar(10) 
if  @Grade ='ZZ'  
	set  @ClassCode ='%'
else
	set @ClassCode = REPLACE (@Grade,'ZZ-','') + '%'
   	 
if left(@Grade,2) <> 'ZZ' set @ITFcode ='00'
if @ITFcode ='' set @ITFcode ='00' 
if left(@Grade,2) in ('00','99') 
	set @Grade ='%'
else
    set @Grade = @Grade +'%'

declare @StudentListMatchbyUser  as table
		(School_year varchar(8),
		 school_code varchar(8),
		 Grade		 varchar(8),
		 Person_ID   varchar(23) 
		)


if @Scope ='Board' 
	set @SearchValue = isnull(@SearchValue,'a' ) + '%'
else
	set @SearchValue = isnull(@SearchValue,'' ) + '%'

--insert into @StudentListMatchbyUser
--select School_year, school_code,Grade,Person_ID
--from dbo.tcdsb_SES_getStudentListbyUser5_ITF(@SchoolYear,@SchoolCode,@Grade,@UserID,@UserRole,@ITFcode, @ClassCode,@IPRC,@IEP,@SearchValue) 
  
  
declare  @Menu varchar(200), @p varchar(7)
  
set @Menu =  '<a title= "click to open action menu"  href="javascript:OpenMenu(' 
set  @p =''','''
 
  	select   
			 SS.person_ID							as StudentID, 
             SS.Student_Name						as StudentName,
			 SS.Gender, SS.Grade, SS.school_code	as SchoolCode,
			 [dbo].[School.Name](SS.school_code)	as SchoolName,			 
			 [dbo].[School.Name_Brief](SS.school_code)	as SchoolBrief,			 
			 dbo.DateF(SS.birth_date,'YYYYMMDD')	as BirthDate,	 		 
 			 
             dbo.tcdsb_SES_FormatString('3-3-3',SS.student_no)  as StudentNo,
			 dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number) as OEN,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Excep') as Exceptionality,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Placement') as Placement,
			 ' Some comments ' as Comments,
              @Menu +  '''' +  SS.school_year + @P + SS.School_code  + @P + SS.Grade + @P + SS.Person_ID + @P + SS.student_name +''')">'  
			 + '<img src="../images/menu.png" border="0" width="20" height="16">' + '</a>' as Actions, 
			 [dbo].[Student.IsInProgram]('Gift',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsGift,
			 [dbo].[Student.IsInProgram]('IEP',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsIEP,
			 [dbo].[Student.IsInProgram]('IPRC',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)			as IsIPRC,
			 [dbo].[Student.IsInProgram]('Alternative',@Program,SS.school_year,SS.school_code,SS.grade,SS.Person_id,@Term,@Semester)	as IsAlternative,

			 ROW_NUMBER() OVER(ORDER BY SS.Grade, SS.student_name  ) AS RowNo 

            from  dbo.tcdsb_SES_Students		as SS
--			inner join @StudentListMatchbyUser  as SL  on SS.school_year = SL.school_year and SS.Person_ID = SL.Person_id  and SS.school_code = SL.school_code and SS.grade=SL.Grade 
  			where SS.school_year = @SchoolYear  and SS.school_code like (@SchoolCode)
		 	and SS.Grade  like (@Grade)    and  SS.student_name like (@SearchValue)
			order by RowNo 



