				
-- drop function dbo.studentAchievement
CREATE FUNCTION [dbo].[Student.CreditByCourse] 
(@OBJ_attribt char(30),
 @schoolYear varchar(8), 
 @PersonID varchar(13),
 @CourseCode varchar(10),
 @CourceSection varchar(4) 
  )  
RETURNS varchar(8)
--- Frank Mi
--- Febuary 10, 2016
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
      declare @rValue varchar(8)
      declare @CreditT   numeric(6,2)
      declare @CreditTnew numeric (8,2)
      declare @Grade  varchar(2)               
      if @OBJ_attribt = 'CreditEarned'
                 set @CreditT  =(SELECT  sum(isnull(earned_credit_value,0))
								FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
        	                        WHERE  school_year = @SchoolYear and  person_id  = @PersonID and Course_code = @CourseCode and Course_section = @CourceSection )  
 
      else if @OBJ_attribt = 'CreditAttempted'
                 set @CreditT  =(SELECT  sum(isnull(attempted_credit_value,0))
								FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
        	                        WHERE  school_year = @SchoolYear and  person_id  = @PersonID and Course_code = @CourseCode and Course_section = @CourceSection )  
      else if @OBJ_attribt = 'CreditComplusory'
                 set @CreditT  =(SELECT  sum(isnull(complusory_credit_value,0))
								FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
        	                        WHERE  school_year = @SchoolYear and  person_id  = @PersonID and Course_code = @CourseCode and Course_section = @CourceSection )  
      else

           set @CreditT  =(SELECT  sum(isnull(complusory_credit_value,0))
								FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
        	                        WHERE  school_year = @SchoolYear and  person_id  = @PersonID and Course_code = @CourseCode and Course_section = @CourceSection )  
 
       set @rValue = cast(@CreditT as varchar(8))
    
	    RETURN(@rValue)
	End