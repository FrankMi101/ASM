



-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: January 05,  2021  
-- Description	: Get Studdent Contact phone number Information
-- =====================================================================================
 
CREATE FUNCTION [dbo].[Student.Contact.Phone.Secondary](@PersonID varchar(13),@InfoType varchar(30),@PrimaryPhone varchar(20) )
RETURNS varchar(50)  
--  @ContactType = Father / Mother/ Doctor
 AS  
BEGIN
    declare @rValue  varchar(50), @ContactPersonID char(13)
 if @InfoType ='Secondary'
		begin
			set @rValue= (select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
					from dbo.person_telecom 
					where person_id= @PersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
						  and  area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @PrimaryPhone
						   and [priority] != '1'
					order by [priority]
					)
			--if isnull(@rValue,'') =''
			--	begin
			--		set @ContactPersonID =(select top 1 contact_person_id from dbo.student_contacts  
			--						where student_person_id = @PersonID and (guardian_flag='x' or legal_custody_flag='x')
			--						order by primary_contact_priority)
			--		set @rValue= (
			--				select top 1 area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) as phone_no
			--				from person_telecom 
			--				where person_id= @ContactPersonID and end_date is null and getdate() between start_date and isnull(end_date,getdate()) and email_type_flag !='x' and isnull(phone_no,'') != ''
			--				and  area_code+'-'+left(phone_no,3)+'-'+substring(phone_no,4,4) != @PrimaryPhone
 		--					order by [priority]
			--		)
			--	end
 		end			
 
   RETURN isnull(@rValue ,'') 
END
 

