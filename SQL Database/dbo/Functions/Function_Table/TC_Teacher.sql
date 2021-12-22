CREATE FUNCTION dbo.TC_Teacher(@ID  varchar(13), @Schoolyear varchar(8))
RETURNS   table   
--- Frank Mi
--- 2003.02.25
--- @type = 'School','Student','Teacher','Course', 'StudentRelevant'
--- @ID  = person_id , teacher_id, school_code 
AS 
  return
           select top 1 person_id  		as TercherID,
		    staff_no 			as TercherNo,
		    legal_SurName 		as SurName,
		    legal_First_Name 		as FName,
		    birth_date 			as BirthDate, 
		    gender			as grnder,
		    health_card_no			as TeacherHCID, 			 
		    social_insurance_no			as TeacherSIN,		 	
		    dbo.staff(person_id, 'Telephone' ) 	as Phone,
		    dbo.staff(person_id,'PostCode')    	as PostCode,
		    dbo.staff(person_id,'Address')     	as Address,	
		    dbo.staff(person_id,'Role')  	   	as TeacherRole,	
		    dbo.staff(person_id,'HomeroomNo')  	as HomeroomNo, 
		    dbo.staff(person_id,'Homeroomclass')	as HomeClass,
		    dbo.staff(person_id,'Homeroom')	as HomeRoom

  	    from persons
	    Where person_id =@ID	



