CREATE FUNCTION dbo.TC_Student(@ID  varchar(13), @Schoolyear varchar(8))
RETURNS   table   

--- Frank Mi
--- 2003.02.25
--- @type = 'School','Student','Teacher','Course', 'StudentRelevant'
--- @ID  = person_id , teacher_id, school_code 
AS 
  return
          select top 1 person_id  	as StudentID,
		    student_no 		as StudentNo,
		    legal_SurName 	as SurName,
		    legal_First_Name 	as FName,
		    birth_date 		as BirthDate, 
		    gender		as gender,
		    dbo.StudentG(person_id,@schoolYear) as Grade,
		    dbo.Student(person_id,'Phone') as Phone,
		    dbo.Student(person_id,'Address') as Address	
            from persons
	    Where person_id =@ID	

