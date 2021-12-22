


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: January 05,  2021  
-- Description	: Get Studdent Contact Information
-- =====================================================================================
 
CREATE FUNCTION [dbo].[Student.Contact.ByPriority](@personID varchar(13),@Priority varchar(20),@InfoType varchar(30) )
RETURNS varchar(50)  
--  @ContactType = Father / Mother/ Doctor
--  @InfoType =  Name/ SurName/ FirstName/ Email/ Cell /Home/ Business / Emergency
AS  
BEGIN

    declare @rValue  varchar(50) 
    declare @ContactPersonID char(13)

 	set @ContactPersonID = (select top 1 contact_person_id 
					 from 	dbo.student_contacts 
					 where 	student_person_id = @PersonID 
							and  legal_custody_flag ='x' and guardian_flag ='x'
							and  getdate() between start_date and isnull(end_date, getdate())
							and  primary_contact_priority = @Priority
					 order by [start_date] desc )

	if 	isnull(@ContactPersonID,'') = ''
	    	set @ContactPersonID = (select top 1 contact_person_id 
					 from 	dbo.student_contacts 
					 where 	student_person_id = @PersonID 
							and  legal_custody_flag ='x' and guardian_flag ='x'
							and   end_date is null  -- getdate() between start_date and isnull(end_date, getdate())
 					 order by  primary_contact_priority,[start_date] desc )
		 
if  @InfoType ='ID'
	set @rValue = @ContactPersonID
else if @InfoType ='Relationship'
	set @rValue = (select top 1 relationship_type_name from dbo.student_contacts  where contact_person_id = @ContactPersonID )
else if  @InfoType ='Name' 
    set @rValue =  dbo.PersonName(@ContactPersonID,'Full') 
else if  @InfoType ='SurName'
	set @rValue =  dbo.PersonName(@ContactPersonID,'SurName') 
else if  @InfoType ='FirstName'
	set @rValue =  dbo.PersonName(@ContactPersonID,'FirstName') 
else if  @InfoType ='PrimaryPhone'
	set @rValue = ( select top 1 '('+isnull(area_code,'416')+')' +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'       ')  + isnull((' Ext '+ extension), '   ')
					 from  	dbo.person_telecom 
					 WHERE  end_date is null and person_id = @ContactPersonID and  [priority] = '1' --and getdate() between start_date and isnull(end_date,getdate())
                     order by start_date DESC 
	)
else if  @InfoType ='SecondPhone'
	set @rValue = ( select top 1 '('+isnull(area_code,'416')+')' +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'       ')  + isnull((' Ext '+ extension), '   ')
					 from  	dbo.person_telecom 
					 WHERE  end_date is null and person_id = @ContactPersonID and  [priority] = '2' --and getdate() between start_date and isnull(end_date,getdate())
                     order by start_date DESC 
	)
else if  @InfoType ='ThridPhone'
	set @rValue = ( select top 1 '('+isnull(area_code,'416')+')' +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'       ')  + isnull((' Ext '+ extension), '   ')
					 from  	dbo.person_telecom 
					 WHERE  end_date is null and person_id = @ContactPersonID and  [priority] = '3' --and getdate() between start_date and isnull(end_date,getdate())
                     order by start_date DESC 
	)

else if @InfoType ='Email'
     set @rValue =  (select top 1  isnull(email_account,'') 
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID and (telecom_type_name in ('Internet','Cellular') and email_type_flag ='x')
                     order by start_date DESC )
else
	 set @rValue =  (select top 1   '('+isnull(area_code,'416')+')' +isnull((left(phone_no,3)+'-'+ substring(phone_no,4,4)),'       ')  + isnull((' Ext '+ extension), '   ')
					 from  	dbo.person_telecom
					 WHERE  end_date is null and  person_id = @ContactPersonID --and  telecom_type_name = @InfoType -- Cell /Home/ Business / Emergency
                     order by [priority], start_date DESC )

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
 

