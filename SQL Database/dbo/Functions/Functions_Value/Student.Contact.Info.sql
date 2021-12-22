

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: January 05,  2021  
-- Description	: Get Studdent Contact Information
-- =====================================================================================
 
CREATE FUNCTION [dbo].[Student.Contact.Info](@person_id varchar(13),@ContactType varchar(20),@InfoType varchar(30) )
RETURNS varchar(50)  
--  @ContactType = Father / Mother/ Doctor
--  @InfoType =  Name/ SurName/ FirstName/ Email/ Cell /Home/ Business / Emergency
AS  
BEGIN

    declare @rValue  varchar(50) 
    declare @ContactPersonID char(13)

 	set @ContactPersonID = (select top 1 contact_person_id 
					 from 	student_contacts 
					 where 	student_person_id = @person_id -- and  access_to_records_flag ='x'
							and relationship_type_name = @ContactType
					 order by [start_date] desc )

		 
if  @InfoType ='Name' 
    set @rValue =  dbo.PersonName(@ContactPersonID,'Full') 
else if  @InfoType ='SurName'
	set @rValue =  dbo.PersonName(@ContactPersonID,'SurName') 
else if  @InfoType ='FirstName'
	set @rValue =  dbo.PersonName(@ContactPersonID,'FirstName') 
else if @InfoType ='Email'
     set @rValue =  (select top 1  isnull(email_account,'') 
					from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and (telecom_type_name in ('Internet','Cellular') and email_type_flag ='x')
                     order by start_date DESC )
else
	 set @rValue =  (select top 1   '('+isnull(area_code,'416')+') '
					        +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'0000000')  + isnull((' Ext '+ extension), '     ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and  telecom_type_name = @InfoType -- Cell /Home/ Business / Emergency
                     order by start_date DESC )

/*
else if @InfoType ='Cell'
     set @rValue =  (select top 1   '('+isnull(area_code,'416')+') '
					        +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'0000000')  + isnull((' Ext '+ extension), '     ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and  telecom_type_name = 'Cell'  
                     order by start_date DESC )
else if @InfoType ='Business'
     set @rValue =  (select top 1   '('+isnull(area_code,'416')+') '
					        +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'0000000')  + isnull((' Ext '+ extension), '     ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and  telecom_type_name = 'Business'  
                     order by start_date DESC )
else if @InfoType ='Home'
     set @rValue =  (select top 1   '('+isnull(area_code,'416')+') '
					        +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'0000000')  + isnull((' Ext '+ extension), '     ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and  telecom_type_name = 'Home'  
                     order by start_date DESC )
else if @InfoType ='Emergency'
     set @rValue =  (select top 1   '('+isnull(area_code,'416')+') '
					        +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'0000000')  + isnull((' Ext '+ extension), '     ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and  telecom_type_name = 'Emergency'  
                     order by start_date DESC )

*/
   RETURN isnull(@rValue ,'') 
END
 

