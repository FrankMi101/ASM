

 
--- drop function  dbo.[Student.ClassWD]

CREATE  FUNCTION [dbo].[Student.ClassWD](@Person_id varchar(13),@School_year varchar(8),@OBJ char(30) )  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
             declare @ReleshipID varchar(13)
			declare @school_code char(4)  
             set @school_code = (select top 1 school_code
			 from student_registrations
			 where person_id = @person_id and school_year =@school_year and left(school_code,1) ='0'
		         order by arrival_date  desc  )
             if @school_code is null
                    set @school_code = (select top 1 school_code
			 from student_registrations
			 where person_id = @person_id and school_year =@school_year  
		         order by arrival_date  desc  )
          
if @OBJ ='RegistDate' 
           set @rValue = (select top 1 dbo.DateF(arrival_date,'YYYYMMDD')
                          from student_registrations where person_id = @Person_id and school_year= @School_year
						 order by  arrival_date DESC)

if @OBJ  ='SchoolCode'    
		begin
            set @rValue = isnull(@rValue, 'Non ')        
            set @rValue = @school_code    
		end                        
if @OBJ  ='Status'   
          begin      
 		 set @rValue = (select top 1 status_indicator_code
		  from student_registrations
		  where person_id = @person_id and school_year =@school_year and school_code =@school_code
		  order by arrival_date  desc)
          end


if @OBJ ='Homeroom'   
  	      begin      
            
 
	  	         set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='P'  
 				order by SP.start_date DESC)   
                              
                           set @rValue = isnull(@rValue, ' ')        
    	  end
if @OBJ='HomeroomNo'   
  	         begin      
	  			set @rValue = (select top 1  isnull(SC.room_no,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='P' 
 				order by SP.start_date DESC )   
                              
                           set @rValue = isnull(@rValue, ' ')        
    	   end
 if @OBJ  ='Homeroomclass'   
         begin      
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =SC.school_year and SP.school_code =SC.school_code and SP.class_code =SC.class_code
			                             and SP.person_id  = @person_id   -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		where   SC.school_code = @school_code and  SC.school_year  = @school_year  and SC.class_homeroom_flag ='p' )
                             
                           set @rValue = isnull(@rValue, 'Non')        
        end
if @OBJ  ='ClassName'   
         begin      
	  	set @rValue = (select top 1  isnull(SC.full_name,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =@school_year and  SP.school_code =SC.school_code and SP.class_code =SC.class_code  
				          and SP.person_id  = @person_id   --- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year and  SC.Class_homeroom_flag ='p'  )   
                              
                           set @rValue = isnull(@rValue, 'Non')        
    	        end

if @OBJ  ='SchoolyearTrack'
       begin
                set @rValue =  ( select  top 1  case school_year_track 
			when 'AM' then 'A' 
			when 'PM' then 'P' 
 			ELSE 'D' end  as Track1
                        from student_registrations  
		        where person_id = @person_ID  and school_year =@school_year )
                       	set @rValue = isnull(@rValue, 'Non')
                    end       
if @OBJ  ='ImmunizationRecord'
       begin
                set @rValue =  ( select  top 1   case immunization_received_flag when 'x' then '-1' else '0' end
                                                   from student_registrations   where school_year = @School_year  and person_id =@person_id )
 
        end


if @OBJ  ='TriESL'
       begin
                set @rValue =  ( select  top 1  left(class_code,4)  
					from student_program_class_tracks 
				where school_year =@school_year and class_code like ('%ES%') and person_id =@Person_id )

        end

if @OBJ =  'Cetificate'  
        begin     
		   if exists (select * from  tcdsb_ses_students  where school_year = @School_year and person_id =@Person_id and grade > '08' and grade <'14')
				set @rValue = ( Select top 1  
							case award	when 'OSSD' then 1
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
			else
				set @rValue = 4
         end  



 set  @rValue = isnull(@rValue,' ' )   
       RETURN(@rValue)
  END





