


CREATE FUNCTION [dbo].[Staff] (@Person_id char(13),@OBJ_attribt char(30) )  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
             declare @ReleshipID varchar(13)
             declare @rDate    smalldatetime
	declare @school_year varchar(8)
	declare @school_code varchar(4)
              declare @school_date smalldatetime
              declare @PFirstName  varchar(20)
              declare @LFirstName   varchar(20)  
     	if @OBJ_attribt ='Number'
   	 	 set @rValue = dbo.FindStaffNo(@person_id)
	if @OBJ_attribt ='Name'
  		 set @rValue = dbo.FindStaffName (@person_id)  
 	if @OBJ_attribt ='SchoolCode'
  	 	 set @rValue = (select top 1 school_code from school_staff  where person_id = @person_id     )	 	  
	if @OBJ_attribt ='BirthDate' 
		set @rValue = ( select top 1 convert(varchar(10), birth_date,111) from persons 	where  person_id =@person_id)
	if @OBJ_attribt ='School'   
	           set @rValue = ( select top 1 '(' + school_code +') '+ dbo.schoolname(school_code,'Name') from school_staff 	where  person_id =@person_id)
	if @OBJ_attribt ='Role'   
	           set @rValue = ( select top 1   staff_type_name     from school_staff 	where  person_id =@person_id)               
	if @OBJ_attribt ='Address'   
                   set @rValue =  dbo.FindStudentAddress (@person_id ,'All')   
	if @OBJ_attribt ='Street'   
                   set @rValue =  dbo.FindStudentAddress (@person_id ,'Street')
	if @OBJ_attribt ='Unit'   
                   set @rValue =  dbo.FindStudentAddress (@person_id ,'Unit')
	if @OBJ_attribt ='City'   
                   set @rValue =  dbo.FindStudentAddress (@person_id ,'City')
	if @OBJ_attribt ='PostCode'   
                   set @rValue =  dbo.FindStudentAddress (@person_id ,'PostCode')
	if @OBJ_attribt ='Telephone'   
               begin  
                  set @rValue =  dbo.personphonenumber(@person_id,'Home')
		  set @rValue = isnull(@rValue, 'Non')        	      				 
	       end    
	if @OBJ_attribt ='Homeroom'   
  	    begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.school_code  = SC.school_code  and SP.school_year =SC.school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year  and
					 SC.reporting_teacher = @person_id and  SC.Class_homeroom_flag ='P'  )   
                              
                           set @rValue = isnull(@rValue, 'Non')        
    	        end
                if @OBJ_attribt ='HomeroomNo'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.room_no,' ') 
                         			 From school_classes   	as SC 
                           			inner join student_program_class_tracks  as SP  on SP.school_code  = SC.school_code  and SP.school_year = SC.school_year
			                           and SP.class_code = SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	   	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year  and
					 SC.reporting_teacher = @person_id  and  SC.Class_homeroom_flag ='P'  )   
                             
                           set @rValue = isnull(@rValue, 'Non')        
    	        end
	if @OBJ_attribt ='Homeroomclass'   
  	         begin      
               	select  	@school_code  = school_code, 
                    		@school_year = school_year, 
                    		@school_date = cast(school_date as smalldatetime)  
	        	from tcdsb_trillium_companion Where user_id =dbo.UserID()  
 
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                         			inner join student_program_class_tracks  as SP  on SP.school_code  = SC.school_code  and SP.school_year =SC.school_year
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @school_code and  SC.school_year  = @school_year  and
					 SC.reporting_teacher = @person_id and  SC.Class_homeroom_flag ='P'  )   

                              
                           set @rValue = isnull(@rValue, 'Non')        
    	        end
	    
       RETURN(@rValue)
  END
































































