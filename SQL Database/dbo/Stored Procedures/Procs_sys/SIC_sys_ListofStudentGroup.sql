
 




-- =====================================================================================
-- Author:		Frank Mi
-- Create date: November 30, 2020  
-- Description:	 get student list
-- =====================================================================================
 
-- drop  proc dbo.SIC_sys_StudentGroupList '' ,'mif','admin','20202021','0531','Course' , 'Course','','School','','1','1'

CREATE proc [dbo].[SIC_sys_ListofStudentGroup]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(20) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
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
 

declare @ListMatchbyUser  as table
		(School_year varchar(8),
		 school_code varchar(8),
		 Class_code  varchar(20),
		 Teacher_ID   varchar(30) 
		)

if @Grade = 'Course'
	begin
		if left(@SchoolCode,2 ) ='05' 
			begin
				--insert into @ListMatchbyUser
				--select distinct school_year, school_Code, Class_code,Reporting_teacher
				--from dbo.SIC_sys_SchoolClasses
				--where school_year = @SchoolYear  and   school_code = @SchoolCode  and Semester =@Semester and term = @Term 
				--	and Class_code like (@SearchValue +'%')
				 select distinct
				  SC.Class_code		as ClassCode, 
				  SC.course_Code	as CourseCode, 
				  SC.course_title 	as CourseTitle, 
				  [dbo].[Teacher.Name.ByID](SC.reporting_teacher,'Name') as CourseTeacher,
				  SC.Room_name		as CourseRoom,
				  SC.term_start		as StartDate, 
				  SC.term_end		as EndDate , 
				  maximum_seats		as ClassSize,
				  ' comments '  as Comments,
					 [dbo].[Student.ActionTask.Group]('TaskMenu',@UserID, @UserRole, SC.School_Year, SC.School_code,@Grade,SC.class_code,SC.Semester,SC.Term,SC.course_title) as Actions,
		 
		 			 ROW_NUMBER() OVER(ORDER BY SC.Class_code ) AS RowNo 

					from  dbo.SIC_sys_SchoolClasses_S 	as SC
				--	inner join @ListMatchbyUser  as SL  on SC.school_year = SL.school_year and SC.school_code = SL.school_code and SC.class_code = SL.Class_code  
  					where SC.school_year = @SchoolYear  and SC.school_code = @SchoolCode  and Semester =@Semester and term = @Term 
					and SC.Class_code like (@SearchValue +'%')
					order by RowNo 
			end
		else
			begin
				select distinct 
				  SC.Class_code		as ClassCode, 
				  SC.Class_code		as CourseCode, 
				  SC.course_title	as CourseTitle, 
				  [dbo].[Teacher.Name.ByID](SC.reporting_teacher,'Name') as CourseTeacher,
				  SC.room_no		as CourseRoom,
				  SC.term_start		as StartDate, 
				  SC.term_end		as EndDate , 
				  maximum_seats		as ClassSize,
				  ' comments '  as Comments,
					 [dbo].[Student.ActionTask.Group]('TaskMenu',@UserID, @UserRole, SC.School_Year, SC.School_code,@Grade,SC.class_code,SC.Semester,SC.Term,SC.course_title) as Actions,
		 
		 			 ROW_NUMBER() OVER(ORDER BY SC.Class_code ) AS RowNo 

					from  dbo.SIC_sys_SchoolClasses_E 	as SC
  					where SC.school_year = @SchoolYear  and SC.school_code = @SchoolCode   and Semester =@Semester and term = @Term 
					and Class_code like (@SearchValue +'%')
					order by RowNo 	
			end
		end
else if @Grade ='Grade'
	begin
		select 
		  Grade as ClassCode, 'Grade ' + Grade  as CourseTitle, 
		   ''   as CourseTeacher,
		   ''   as CourseRoom,
		   ''   as StartDate, 
		   ''  as EndDate , 	   
		  ''	as ClassSize,
		  ' comments '  as Comments,
		   
			 [dbo].[Student.ActionTask.Group]('TaskMenu',@UserID, @UserRole,  School_Year,  School_code,Grade,'','','', 'Grade ' + Grade ) as Actions,
		 
		 	 ROW_NUMBER() OVER(ORDER BY Grade ) AS RowNo 
		from [dbo].[tcdsb_SES_School_Grade]
		where school_year = @SchoolYear and school_code = @SchoolCode
	end
	

 
