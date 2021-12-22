





-- =================================================================================
-- Author:		Frank Mi
-- Create date: November 16, 2015
-- Description:	get student Bio Gropphic information by person id 
-- ===================================================================================

CREATE FUNCTION [dbo].[Student.BioGrophic] (@Person_id char(13),@OBJ_attribt char(30) )  
RETURNS varchar(100)
 
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
	declare @rDoctorname varchar (30)
	declare @rDoctorphone varchar (30)
             declare @ReleshipID varchar(13)
             declare @rDate    smalldatetime
	declare @school_year varchar(8)
	declare @school_code varchar(4)
              declare @school_date smalldatetime
              declare @PFirstName  varchar(20)
              declare @LFirstName   varchar(20)  
	declare  @CreditT   numeric(8,1)

     	if @OBJ_attribt ='NumberF'
           set @rValue = (select top 1 left(student_no,3) +'-'+ substring(student_no,4,3) + '-' + right(student_no,3)
                          from persons where person_id =@Person_id)
     	if @OBJ_attribt ='Number'
     	--	declare @rValue varchar(10)
  	 	begin  set @rValue = dbo.FindStudentNo (@person_id) end
       	-- 	RETURN(@rValue)
     	if @OBJ_attribt ='O-E-N'
    	 	begin  set @rValue = (select top 1 left(oen_number,3) +'-'+ substring(oen_number,4,3) + '-' + right(oen_number,3) from persons where person_id = @person_id) end
     	if @OBJ_attribt ='OEN'
    	 	begin  set @rValue = (select top 1 oen_number from persons where person_id = @person_id) end
 	if @OBJ_attribt ='Name'
  		begin set @rValue = dbo.PersonName (@person_id,'Full')  end 
	if @OBJ_attribt ='SurName'
  		begin set @rValue = dbo.PersonName (@person_id,'SurName')  end 
	if @OBJ_attribt ='FirstName'
  		begin set @rValue = dbo.PersonName (@person_id,'FirstName')  end 
             if @OBJ_attribt ='NameF'
  		begin set @rValue = dbo.PersonName (@person_id,'Name')  end 
	if @OBJ_attribt ='ISAName'
     	--	declare @rValue varchar(30)
                           begin 
                                   set @PFirstName =  dbo.PersonName (@person_id,'PFirst') 
                                   set @LFirstName =  dbo.PersonName  (@person_id, 'LFirst')
                                   if @PFirstName =  @LFirstName 
 		             set @rValue = dbo.PersonName (@person_id,'LFull')   
                                   else
  		             set @rValue = dbo.PersonName (@person_id,'LFull')  + '  ( ' + @PFirstName   + ' ) ' 
                           end
       	 	-- RETURN(@rValue)
	if @OBJ_attribt ='Grade'
     		begin 
		--- The grade is by school year, Eva Au added the statement to check the school year 2004/03/09
			select  	 @school_year = school_year                   		
	        		from tcdsb_trillium_companion Where user_id =dbo.UserID()  

		set @rValue =  ( select top 1 grade  from student_registrations
				          where person_id = @person_id  and left(school_code,1) ='0' 
				          and school_year = @school_year                   -- added by Eva Au 2004/03/09	
				          order by school_year DESC , status_indicator_code  )	  	 
                          end
	if @OBJ_attribt ='SchoolCode'
     	--	declare @rValue varchar(2)
  	 	begin set @rValue =  ( select top 1 school_code from student_registrations
				          where person_id = @person_id  and left(school_code,1) ='0' 
				          order by school_year DESC , status_indicator_code  )	 	 
                          end
	if @OBJ_attribt ='SchoolYear'
     	--	declare @rValue varchar(2)
  	 	begin set @rValue =  ( select top 1 school_year from student_registrations
				          where person_id = @person_id  and left(school_code,1) ='0' 
				          order by school_year DESC , status_indicator_code  )	 	 
                          end
	if @OBJ_attribt ='Gender'
     	--	declare @rValue varchar(2)
  		begin
			 set @rValue = (select top 1 isnull(gender,' ') from persons
 				   where person_id =@person_id)
		end
       	 --	RETURN(@rValue)
	if @OBJ_attribt ='BirthDate'
     	--	declare @rValue varchar(30)
  		begin
		set @rValue = ( select top 1 convert(varchar(10), birth_date,111)	from persons
				where  person_id =@person_id)
		end    
	if @OBJ_attribt ='BirthDate1'  
  		begin
			set @rValue = ( select top 1 convert(varchar(10), birth_date,111)	from persons
					where  person_id =@person_id)
                                        set @rValue = substring(@rvalue,3,2) + substring(@rvalue,6,2)+ substring(@rvalue,9,2)
                          end
	if @OBJ_attribt ='BirthDate2'  
  		begin
			set @rValue = ( select top 1  isnull(cast(birth_date as varchar(11)),' ')	  from persons
					where  person_id =@person_id )
                                        set @rValue = left(@rvalue, 7) + substring(@rvalue,10,2) 

                           
                                        --            isnull(cast(P.birth_date as varchar(11))	
                      		--        set @rValue = ( select top 1 
			--	    cast(right(year(birth_date),2) as char(2)) +'/' +
                                        --                 case month(birth_date) when < 10 then '0' + cast( month(birth_date) as char(1)) + '/'  
             			--				else cast(month(birth_date) as char(2)) +'/' end  + 
                                        --                 case day(birth_date) when <10 then '0' + cast(day(birth_date) as char(1)) 
			--				else cast(day(birth_date) as char(2)) end
				--  convert(varchar(10), birth_date,111)
			--	from persons
			--	where  person_id =@person_id)
		end    	
	if @OBJ_attribt ='School'   
  	 	begin      
	                     set @rValue = ( select top 1 '(' + school_code +') '    + dbo.school(school_code,'Name')  
			                     from student_registrations    				
					where person_id = @person_id  and left(school_code,1) ='0' 
				          order by school_year DESC , status_indicator_code)
	              end    
	if @OBJ_attribt ='Address'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'All')
	              end    
	if @OBJ_attribt ='Address1'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'Street') + '  ' +  dbo.FindStudentAddress (@person_id ,'City') + '  ' +  dbo.FindStudentAddress (@person_id ,'Province') + '  ' +  dbo.FindStudentAddress (@person_id ,'Country')
	              end  
	if @OBJ_attribt ='AddressLine1'   
  	 	begin      
	           set @rValue =   dbo.FindStudentAddress (@person_id ,'Street') + 
	           case dbo.FindStudentAddress (@person_id ,'Unit') when '0000' then ''
	           else  ' ' + dbo.FindStudentAddress (@person_id ,'UnitType') +' ' +  dbo.FindStudentAddress (@person_id ,'Unit')  end
	           + ' ' + dbo.FindStudentAddress (@person_id ,'City') 
	     end      
	if @OBJ_attribt ='AddressLine2'   
  	 	begin      
	           set @rValue =  dbo.FindStudentAddress (@person_id ,'Province') + '  ' + dbo.FindStudentAddress (@person_id ,'PostCode') + ' ' +  dbo.FindStudentAddress (@person_id ,'Country')
	     end      
	if @OBJ_attribt ='Street'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'Street')
	              end    
	if @OBJ_attribt ='StreetName'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'StreetName')
	              end    

	if @OBJ_attribt ='StreetNo'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'StreetNo')
	              end    


	if @OBJ_attribt ='Unit'   
  	 	 begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'Unit')
	                     
	     end   
	if @OBJ_attribt ='Unit2'   
  	 	 begin      
	           set @rValue =  case dbo.FindStudentAddress (@person_id ,'Unit')
							  when '0000' then ''	
							  else dbo.FindStudentAddress (@person_id ,'UnitType') +' ' +  dbo.FindStudentAddress (@person_id ,'Unit')
							  end
	                     
	     end    
	      
	if @OBJ_attribt ='City'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'City')
	              end    
	if @OBJ_attribt ='PostCode'   
  	 	begin      
	                     set @rValue =  dbo.FindStudentAddress (@person_id ,'PostCode')
                                   if len(@rValue) =6  set @rValue = left(@rValue,3) + ' ' + right(@rValue,3)
                                       
	              end    
	if @OBJ_attribt ='Telephone'   
  	 	begin      
	                     set @rValue =  dbo.personphonenumber(@person_id,'Home')
		       set @rValue = isnull(@rValue, 'Non')        	      				 
	              end    
  	if @OBJ_attribt ='Telephone1'   
  	 	begin      
	                     set @rValue =  dbo.personphoneshort(@person_id,'Home')
		       set @rValue = isnull(@rValue, ' ')        	      				 
	              end      	 
	if @OBJ_attribt ='Parents'   
  	 	begin      
                                   set @rValue =  dbo.StudentParents(@Person_id, 'Full' )		 
                                   set @rValue = isnull(@rValue, ' ')        
	              end    
	if @OBJ_attribt ='Father'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =  dbo.personName(@ReleshipID, 'Full' )		 
                                    set @rValue = isnull(@rValue, ' ')        
	              end    
              if @OBJ_attribt ='FatherS'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =  dbo.personName(@ReleshipID, 'SurName' )		 
                                    set @rValue = isnull(@rValue, ' ')        
	              end    
               if @OBJ_attribt ='FatherF'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =  dbo.personName(@ReleshipID, 'PFirst' )		 
                                    set @rValue = isnull(@rValue, ' ')        
	              end    
             if @OBJ_attribt ='FatherPhone'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =  dbo.PersonPhoneshort(@ReleshipID,'Business')      				 
                                    set @rValue = isnull(@rValue, ' ')        
	              end    
               if @OBJ_attribt ='FatherPhoneB'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =  dbo.personphonenumber(@ReleshipID,'Business')      				 
                                    set @rValue = isnull(@rValue, ' ')        
	              end    
              if @OBJ_attribt ='MPRelationship'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')                                   
	                        set @rValue = ( select top 1 isnull(remark,' ')  from student_contacts where student_Person_id = @Person_id and relationship_type_name= 'Father')      				 
		          set @rValue = isnull(@rValue, ' ')        		
	              end    
             if @OBJ_attribt ='MPCellPhone'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Father')
	                      set @rValue =    dbo.PersonPhoneshort(@ReleshipID,'Cell')      				 
                                    set @rValue = isnull(@rValue, ' ')        
	              end       
		if @OBJ_attribt ='DearTitle'   
  	 	    begin 
      		         set @rValue =  'Parent / Guardian'  	 
	              end     

	if @OBJ_attribt ='Mother'   
  	 	begin      
	                      set @ReleshipID = dbo.personReleID(@person_id,'Mother')  
      		         set @rValue =  dbo.personName(@ReleshipID, 'Full') 		 
		          set @rValue = isnull(@rValue, ' ')        
	              end     
	if @OBJ_attribt ='MotherS'   
  	 	begin      
	                      set @ReleshipID = dbo.personReleID(@person_id,'Mother')  
      		         set @rValue =  dbo.personName(@ReleshipID, 'SurName') 		 
		          set @rValue = isnull(@rValue, ' ')        
	              end   
	if @OBJ_attribt ='MotherF'   
  	 	begin      
	                      set @ReleshipID = dbo.personReleID(@person_id,'Mother')  
      		         set @rValue =  dbo.personName(@ReleshipID, 'PFirst') 		 
		          set @rValue = isnull(@rValue, ' ')        
	              end   

	if @OBJ_attribt ='MotherPhone'   
  	 	begin      
	                      set @ReleshipID = dbo.personReleID(@person_id,'Mother')
	                      set @rValue =    dbo.PersonPhoneshort(@ReleshipID,'Business')      				 
		          set @rValue = isnull(@rValue, ' ')        
	              end    
	if @OBJ_attribt ='MotherPhoneB'   
  	 	begin      
	                      set @ReleshipID = dbo.personReleID(@person_id,'Mother')
	                      set @rValue =    dbo.personphonenumber(@ReleshipID,'Business')      				 
		          set @rValue = isnull(@rValue, ' ')        
	              end    
              if @OBJ_attribt ='FPRelationship'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Mother')                                   
	                        set @rValue = ( select top 1 isnull(remark,'Non')  from student_contacts where student_Person_id = @Person_id and relationship_type_name= 'Mother')      				 
		          set @rValue = isnull(@rValue, ' ')        		
	              end    
             if @OBJ_attribt ='FPCellPhone'   
  	 	begin      
                                   set @ReleshipID = dbo.personReleID(@person_id,'Mother')
	                      set @rValue =    dbo.PersonPhoneshort(@ReleshipID,'Cell')      				 
                                    set @rValue = isnull(@rValue, ' ')        
	              end       
   

	if @OBJ_attribt ='Doctor'   
  	 	begin      
                        set @ReleshipID = (select doctor_id from persons where person_id = @person_id)  -----dbo.personReleID(@person_id,'Doctor')  --eva au
		set @rDoctorname = (SELECT  top 1 rtrim( isnull(surname,' '))  + ', ' + left(isnull(first_name,' '),30)
				from fs_doctors where doctor_id = @ReleshipID and active_flag = 'x')  --eva au
		set @rDoctorphone = (SELECT  top 1+'('+tele_area_code+')'+left(tele_number,3)+'-'+right(tele_number,4)
				FROM  	fs_doctors 
        	       			 WHERE   doctor_id  = @ReleshipID and active_flag = 'x')  --eva au
		set @rValue = convert(char(30),@rDoctorname)+ ' '+@rDoctorphone  --eva au
		set @rValue = isnull(@rValue, ' ')        	 
	         end    


	if @OBJ_attribt ='DoctorName'   
  	 	begin     
		 set @ReleshipID = (select doctor_id from persons where person_id = @person_id)  -----dbo.personReleID(@person_id,'Doctor')  --eva au
		set @rValue = (SELECT  top 1 rtrim( isnull(surname,' '))  + ', ' + left(isnull(first_name,' '),30)
				from fs_doctors where doctor_id = @ReleshipID and active_flag = 'x')  --eva au 
                           set @rValue = isnull(@rValue, ' ')        	 
	        end    
	if @OBJ_attribt ='DoctorPhone'   
  	 	begin      
		set @ReleshipID = (select doctor_id from persons where person_id = @person_id)  -----dbo.personReleID(@person_id,'Doctor')  --eva au
		set @rValue = (SELECT  top 1+'('+tele_area_code+')'+left(tele_number,3)+'-'+right(tele_number,4)
				FROM  	fs_doctors 
        	       			 WHERE   doctor_id  = @ReleshipID and active_flag = 'x')  --eva au
                         set @rValue = isnull(@rValue, ' ')        	 
	        end    




    	if @OBJ_attribt ='Emergency'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleIDemerg(@person_id,'Emergency')
	                        set @rValue =  dbo.personName(@ReleshipID, 'Full' )		 
		          set @rValue = isnull(@rValue, ' ')        		 
	              end    
    	if @OBJ_attribt ='EmergencyS'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleIDemerg(@person_id,'Emergency')
	                        set @rValue =  dbo.personName(@ReleshipID, 'SurName' )		 
		          set @rValue = isnull(@rValue, ' '  )        		 
	              end    
    	if @OBJ_attribt ='EmergencyF'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleIDemerg(@person_id,'Emergency')
	                        set @rValue =  dbo.personName(@ReleshipID, 'PFirst' )		 
		          set @rValue = isnull(@rValue, '  ')        		 
	              end    
    	if @OBJ_attribt ='EmergencyPhone'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleIDemerg(@person_id,'Emergency')
	                       set @rValue =   dbo.PersonPhoneshort(@ReleshipID,'Business')      				 
		          set @rValue = isnull(@rValue, ' ')        		 
	              end  
---
		if @OBJ_attribt ='EmergencyPhonehome'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleIDemerg(@person_id,'Emergency')
	                       set @rValue =   dbo.PersonPhoneshort(@ReleshipID,'Home')      				 
		          set @rValue = isnull(@rValue, ' ')        		 
	              end  
---
  
    	if @OBJ_attribt ='EmergencyRelationship'   
  	 	begin      
	                        set @ReleshipID = dbo.personReleID(@person_id,'Emergency')                                   
	                        set @rValue = ( select top 1 isnull(remark,'Unfind')  from student_contacts  where student_Person_id = @Person_id and relationship_type_name= 'Emergency')      				 
		          set @rValue = isnull(@rValue, ' ')        		 
	              end    
    	if @OBJ_attribt ='EmergencyCellPhone'   
  	 	begin      
	                       set @ReleshipID = dbo.personReleID(@person_id,'Emergency')
	                       set @rValue =   dbo.PersonPhoneshort(@ReleshipID,'Cell')                                   
		          set @rValue = isnull(@rValue, ' ')        		 
	              end    
	if @OBJ_attribt ='Homeroom'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='P'  
 				order by SP.start_date DESC)   
                              
                           set @rValue = isnull(@rValue, ' ')        
    	        end
                if @OBJ_attribt ='HomeroomNo'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.room_no,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='P' 
 				order by SP.start_date DESC )   
                              
                           set @rValue = isnull(@rValue, ' ')        
    	        end
	if @OBJ_attribt ='Homeroomclass'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =SC.school_year and SP.school_code =SC.school_code and SP.class_code =SC.class_code
			                             and SP.person_id  = @person_id   -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		where   SC.school_code = @school_code and  SC.school_year  = @school_year  and SC.class_homeroom_flag ='p' 
				order by SP.start_date DESC	)

                              
                           set @rValue = isnull(@rValue, ' ')        
    	        end
	if @OBJ_attribt ='ClassName'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.full_name,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =@school_year and  SP.school_code =SC.school_code and SP.class_code =SC.class_code  
				          and SP.person_id  = @person_id   --- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='p'  )   
                              
                           set @rValue = isnull(@rValue, ' ')        
    	        end

             if @OBJ_attribt ='HealthCardNo'
	       begin
                      	select @rValue  =  health_card_no from persons  where person_id = @person_ID
                       	set @rValue = isnull(@rValue, ' ')
                    end
             if @OBJ_attribt ='CountryofBirth'
	       begin
                    	select @rValue  =  birth_country_name from persons  where person_id = @person_ID
                       	set @rValue = isnull(@rValue, ' ')
                    end
             if @OBJ_attribt ='DateofArrival'
	       begin
                     	select @rValue  =  convert(varchar(10),arrival_date_in_canada ,111)   from persons  where person_id = @person_ID
                       	set @rValue = isnull(@rValue, ' ')
                    end

             if @OBJ_attribt ='MedicalName'
	       begin
                   --	select  top 1 @rValue  =  substring(remark,1,32) from person_medical_details  where person_id = @person_ID modify by Frank 2011/04/18
                  	select  top 1 @rValue  =  remark  from person_medical_details  where person_id = @person_ID
                      	set @rValue = isnull(@rValue, ' ')
                      
                    end             
             if @OBJ_attribt ='Language-of-Home'
	       begin
                      	select  top 1@rValue  = language_name   from person_languages  where person_id = @person_ID   and  spoken_at_home_flag = 'x'  
                       	set @rValue = isnull(@rValue, ' ')
                    end             
            if @OBJ_attribt ='LanguageofLegalDoc'
	       begin
                      	select  top 1 @rValue  = language_of_legal_documents   from persons  where person_id = @person_ID    
                       	set @rValue = isnull(@rValue, ' ')
                    end   


            if @OBJ_attribt ='ProgramName'
	       begin
                      	select top 1@rValue  =   program_name from student_programs   where person_id = @person_ID  and main_program_flag = 'x'
                       	set @rValue = isnull(@rValue, ' ')
                    end              

            if @OBJ_attribt ='SchoolyearTrack'
	       begin
		select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
                            set @rValue =  ( select  top 1  case school_year_track 
						when 'AM' then 'A' 
						when 'PM' then 'P' 
						ELSE 'D' end  as Track1
                                                           from student_registrations  where person_id =   @person_ID  and school_year =@school_year )
                       	set @rValue = isnull(@rValue, 'Non')
                    end       
           if @OBJ_attribt ='ReadingTestDate'
	       begin	 
                            set @rdate  =  ( select  top 1   isnull(Literacy_test_date, 'Non')  from persons  where person_id =  @person_ID )
                       	 set @rValue = cast(@rdate as varchar(10)) 
                    end       
           if @OBJ_attribt = 'Credit'     	
                     begin
                      
	                      set @CreditT  =  dbo.StudentCredit(@Person_id ,'Credit' )  
                          set @rValue = cast(@CreditT as varchar(8))
--
--							(SELECT  sum(isnull(earned_credit_value,0)) 
--			                FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
--        	                                         WHERE   person_id   = 	@person_id ) -- and  
--				           --      school_code = 	@school_code and 
--				           --       school_year =	@school_year   	   )

                      end
       if @OBJ_attribt = 'HaveIEP'     	
                     begin
	                set @CreditT  = (SELECT  count(*)  from tcdsb_iep_registration 
			            
        	                                         WHERE   person_id   = 	@person_id )  -- and  
				           --      school_code = 	@school_code and  
				          --          school_year =	@school_year   	   )
                            if @CreditT >0 
                                   set @rValue = '1'
                             else
                                  set  @rValue ='2'

                      end
      if @OBJ_attribt = 'TeacherName'     	
                     begin
	 	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.reporting_teacher,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =@school_year and  SP.school_code =SC.school_code and SP.class_code =SC.class_code  
				          and SP.person_id  = @person_id  and @School_date between start_date and end_date   --- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='p'  )   
                           set @rValue  = dbo.PersonName (@rValue,'Full')                          
                           set @rValue = isnull(@rValue, ' ')        

                      end
   

     if @OBJ_attribt = 'Cetificate'  
        begin     	
            set @rValue = ( Select top 1  case award when 'OSSD' then 1
		              when 'OSSC' then 2
			 when 'COA'  then 3
			 when 'SSHGD' then 4
			 when 'SSGD' then 4
			 when 'OS'  then 4
			 when 'COE' then 4
			 when 'BUS' then 4
 			 else 4 end  
			from fs_student_awards
			where person_id =@Person_id and current_diploma_flag ='x'
			order by last_update_date_time DESC )
              set @rValue = isnull(@rValue,' ')
        end  

       RETURN(@rValue)
  END



 














