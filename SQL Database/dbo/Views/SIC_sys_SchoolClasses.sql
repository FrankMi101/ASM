

CREATE view [dbo].[SIC_sys_SchoolClasses]
WITH SCHEMABINDING
as 
 

select CM.school_year, CM.school_code,  CM.school_year_track, CM.class_code, CM.block,CM.semester,CM.term, CM.room_no,
SC.reporting_teacher, SC.full_name,SC.class_homeroom_flag,SC.maximum_seats,SC.class_size,
CT.achieve_teacher,CT.attendance_teacher,
ST.term_start,ST.term_end,
TT.person_id as Teacher_ID,
'User ID' as UserID,
0 as IDs
--SR.Room_no as RoomNo, SR.full_name as Room_Name, SR.active_flag
 
from	   dbo.class_meetings			as CM 
inner join dbo.school_classes			as SC on CM.school_year = SC.school_year and CM.school_code =SC.school_code and CM.class_code = SC.class_code
inner join dbo.school_class_term		as CT on CM.school_year = CT.school_year and CM.school_code =CT.school_code and CM.school_year_track = CT.school_year_track and CM.class_code = CT.class_code and  CM.semester = CT.semester and CM.term = CT.term
inner join dbo.school_terms				as ST on CM.school_year = ST.school_year and CM.school_code =ST.school_code and CM.school_year_track = ST.school_year_track and  CM.semester = ST.semester and CM.term = ST.term 
left  join dbo.term_teachers			as TT on CM.school_year = TT.school_year and CM.school_code =TT.school_code and CM.school_year_track = TT.school_year_track and CM.block = TT.block  and CM.semester=TT.semester and CM.term = TT.term and CM.class_code = TT.class_code 
--left  join dbo.school_Rooms				as SR on CM.school_code = SR.school_code and CM.room_no = SR.room_no
where CM.school_year > '20202021' -- =   [dbo].[Current.SchoolYear]('Tri')  

