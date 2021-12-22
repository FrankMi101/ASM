

 


-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_asm_StudentList_Read 'ClassStudents' ,'mif','admin','20202021','0354','10','06/2'

CREATE  proc [dbo].[SIC_asm_StudentList_Read]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@AppID			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@GroupID	 	varchar(100) = null 

as 

set nocount on
 

if @Operate ='ClassStudents'   
  
  	select  top 200 
			 SS.person_ID							as StudentID, 
             replace( SS.Student_Name,'''','`')		as StudentName,
			 SS.Gender, SS.Grade, SS.school_code	as SchoolCode,	 
			 dbo.DateF(SS.birth_date,'YYYYMMDD')	as BirthDate,	 		 
 			 [dbo].[Student.HomeRoom] (SS.Person_id,SS.School_year,SS.School_Code,'Class' )	as HomeRoom,
             dbo.tcdsb_SES_FormatString('3-3-3',SS.student_no)  as StudentNo,
			 dbo.tcdsb_SES_FormatString('3-3-3',SS.Oen_number) as OEN,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Excep') as Exceptionality,
			 [dbo].[Student.SpecialEd](SS.person_id,SS.school_year,'Placement') as Placement,
			 SS.Status,
			 C.Class_code as ClassCode,

		 	 ROW_NUMBER() OVER(ORDER BY SS.Grade, SS.student_name  ) AS RowNo 

            from  dbo.SIC_sys_Students			as SS
			inner join dbo.tcdsb_Trillium_StudentProgramClassTracks as C  on SS.school_year = C.school_year  and SS.school_code = C.school_code and SS.Person_ID = C.Person_id 		 
		 	where SS.school_year = @SchoolYear and SS.school_code =@SchoolCode and C.Class_code =  @GroupID 
			order by RowNo 


 
