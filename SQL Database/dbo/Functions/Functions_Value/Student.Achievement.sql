


-- drop function dbo.studentAchievement
CREATE FUNCTION [dbo].[Student.Achievement] (@Person_id varchar(13), @school_Year varchar(8), @OBJ_attribt char(30) )  
RETURNS varchar(100)
--- Frank Mi
--- March 14, 2002
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
      declare @rValue varchar(100)
      declare @CreditT   numeric(6,2)
      declare @CreditTnew numeric (8,2)
      declare @Grade  varchar(2) 
      set @Grade = (select top 1 grade from student_registrations
                    where person_id =@person_ID and school_year =@school_year and left(school_code,1)='0')              
      if @OBJ_attribt = 'Credit'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(isnull(earned_credit_value,0))FROM  fs_secondary_course_credit -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id and credit_to_print <> 'R' ) -- Check "Credit to Print" changed by Eva Au 2013-11-29  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   
      if (@OBJ_attribt = 'Absent' or @OBJ_attribt = 'DAbsent' or @OBJ_attribt = 'TAbsent' )
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                ---set @CreditT  =( select count(distinct A.calendar_date) from dbo.period_attendance  as A
                                 --       inner join school_calendar  as C  on A.School_code =C.school_code and
			---	                                            A.School_year= C.school_year and 
			---	                                            A.calendar_date =C.calendar_date and take_attendance_flag ='x'
				---         where A.school_year =@school_year and A.person_id =@person_id and A.attendance_code ='A' 
				---	and A.school_period not in ('TA','OE','Lunch'))

		set @CreditTnew = (select count ( *) from ministry_reported_attendance where person_id =@person_id
		and school_year =@school_year ----and school_code ='0521' 
		and ( reporting_type ='A' or reporting_type ='-' ) )
				
		set @CreditTnew = @CreditTnew / 2
                    ---set @rValue = cast(@CreditT as varchar(8))
	         set @rValue = @CreditTnew
                  end
              else
                 set @rValue =' '   
         end   
      if @OBJ_attribt = 'DAbsentold'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(isnull(absences,0))FROM  fs_secondary_achieve  -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id ) -- and  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   
    if @OBJ_attribt = 'TAbsentold'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(isnull(absences,0))FROM  fs_secondary_achieve  -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id ) -- and  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   
      if (@OBJ_attribt = 'Late' or @OBJ_attribt = 'DLate'  or @OBJ_attribt = 'TLate' )
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	               -- set @CreditT  = (select count(distinct A.calendar_date) from dbo.period_attendance  as A
                                    --    inner join school_calendar  as C  on A.School_code =C.school_code and
			--	                                            A.School_year= C.school_year and 
			--	                                            A.calendar_date =C.calendar_date and take_attendance_flag ='x'
			--	         where A.school_year =@school_year and A.person_id =@person_id and A.attendance_code ='L' 
				--	and A.school_period not in ('TA','OE','Lunch')) 

		set @CreditT = (select count ( *) from ministry_reported_attendance where person_id =@person_id
		and school_year =@school_year ----and school_code ='0521' 
		and ( reporting_type ='L'  ) )

                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   
    if @OBJ_attribt = 'DLateold'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(isnull(lates,0))FROM  fs_secondary_achieve -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id ) -- and  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue = ' '   
         end   
  if @OBJ_attribt = 'TLateold'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(isnull(lates,0))FROM  fs_secondary_achieve -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id ) -- and  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   
      if @OBJ_attribt = 'CommunityHours'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	                set @CreditT  =(SELECT  sum(community_hours)FROM  fs_secondary_achieve -- 	fs_secondary_course_achieve
        	                        WHERE   person_id   = 	@person_id ) -- and  
                        set @rValue = cast(@CreditT as varchar(8))
                  end
              else
                 set @rValue =' '   
         end   

      if @OBJ_attribt = 'Attend'
         begin      
              if @Grade in ('09','10','11','12','13')         	
                  begin
	        --        set CreditT  =(SELECT  count(distinct calendar_date) from period_attendance
        	--                        WHERE   person_id   = 	@person_id and school_year = @school_year and attendance_code ='A') -- and  
               --         set @rValue = cast(@CreditT as varchar(8))
		     set @rValue =''   
                  end
              else
                   set @rValue =' '   
         end   
     set @rValue= isnull(@rValue,'')

       RETURN(@rValue)
  END



