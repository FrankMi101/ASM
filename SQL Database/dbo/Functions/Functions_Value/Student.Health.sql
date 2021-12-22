



--  drop function dbo.StudentReligen
create FUNCTION [dbo].[Student.Health](@person_id char(13),@vType char(20) )
RETURNS varchar(50) 
--- Frank Mi
--- May 20 2003
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
    
if  @vType ='Name'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
										from 	student_contacts 
										where 	student_person_id = @person_id and  access_to_records_flag ='x'
										order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonName(@GuardianID,'Name') 
               end
            else
               set @rValue =  dbo.PersonName(@MotherID,'Name') 
         end
      else
         begin
            if @MotherID is null
                set @rValue =  dbo.PersonName(@FatherID,'Name') 
            else
                set @rValue = isnull(dbo.PersonName(@FatherID,'Name'),'') + ' and ' + isnull(dbo.PersonName(@MotherID,'Name'),'')
         end   
     set @rValue = isnull(@rValue,'') 

  end     
if  @vType ='MotherName'
   begin   
  
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
       
      set @rValue =  dbo.PersonName(@MotherID,'Full') 
       
       set @rValue = isnull(@rValue,'') 

  end   

if  @vType ='FatherName'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
     set @rValue =  dbo.PersonName(@FatherID,'Full') 
     
     set @rValue = isnull(@rValue,'') 

  end   

  if  @vType ='FatherCell'
    begin   
       set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
     
      set @rValue = dbo.PersonPhoneNumber(@FatherID,'Cell')  -- dbo.PersonName(@FatherID,'Full') 
        
       set @rValue = isnull(@rValue,'') 

   end     

 if  @vType ='MotherCell'
    begin   
       set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
     
      set @rValue = dbo.PersonPhoneNumber(@FatherID,'Cell')  -- dbo.PersonName(@FatherID,'Full') 
        
       set @rValue = isnull(@rValue,'') 

   end     


if  @vType ='Full'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonName(@GuardianID,'Full') 
               end
            else
               set @rValue =  dbo.PersonName(@MotherID,'Full') 
        end
      else
         begin
            if @MotherID is null
               set @rValue =  dbo.PersonName(@FatherID,'Full') 
            else
               set @rValue = isnull(dbo.PersonName(@FatherID,'Full'),'') + ' and ' + isnull(dbo.PersonName(@MotherID,'Full'),'')
         end   
     set @rValue = isnull(@rValue,'') 

  end   

if  @vType ='SurName'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonName(@GuardianID,'SurName') 
               end
            else
               set @rValue =  dbo.PersonName(@MotherID,'SurName') 
        end
      else
         begin
            if @MotherID is null
               set @rValue =  dbo.PersonName(@FatherID,'SurName') 
            else
                begin
					declare @FL varchar(30)
					declare @ML	varchar(30)
					select @FL = isnull(dbo.PersonName(@FatherID,'SurName'),''),@ML = isnull(dbo.PersonName(@MotherID,'SurName'),'')
					if @FL = @ML
						set @rValue =@FL
					else
						set @rValue = @FL + ' and ' +  @ML
				end 
        end   
     set @rValue = isnull(@rValue,'') 

  end   
if  @vType ='FirstName'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonName(@GuardianID,'FirstName') 
               end
            else
               set @rValue =  dbo.PersonName(@MotherID,'FirstName') 
        end
      else
         begin
            if @MotherID is null
               set @rValue =  dbo.PersonName(@FatherID,'FirstName') 
            else
               set @rValue = isnull(dbo.PersonName(@FatherID,'FirstName'),'') + ' and ' + isnull(dbo.PersonName(@MotherID,'FirstName'),'')
         end   
     set @rValue = isnull(@rValue,'') 

  end   

if  @vType ='ParentPhoneB'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonPhoneNumber(@GuardianID,'Business') 
               end
            else
               set @rValue =  dbo.PersonPhoneNumber(@MotherID,'Business') 
        end
      else
         begin
            if @MotherID is null
               set @rValue = dbo.PersonPhoneNumber(@FatherID,'Business')  -- dbo.PersonName(@FatherID,'Full') 
            else
				begin
					set @rValue = isnull(dbo.PersonPhoneNumber(@FatherID,'Business'),'') 
					if @rValue =''
						set @rValue = isnull(dbo.PersonPhoneNumber(@MotherID,'Business'),'')
				end
         end   
     set @rValue = isnull(@rValue,'') 

  end     
 
  if  @vType ='ParentPhoneC'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = dbo.PersonPhoneNumber(@GuardianID,'Cell') 
               end
            else
               set @rValue =  dbo.PersonPhoneNumber(@MotherID,'Cell') 
        end
      else
         begin
            if @MotherID is null
               set @rValue = dbo.PersonPhoneNumber(@FatherID,'Cell')  -- dbo.PersonName(@FatherID,'Full') 
            else
               set @rValue = isnull(dbo.PersonPhoneNumber(@MotherID,'Cell'),'')
         end   
     set @rValue = isnull(@rValue,'') 

  end     



if  @vType ='RelationShip'
   begin   
      set @FatherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Father' 
		         order by start_date desc)
      set @MotherID =( select top 1 contact_person_id 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
				and relationship_type_name = 'Mother' 
		         order by start_date desc)
      if @FatherID is null 
         begin 
            if @MotherID is null
               begin
                   set @GuardianID = (select top 1 isnull(contact_person_id,'0000000000') 
			 from 	student_contacts 
			 where 	student_person_id = @person_id and  access_to_records_flag ='x'
		         order by primary_contact_priority, start_date desc)
                   set @rValue = 'Other' 
               end
            else
               set @rValue = 'Mother' 
        end
      else
         begin
            if @MotherID is null
               set @rValue =  'Father' 
            else
               set @rValue = 'Father/Mother'
         end   
     set @rValue = isnull(@rValue,'') 

  end  

   RETURN(@rValue) 
END
















