
CREATE view [dbo].[SIC_sys_SchoolClasses_E]
WITH SCHEMABINDING
as 
select  SC.school_year,SC.school_code, SC.reporting_teacher,Sc.special_education_flag, SC.maximum_seats ,
SC.class_code,SC.class_homeroom_flag,SC.class_size,SC.full_name as course_title,SC.homeroom,SC.room_no, --   

--SR.full_name as Room_Name,
CT.semester,CT.term ,  ST.term_start,ST.term_end
-- CS.course_code,CS.course_section  ,    CC.course_title,  
 -- TP.school_timeline_code, TP.school_period,TP.start_time, TP.end_time
from dbo.school_classes              as SC
   inner join dbo.school_class_term                          as CT  on SC.school_year = CT.school_year and SC.school_code = 

CT.school_code and SC.class_code = CT.class_code  
 --   left join dbo.course_code_section    as CS  on SC.school_year = CS.school_year and SC.school_code = CS.school_code and SC.class_code = CS.class_code and CS.builder_set_code ='working' 
  -- inner join dbo.course_codes                as CC  on CS.school_year = CC.school_year and CS.school_code = CC.school_code and CS.course_code = CC.course_code
--     inner join dbo.school_Rooms                                           as SR  on SC.school_code = SR.school_code and SC.room_no = SR.room_no
--    inner join dbo.class_meetings                            as CM  on CT.school_year = CM.school_year and CT.school_code = CM.school_code and CT.class_code = CM.class_code  and CT.semester =CM.semester  and CT.term = CM.term
     inner join dbo.school_terms                                 as ST  on CT.school_year = ST.school_year and 

CT.school_code =ST.school_code and  CT.school_year_track = ST.school_year_track  and CT.Semester=ST.Semester and 

CT.term=ST.term 
 where SC.school_year = '20202021' 

