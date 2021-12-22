



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: January 05,  2021  
-- Description	: Get Studdent Contact phone number Information
-- =====================================================================================
 
CREATE FUNCTION [dbo].[Student.Contact.Phone](@PersonID varchar(13),@InfoType varchar(30) )
RETURNS varchar(50)  
--  @ContactType = Father / Mother/ Doctor
 AS  
BEGIN
    declare @rValue  varchar(50), @ContactPersonID char(13)

 	--set @ContactPersonID = (select top 1 contact_person_id  from 	student_contacts 
		--			 where 	student_person_id = @PersonID and relationship_type_name = @ContactType
		--			 order by [start_date] desc )
					  
	if @InfoType ='Email'
		 set @rValue =  (select top 1  isnull(email_account,'') 
						from  	dbo.person_telecom
						 WHERE  end_date is null and  person_id = @PersonID and (telecom_type_name in ('Internet','Cellular') and email_type_flag ='x')
						 order by start_date DESC )
	else if @InfoType ='Primary'
		begin
			set @rValue= (
					select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
					from dbo.person_telecom 
					where person_id= @PersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
					order by [priority]
					)
			if isnull(@rValue,'') =''
				begin
					set @ContactPersonID =(select top 1 contact_person_id from dbo.student_contacts  
									where student_person_id = @PersonID and (guardian_flag='x' or legal_custody_flag='x')
									order by primary_contact_priority)
					set @rValue= (
							select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
							from person_telecom 
							where person_id= @ContactPersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
							order by [priority]
					)

				end
 
		end
	else if @InfoType ='Secondary'
		begin
			set @rValue= (select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
					from dbo.person_telecom 
					where person_id= @PersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
						  and [priority] !='1'
					order by [priority]
					)
			if isnull(@rValue,'') =''
				begin

					set @ContactPersonID =(select top 1 contact_person_id from dbo.student_contacts  
									where student_person_id = @PersonID and (guardian_flag='x' or legal_custody_flag='x')
									order by primary_contact_priority)
					set @rValue= (
							select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
							from person_telecom 
							where person_id= @ContactPersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
							and [priority] !='1'
							order by [priority]
					)
				end
			if @rValue = [dbo].[Student.Contact.Phone](@PersonID,'Primary' )  set @rValue =''
		end			

	else if @InfoType ='Alternate'
		begin
			declare @PrimaryPhone varchar(20), @SecondaryPhone varchar(20)
			select @PrimaryPhone = [dbo].[Student.Contact.Phone](@PersonID,'Primary' ), @SecondaryPhone =  [dbo].[Student.Contact.Phone](@PersonID,'Secondary' )

				set @rValue= (select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
					from dbo.person_telecom 
					where person_id= @PersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
						  and area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @PrimaryPhone  
						  and area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @SecondaryPhone
					order by [priority]
					)

				if isnull(@rValue,'') =''
						begin
							set @rValue= ( select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
											from dbo.person_telecom  as PT
											inner join  dbo.student_contacts   as SC on PT.person_id = SC.contact_person_id and ( guardian_flag='x' or legal_custody_flag='x')
											where SC.student_person_id = @PersonID and PT.end_date is null and getdate() between PT.start_date and isnull(PT.end_date,getdate()) and PT.email_type_flag !='x' and isnull(PT.phone_no,'') != ''
												and  area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @PrimaryPhone
												and  area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @SecondaryPhone
											order by  SC.primary_contact_priority, PT.[priority])
						end 

		end
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
 

