
 


 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.Class] (@Person_id char(13),@OBJ_attribt char(30) )  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
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
 	
	if @OBJ_attribt ='School'   
  	 	begin      
	                     set @rValue = ( select top 1 '(' + school_code +') '    + dbo.school(school_code,'Name')  
			                     from student_registrations    				
					where person_id = @person_id  and left(school_code,1) ='0' 
				          order by school_year DESC , status_indicator_code)
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



 














