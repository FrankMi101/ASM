


CREATE FUNCTION dbo.SecurityControlTable (
@PersonID  varchar(30),
@UserLevel varchar(20),
@SchoolYear varchar(8),
@Schoolcode varchar(4) = null ,
@ClassCode  Varchar(10) = null,
@CourseCode Varchar(6) = null 
)
RETURNS @StudentToUserTable table (School_code varchar(4),Course_code varchar(10),Person_ID varchar(13))
AS 
BEGIN
     if @schoolCode is null  set @schoolcode = (select top 1 school_code from school_staff where person_id = @PersonID)
  --  declare @StudentToUserTable  table
   if @UserLevel ='Student'
      begin 
       --  set @PersonID = dbo.Student(@userID,'PersonID')  
        INSERT @StudentToUserTable  
	SELECT   Distinct @schoolCode,Class_code,@PersonID   
        From student_program_class_tracks  
        Where school_code =@Schoolcode and School_year =@schoolyear and person_id =@PersonID
      end
   if @UserLevel = 'CourseTeacher'
      begin
           if @CourseCode is null
              begin
                    INSERT @StudentToUserTable  
	       SELECT   Distinct @schoolCode, SPCT.Class_Code, SPCT.Person_ID   
                    From student_program_class_tracks    as  SPCT
                    inner join school_classes   as SC  on SPCT.school_year =SC.school_year and SPCT.school_code = SC.school_code 
		 			and SPCT.class_code =SC.class_code and SC.reporting_teacher = @PersonID
                    Where SC.school_code =@Schoolcode and SC.School_year =@schoolyear                      
              end
           else    
                    INSERT @StudentToUserTable  
	       SELECT   Distinct @schoolCode, Class_Code,Person_ID   
                    From student_program_class_tracks  
                    Where school_code =@Schoolcode and School_year =@schoolyear and Course_code = @CourseCode
      end          

   if @UserLevel = 'ClassTeacher'
      begin
          if @ClassCode is null 
                begin
                    INSERT @StudentToUserTable  
	       SELECT   Distinct @schoolCode, SPCT.Class_Code, SPCT.Person_ID   
                    From student_program_class_tracks    as  SPCT
                    inner join school_classes   as SC  on SPCT.school_year =SC.school_year and SPCT.school_code = SC.school_code 
		 			and SPCT.class_code =SC.class_code and SC.reporting_teacher = @PersonID
                    Where SC.school_code =@Schoolcode and SC.School_year =@schoolyear         
               end
           else
               INSERT @StudentToUserTable  
	  SELECT   Distinct @schoolCode,class_Code,Person_ID   
              From student_program_class_tracks  as S
              Where school_code =@Schoolcode and School_year =@schoolyear and Class_code = @ClassCode
      end   
   if @UserLevel ='APTTeacher' 
     begin 
           INSERT @StudentToUserTable 
           SELECT  Distinct school_Code,' ',' '  
           From student_Registrations  
          Where school_year= @schoolYear  and school_code  in  (select school_code  from  tcdsb_Security_list )
      end

   if @UserLevel ='Secretory' 
      begin 
        INSERT @StudentToUserTable 
	SELECT  Distinct @schoolCode,Grade,Person_ID  
        From student_Registrations 
       	where school_code =@Schoolcode and school_year= @schoolYear 
      end
  if @UserLevel ='Principal' 
      begin 
        INSERT @StudentToUserTable 
	SELECT  Distinct @schoolCode,Grade,Person_ID  
        From student_Registrations 
       	where school_code =@Schoolcode and school_year= @schoolYear 
      end
 if @UserLevel ='Superintendent' 
     begin 
        INSERT @StudentToUserTable 
	SELECT  Distinct school_Code,' ',' '  
        From student_Registrations  
       	where school_year= @schoolYear  and  school_code  in  (select school_code  from  tcdsb_Security_list )
      end
  if @UserLevel ='Tech Support'
      begin 
        INSERT @StudentToUserTable 
	SELECT  Distinct school_Code,' ',' '  
        From student_Registrations  
       	where school_year= @schoolYear  and  school_code  in  (select school_code  from  tcdsb_Security_list )
      end   
  RETURN 
END




