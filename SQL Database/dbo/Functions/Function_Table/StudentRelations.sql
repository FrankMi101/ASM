

--drop function  dbo.StudentRelations   select * from dbo.StudentRelations('0001557745','Mother' )

CREATE FUNCTION [dbo].[StudentRelations]
	(@PersonID  varchar(13),  --- Student Person ID
	 @RelationType varchar(20) 
	 )
RETURNS   table   
--- Frank Mi
--- 2015.11.06 
 
AS
 
  return
 
Select distinct
 P.legal_surname, P.legal_first_name, P.preferred_surname, P.preferred_first_name, P.preferred_middle_name,  
  
C.relationship_Type_Name,
C.access_to_records_flag,
C.legal_custody_flag,
C.guardian_flag,
C.lives_with_student_flag,
C.receives_mail_flag,
C.pickup_access_flag,
C.speaks_lang_of_school_flag,
C.Primary_contact_priority,
C.school_closure_priority,
C.remark,
P.Catholic_flag,
dbo.PersonPhoneNumber( P.person_id, 'Internet') as Email,
dbo.PersonPhoneNumber( P.person_id, 'Home') as HomePhone,
dbo.PersonPhoneNumber( P.person_id, 'Business') as BusinessPhone,
dbo.PersonPhoneNumber( P.person_id, 'Cell') as MobialPhone,
dbo.PersonPhoneNumber( P.person_id, 'Emergency') as EmergencyPhone,
dbo.PersonAddress(P.person_id, 'All') as Addresses,
 
@PersonID as  Student_person_id,
person_id as Relation_Person_id
from  persons   as P
inner join student_contacts as C on P.person_id = C.contact_person_id

where person_id =   dbo.Find_RelationShip_PersonID(@PersonID, @RelationType)
