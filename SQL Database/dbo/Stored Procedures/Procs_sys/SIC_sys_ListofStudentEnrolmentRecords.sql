
  
-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Mary 12, 2021
-- Description	: to fix some student enrolment issue Trillium app user interface can't fixed 
-- =====================================================================================
  
 -- [dbo].[SIC_sys_ListofStudentEnrolmentRecords]  'Records','mif','admin','20202021','813029752'
CREATE proc [dbo].[SIC_sys_ListofStudentEnrolmentRecords]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@PersonID		varchar(13) = null,
	@SchoolCode		varchar(8) = null,
	@TypeID			varchar(1) = null,
	@EffectiveDate	varchar(10) = null
as
set nocount on
 
  
 -- ******************** Basic Info of Enrolments ***********************************************************************************************
/*
	 select transaction_type_ind, description from dbo.transaction_types_desc where locale ='EN_CA'
	1	Entry
	2	Enrolment
	3	Funding
	4	Arrival
	5	Departure
	8	Share
	9	Transfer

*/
-- ******************************************************************************************************************* 
declare @GoPage varchar(100), @Target varchar(50),@Width varchar(4),@Height varchar(4), @iPage varchar(100),@iTarget varchar(50)
select @GoPage ='../SICStudent/EnrolmentEdit.aspx' , @Target ='EditDIV',@Height='400',@Width ='600'
 


declare @StudentName  varchar(50), @Grade varchar(2), @OEN varchar(11), @StudentNo varchar(11)

if len(@PersonID) = 9
	select top 1 @StudentName = dbo.[Student.Name](P.person_id,'Name'), @Grade = grade ,@PersonID = P.person_id ,
	@OEN =  dbo.tcdsb_SES_FormatString('3-3-3',P.oen_number),@StudentNo = dbo.tcdsb_SES_FormatString('3-3-3',P.student_no)
	from dbo.student_registrations as R
	inner join dbo.persons as P		on R.person_id = P.person_id
	where school_year = @SchoolYear and R.student_no = @PersonID
else
	select top 1 @StudentName = dbo.[Student.Name](P.person_id,'Name'), @Grade = grade ,@PersonID = P.person_id ,
	@OEN =  dbo.tcdsb_SES_FormatString('3-3-3',P.oen_number),@StudentNo = dbo.tcdsb_SES_FormatString('3-3-3',P.student_no)
	from dbo.student_registrations as R
	inner join dbo.persons as P		on R.person_id = P.person_id
	where school_year = @SchoolYear and R.person_id = @PersonID

if @Operate ='Records'
			select  
		   [dbo].[ActionTask.Student]('TaskMenu',@UserID, @UserRole, School_Year, School_code,@Grade, Person_ID, dbo.tcdsb_SES_FormatString('3-3-3',student_no),@StudentName) as Actions,
			active_flag	as ActiveFlag, school_year	as SchoolYear,	school_code	as SchoolCode,school_year_track as SchoolYearTrack,
			effective_date								as EffectiveDate, 
			isnull(transaction_type_ind,'')							as EnrolmentTypeID,
			[dbo].[Student.Enrolment.Name](transaction_type_ind)	as EnrolmentTypeName, 
			dbo.[school.Name](school_code)							as SchoolName,
			isnull(dbo.[school.Name](demit_next_school_code),'')	 as SchoolNameNext,
			[dbo].[Student.Name](person_id,'Name')		as StudentName,
			@OEN										as OEN, 
			@StudentNo									as StudentNo, 
			isnull(grade,'')							as Grade,
			isnull(entry_type_name,'')					as EntryTypeName, 
			isnull(demit_reason_name,'')				as DemitReasonName,
			isnull(school_bsid,'')						as SchoolBSID,
			isnull(demit_next_school_bsid,'')			as DemitNextBSID,
			isnull(demit_next_school_code,'')			as DemitNextSchoolCode,
		 	dbo.[ActionTask.Enrolment]('Edit',@GoPage,@Target,@Height,@Width,@UserID, @UserRole, school_year, school_Code,person_id,transaction_type_ind,dbo.DateF(effective_date,'YYYYMMDD')  )	as EditAction,
		 	 ROW_NUMBER() OVER(ORDER BY effective_date, transaction_type_ind ) AS RowNo

			from dbo.student_enrolments
			where person_id = @PersonID   and school_year = @SchoolYear   and active_flag ='x' --  and school_code = @SchoolCode
			order by effective_date, EnrolmentTypeID
  else
	 	  select  
		   [dbo].[ActionTask.Student]('TaskMenu',@UserID, @UserRole, School_Year, School_code,@Grade, Person_ID, dbo.tcdsb_SES_FormatString('3-3-3',student_no),@StudentName) as Actions,
			active_flag	as ActiveFlag, school_year	as SchoolYear,	school_code	as SchoolCode,school_year_track as SchoolYearTrack,
			effective_date								as EffectiveDate, 
			isnull(transaction_type_ind,'')							as EnrolmentTypeID,
			[dbo].[Student.Enrolment.Name](transaction_type_ind)	as EnrolmentTypeName, 
			dbo.[school.Name](school_code)							as SchoolName,
			isnull(dbo.[school.Name](demit_next_school_code),'')	 as SchoolNameNext,
			[dbo].[Student.Name](person_id,'Name')		as StudentName,
			@OEN										as OEN, 
			@StudentNo									as StudentNo, 
			isnull(grade,'')							as Grade,
			isnull(entry_type_name,'')					as EntryTypeName, 
			isnull(demit_reason_name,'')				as DemitReasonName,
			isnull(school_bsid,'')						as SchoolBSID,
			isnull(demit_next_school_bsid,'')			as DemitNextBSID,
			isnull(demit_next_school_code,'')			as DemitNextSchoolCode 
 
			from dbo.student_enrolments
			where person_id = @PersonID   and school_year = @SchoolYear   and active_flag ='x' and school_code = @SchoolCode and transaction_type_ind =@TypeID and effective_date =@EffectiveDate
			order by effective_date, EnrolmentTypeID

