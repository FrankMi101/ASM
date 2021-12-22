
CREATE view dbo.SIC_sys_SchoolClassTeacher
as 
select SAP.Exchange_NTUserID as UserID, SAP.CPNum, SAP.FirstName + ' ' + SAP.LastName  as TeacherName, 
CT.start_date,CT.end_date, 
FCM.FTE, FCM.class_code, FCM.assignment_name, FCM.class_status, FCM.school_year,FCM.school_code,FCM.class_model_id, FCM.reference_class_model_id
from	[dbo].[tcdsb_F100_ClassTeacher]				as CT
inner join  [dbo].[tcdsb_F100_FinalClassModel]		as FCM on CT.class_model_id = FCM.class_model_id and CT.school_year =FCM.school_year and CT.school_code = FCM.school_code 
left join dbo.tcdsb_vSAP_GAL						as SAP on CT.sap_no = SAP.CPNum  and SAP.PickedForGAL ='x'

union
    
   select SAP.Exchange_NTUserID as UserID, SAP.CPNum, SAP.FirstName + ' ' + SAP.LastName  as TeacherName, 
   TT.start_date,TT.end_date,
   CC.credit_value	 as FTE, TT.class_code, CC.course_title as assignment_name,'Open' as class_status, TT.school_year,TT.school_code,TT.person_id as class_model_id , '0000001' as reference_class_model_id
   from [dbo].[tcdsb_F107_teacher_timetables]		  as TT
    left join [dbo].[tcdsb_f107_course_codes]		  as CC on left(TT.class_code,6) =  CC.course_code  and TT.school_year =CC.school_year and TT.school_code =CC.school_code
    left join [dbo].[tcdsb_F107_combined_course_code] as CCC on TT.class_code = CCC.class_code and TT.school_year =CCC.school_year and TT.school_code =CCC.school_code
   left join  dbo.tcdsb_vSAP_GAL					  as SAP on TT.sap_cpnumber =SAP.CPNum and SAP.PickedForGAL='x'	
