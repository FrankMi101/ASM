CREATE FUNCTION dbo.TC_StudentBackground(@ID  varchar(13), @Schoolyear varchar(8))
RETURNS   table   
--- Frank Mi
--- 2003.02.25
--- @type = 'School','Student','Teacher','Course', 'StudentRelevant'
--- @ID  = person_id , teacher_id, school_code 
AS 
  return
         select top 1 health_card_no				as StudentHCID, 
		    birth_country_name,
		    Country_of_origin,	 				 
		    social_insurance_no				as StudentSIN,	 
		    dbo.student(person_id,'FatherS')  		as F_SurName,
		    dbo.student(person_id,'FatherF')  		as F_FName,
		    dbo.student(person_id,'FatherPhone')  		as F_BusinessPhone,
		    dbo.student(person_id,'MotherS')		as M_SurName,
		    dbo.student(person_id,'MotherF') 		as M_FName,
		    dbo.student(person_id,'MotherPhone')		as M_BusinessPhone,	
		    dbo.student(person_id,'DoctorS')  		as D_SurName,
		    dbo.student(person_id,'DoctorF')  		as D_FName,
		    dbo.student(person_id,'DoctorPhone')  		as D_BusinessPhone,
		    dbo.student(person_id,'EmergencyS')		as E_SurName,
		    dbo.student(person_id,'EmergencyF') 		as E_FName,
		    dbo.student(person_id,'EmergencyPhone')	as E_BusinessPhone,
		    dbo.student(person_id,'EmergencyRelevant')	as E_Relevant 
	  
            from persons
	    Where person_id =@ID	



