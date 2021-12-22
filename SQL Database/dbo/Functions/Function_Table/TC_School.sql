
--drop function  dbo.TC_School  select  * from    dbo.TC_School('0544','20042005')

CREATE FUNCTION dbo.TC_School(@ID  varchar(13), @Schoolyear varchar(8))
RETURNS   table   
--- Frank Mi
--- 2003.02.25
--- @type = 'School','Student','Teacher','Course', 'StudentRelevant'
--- @ID  = person_id , teacher_id, school_code 
AS 
  return
        select top 1  	isnull(school_name, ' ')  	 as SchoolName,
			isnull(school_brief_name, ' ')   as BriefName,
 			isnull(default_school_bsid, ' ') as BSID,
                       		dbo.school(school_code,'SuperArea') as SuperArea,
			-- dbo.school(school_code,'SuperName') as SuperName,
			dbo.School(school_code,'Address')   as Address,
			dbo.school(school_code,'PostCode')  as PostCode,
			dbo.school(school_code,'Principal') as Principal, 
			dbo.school(school_code,'PrincipalIEP') as PrincipalIEP, 
 			dbo.school(school_code,'Phone')     as SchoolPhone, 
 			dbo.school(school_code,'Fax') 	    as schoolFax,
 			dbo.school(school_code,'Semester')  as Semester,
 			dbo.school(school_code,'Term') 	    as Term,
                        dbo.School(school_code,'AddressFull')   as AddressFull,
  			dbo.School(school_code,'Street')   as Street,
			dbo.School(school_code,'City')   as City
			From schools
			WHERE school_code =@ID 






