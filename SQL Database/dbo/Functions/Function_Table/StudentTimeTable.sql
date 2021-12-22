

--drop function  dbo.StudentTimeTable   select * from dbo.StudentTimeTable('0001557745','20132014')

CREATE FUNCTION [dbo].[StudentTimeTable]
	(@PersonID  varchar(13), 
	 @Schoolyear varchar(8))
RETURNS   table   
--- Frank Mi
--- 2003.02.25
--- @type = 'School','Student','Teacher','Course', 'StudentRelevant'
--- @ID  = person_id , teacher_id, school_code 
AS 
  return
     
select   distinct top 100  SPC.school_year ,SPC.person_id,
        SPC.course_code  + '-' + SPC.course_section  as Coures_code , SPC.start_date , SPC.end_date
 	 , SCT.semester, SCT.term 
      ,  STL.school_period,   STL.start_time, STL.end_time  
 	  , SCR.room_no,  SCR.full_name as Room_Location         
      ,  dbo.PersonName (STC.Teacher_id, 'Name') AS Teacher_Name 
      , CC.course_title   

 from  dbo.student_program_class_tracks					  as SPC
 inner join dbo.tcdsb_Trillium_School_Classes_Term	  as SCT on SPC.school_code = SCT.school_code and SPC.school_year=SCT.school_year and SPC.class_code = SCT.class_code and SPC.School_year_track =  SCT.School_year_track  
  inner join dbo.tcdsb_Trillium_School_Classes_Teacher as STC on SCT.school_code = STC.school_code and SCT.school_year=STC.school_year and  SCT.School_year_track =  STC.School_year_track and SCT.class_code = STC.class_code and SCT.semester= STC.semester and SCT.term = STC.term
  inner join dbo.tcdsb_Trillium_School_TimeLines	  as STL on STC.school_code = STL.school_code and STC.school_year=STL.school_year and  STC.School_year_track =  STL.School_year_track  and STC.block = STL.block
 inner join dbo.tcdsb_Trillium_School_Classes_Room    as SCR on SCR.school_code = STC.school_code and SCR.school_year=STC.school_year  and SCR.class_code = STC.class_code 
  inner join dbo.course_codes						  as CC  on SPC.school_code = CC.school_code and SPC.school_year=CC.school_year and SPC.course_code = CC.course_code  
where  SPC.school_year = @Schoolyear and SPC.person_id = @PersonID
 order by SCT.semester, SCT.term ,Coures_code

---- 
--SPC.school_year ='20132014' and SPC.person_id ='0001557745'

--select * from student_program_class_tracks	
--where school_year ='20132014' and person_id ='0001557745'

