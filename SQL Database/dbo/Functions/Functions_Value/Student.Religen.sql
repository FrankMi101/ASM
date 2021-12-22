
--  drop function dbo.StudentReligen
CREATE FUNCTION [dbo].[Student.Religen](@person_id char(13),@vType char(30) )   
RETURNS varchar(200) 
--- Frank Mi
--- May 20 2015
--- Find a student's Parents or doctor's  name in trillium companion system 
--- @person_id    student person ID
--- @Reletionship   shoud be one of 'Father','Mather','Doctor','Emergency','Friend', 'Grandmother','GrandFather' and so no, 
---	any noe in relationship_type_name of student_contacts table 
 
AS  
BEGIN
    declare @rValue  varchar(50) 
    declare @rPersonID char(13)
    declare @FatherID  varchar(13)
    declare @MotherID  varchar(13)
    declare @GuardianID  varchar(13)
    
if  @vType ='SacrBaptismDate'
   
        set @rValue = (select top 1 dbo.DateF(sacr_baptism_date,'YYYYMMDD') from persons where Person_id = @person_id)

else if @vType = 'ChurchofBaptism'
	begin
 	       --  set @rValue = (select top 1  baptismal_parish_org_id  from persons where Person_id = @person_id)
			 set @rValue = (select top 1  full_name from organizations as O
													inner join Persons as P on P.baptismal_parish_org_id = O.organization_id
													where P. Person_id = @person_id)	 

	end

else if @vType = 'ChurchAddress'
     begin
 	     --    set @rValue = (select top 1  baptismal_parish_org_id  from persons where Person_id = @person_id)
			  set @rValue = (select top 1  full_name from organizations as O
													inner join Persons as P on P.baptismal_parish_org_id = O.organization_id
													where P. Person_id = @person_id)

	 end
else if @vType = 'ChatholicFlag'
     begin
 	     --    set @rValue = (select top 1  baptismal_parish_org_id  from persons where Person_id = @person_id)
			  set @rValue = (select top 1  case catholic_flag when 'x' then 'Yes' else 'No' end
							  from persons where Person_id = @person_id)

	 end

else if @vType = 'ScarBaptismFlag'
        set @rValue = (select top 1 case catholic_verification_code when 'Baptism' then case sacrament_baptism_flag when 'x' then 'Yes' else 'No' end else 'No' end	 
			 from persons where Person_id = @person_id)
else if @vType = 'ScarCommunionFlag'
        set @rValue = (select top 1 case catholic_verification_code when 'Baptism' then case sacrament_communion_flag when 'x' then 'Yes' else 'No' end else 'No' end	 
			 from persons where Person_id = @person_id)
else if @vType = 'ScarReconsiliationFlag'
        set @rValue = (select top 1 case catholic_verification_code when 'Baptism' then case sacrament_reconciliation_flag when 'x' then 'Yes' else 'No' end else 'No' end	 
			 from persons where Person_id = @person_id)
  
else
	set  @rValue = ''

   RETURN(@rValue) 
END
