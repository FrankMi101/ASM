﻿



CREATE view [dbo].[SIC_sys_Students]
WITH SCHEMABINDING
as
select R.school_year,R.school_code,R.person_id,R.student_no,R.grade,R.status_indicator_code as Status,
P.birth_date, P.gender, --P.Preferred_surname, P.Preferred_middle_name,P.preferred_first_name,
P.legal_first_name,P.legal_surname,  rtrim(P.legal_surname) + ', '+ rtrim( P.legal_first_name) as Student_Name,
P.preferred_first_name ,  P.preferred_surname ,  P.oen_number, 
P.health_card_no as HealthCard,
--dbo.tcdsb_SES_FormatString2('3-3-4-2',P.health_card_no ) as HealthCard,
R.last_update_date_time  
-- , 
-- isnull(V.c_c2, R.school_Code)   as HomeSchool
-- [dbo].[Student.HomeSchool](R.person_id,R.school_year, R.school_code) as HomeSchool

from dbo.student_Registrations as R 
inner join dbo.persons  as P on R.person_id = P.person_id
--left join  dbo.fs_student_custom as V on R.person_id = V.person_id
where left(R.school_code,2) in ('02','03','04','05','XI','AS')
and R.school_year > '20102011'-- '20042004' --  >


GO
CREATE UNIQUE CLUSTERED INDEX [SIC_sys_Students_index]
    ON [dbo].[SIC_sys_Students]([school_year] ASC, [school_code] ASC, [grade] ASC, [person_id] ASC);


GO
CREATE NONCLUSTERED INDEX [SIC_sys_Students_index_OEN]
    ON [dbo].[SIC_sys_Students]([oen_number] ASC);


GO
CREATE NONCLUSTERED INDEX [SIC_sys_Students_index_StudentNo]
    ON [dbo].[SIC_sys_Students]([student_no] ASC);


GO
CREATE NONCLUSTERED INDEX [SIC_sys_Students_index_SurName]
    ON [dbo].[SIC_sys_Students]([preferred_surname] ASC, [legal_surname] ASC);


GO
CREATE NONCLUSTERED INDEX [SIC_sys_Students_index_FirstName]
    ON [dbo].[SIC_sys_Students]([preferred_first_name] ASC, [legal_first_name] ASC);

