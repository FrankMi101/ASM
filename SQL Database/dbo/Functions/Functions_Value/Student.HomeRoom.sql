





 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.HomeRoom] (@Person_id varchar(13) ,@Schoolyear varchar(8), @SchoolCode varchar(8), @HomeType varchar(10) )  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
 
	if @HomeType =''   
    
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') --  + ' at ' + isnull(SC.room_no,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@schoolyear
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @schoolcode and  SC.school_year  = @schoolyear and  SC.Class_homeroom_flag ='P'  
 				order by SP.start_date DESC)   
                              
        
  if @HomeType ='No'   
 	  	set @rValue = (select top 1  isnull(SC.room_no,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on SP.Person_id = @person_id  and SP.school_year =@schoolyear
			                           and SP.class_code =SC.class_code  -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		WHERE SC.school_code = @schoolcode and  SC.school_year  = @schoolyear and  SC.Class_homeroom_flag ='P' 
 				order by SP.start_date DESC )   
  
	if @HomeType ='class'   
 
	  	set @rValue = (select top 1  isnull(SC.class_code,' ') 
                         			 From school_classes   			as SC 
                          			inner join student_program_class_tracks  as SP  on  SP.school_year =SC.school_year and SP.school_code =SC.school_code and SP.class_code =SC.class_code
			                             and SP.person_id  = @person_id   -- and SP.start_date <=@school_date and SP.end_date >= @school_date 
 	  	 		where   SC.school_code = @schoolcode and  SC.school_year  = @schoolyear  and SC.class_homeroom_flag ='p' 
				order by SP.start_date DESC	)

                              
                           set @rValue = isnull(@rValue, ' ')        
 

       RETURN(@rValue)
  END



 













