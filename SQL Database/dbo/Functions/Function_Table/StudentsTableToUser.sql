


CREATE FUNCTION dbo.StudentsTableToUser (@School_Code char(4),@SchoolYear char(8),@UserID varchar(20))
RETURNS @StudentToUserTable table (StudentID varchar(13), ClassID varchar(20) )
AS 
BEGIN
  --  declare @StudentToUserTable  table
if @UserID is null  set @userID =dbo.userid()
  declare @StaffID  varchar(30)
  declare @StaffPosition varchar(30)
  declare @Schoolcode varchar(4)
if @School_code ='All' 
     set @schoolcode =(select School_code from tcdsb_trillium_companion where user_id = @UserID)
else
    set @Schoolcode =@School_code

  set @StaffID =dbo.UserProfile(@UserID,'StaffID','',@schoolcode,@schoolyear ) 
  set @StaffPosition = dbo.UserProfile(@UserID,'StaffPosition',@StaffID,@schoolcode,@schoolyear) 



 if  @StaffPosition  in ('Teacher','Instruct','TA')
      begin 
        INSERT @StudentToUserTable  
	SELECT   Distinct S.Person_id, S.class_code  
             From student_program_class_tracks  as S
------------- inner join term_teachers	   as T                  on S.school_code = T.school_code
--						and S.school_year = T.school_year
--						and S.School_year_track = T.school_year_track
--						and S.class_code = T.class_code
 --      	where T.school_code =@Schoolcode and T.school_year=@schoolYear and Tperson_id  =@StaffID
--
       	inner join  School_classes    as T                  on S.school_code = T.school_code
						and S.school_year = T.school_year
						--and S.School_year_track = T.school_year_track
						and S.class_code = T.class_code
       	where T.school_code =@Schoolcode and T.school_year=@schoolYear and T.reporting_teacher  =@StaffID
      end
   if @StaffPosition in ('Principal','Secretary','Other')
      begin 
               INSERT @StudentToUserTable 
	SELECT  Distinct Person_id, 'All'  
              From student_registrations  ---as 
       	where school_code =@Schoolcode and school_year = @schoolYear 
      end
   if @StaffPosition in ('APTTeacher','Superintendent','TechSupport','Board')
      begin 
            if @school_code ='All'
                begin
                      INSERT @StudentToUserTable  
                      SELECT  Distinct Person_id, 'All'  
                      From student_registrations  -- program_class_tracks  as S
       	        where school_year=@schoolYear and school_code in (select distinct school_code from tcdsbvsecurity_list) 
                end
           else
               begin
                      INSERT @StudentToUserTable  
                      SELECT  Distinct Person_id, 'All'  
                      From student_registrations  -- program_class_tracks  as S
       	        where school_year=@schoolYear and school_code  =@schoolcode
                end
      end         
  RETURN 
END
















