














-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_StaffList '' ,'mif','admin','20202021','0522','Teacher' , 'SurName','','School'

CREATE   proc [dbo].[SIC_sys_ListofAppraisal]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(20) = null,  -- Teacher/admi /support/principal
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null, 
	@Scope			varchar(20) =  null  
as 

set nocount on
 
     declare @PS     varchar(7)
    set @PS = ''','''

	declare @FilterTeacher as Table
	(	fSchool_Year varchar(8),
		fSchool_Code varchar(8),
		fCPNum		varchar(10))

   if @Grade ='TPA'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum 	from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code = @SchoolCode and Teacher_Status ='3-Active' and Evaluation_year in ('NE1','NE2','NE3','NE4')
    else if @Grade ='NTP'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum 	from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code =@SchoolCode and Teacher_Status ='3-Active' and Evaluation_year in ('NTO','NTP')
   else if @Grade ='LTO'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum 	from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code =@SchoolCode and Teacher_Status ='3-Active' and Evaluation_year in ('LTO','LTO2')
   else if @Grade ='Evaluation'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum 	from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code =@SchoolCode and Teacher_Status ='3-Active' and Evaluation_year in ('E')
   else if @Grade ='Ret'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum 	from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code =@SchoolCode and Teacher_Status = '2-Retired'
   else if @Grade ='Leave'
		insert into @FilterTeacher
		select school_year, school_Code, CPNum  from dbo.tcdsb_TPA_School_Staff 
		where school_year =@SchoolYear and school_code =@SchoolCode and Teacher_Status = '1-Leave/Layoff'

  	select		'ID' + School_Year  + School_code + Cpnum + tName as myKey, 
				School_Year as SchoolYear ,School_code as SchoolCode, CPNum as EmployeeID, tName as TeacherName,
					TeacherID as UserID,            
       				Gender,Evaluation_year  as AppraisalPhase ,
					Appr_Status as AppraisalStatus,
					TPA_phase as AppraisalType,
					Admin as Appraiser , Teacher_Status, EvidenceLevel, 
       				School_year + School_code + CPnum as myKey , tName as oName, WorkSession,
 					dbo.tcdsb_TPA_getSessionApprStatus3(School_year,School_code,UserID,Evaluation_year,'Process_Step') as AppraisalProcess,
					dbo.tcdsb_TPA_getAnnualPlanResult2(School_year,School_code,TeacherID,Evaluation_year,'No') as AP1,
					dbo.tcdsb_TPA_getAppraisalShow2(School_year,School_code,TeacherID,Evaluation_year,'Appraisal 1',Appraisal_1) as  Appraisal1,
					dbo.tcdsb_TPA_getAppraisalShow2(School_year,School_code,TeacherID,Evaluation_year,'Appraisal 2',Appraisal_2) as  Appraisal2,
        			dbo.tcdsb_TPA_getAppraisalShow2(School_year,School_code,TeacherID,Evaluation_year,'Appraisal 3',Appraisal_3) as  Appraisal3,       																												Appraisal_4  as Appraisal4, 
 					dbo.tcdsb_TPA_getAppraisalFinalRateShow2(school_year,school_code,TeacherID,Evaluation_year,Process_Step)	 as AppraisalOutcome,
					dbo.tcdsb_TPA_getAppraisalComments2(school_year,TeacherID,Evaluation_year,Appr_Status,FinalRating,comments) as  Comments ,
					 [dbo].[ActionTask.Appraisal] ('TaskMenu',@UserID, @UserRole, School_Year, School_code,CPNum, tName) as Actions,  

					 TimeType , 
					dbo.tcdsb_TPA_getAppraisalLink2(school_year,school_code,TeacherID,Evaluation_year,Tpa_phase,FinalRating)		as EPA,
					dbo.tcdsb_TPA_getAppraisalNote2(school_year,school_code,TeacherID,Evaluation_year,'PDF')			as pdffile,
					dbo.tcdsb_TPA_getAppraisalNote2(school_year,school_code,TeacherID,Evaluation_year,'Note')			as Notes , 
					isnull(Assignment,'') as EmployeePosition,
					isnull(Assignment,'') as Assignment, 
						dbo.[School.Name](School_Code)  as School,
					Mentee as Mentor,
   					  ROW_NUMBER() OVER(ORDER BY tName, Evaluation_year ) AS RowNo 

		 			from dbo.tcdsb_TPA_AppraisalListView22  as T
					inner join @FilterTeacher				as F on T.School_year =F.fSchool_Year and T.School_code = F.fSchool_Code and T.CPNum = f.fCPNum 
 				    where School_year =  @SchoolYear and School_code = @SchoolCode --	 and Teacher_Status ='3-Active'
 		     		order by  RowNo


			--	select * from dbo.tcdsb_TPA_AppraisalListView22 where school_year ='20202021' and school_code ='0531'
