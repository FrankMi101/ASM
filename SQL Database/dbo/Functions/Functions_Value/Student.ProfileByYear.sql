








 -- drop function dbo.student

CREATE FUNCTION [dbo].[Student.ProfileByYear] (@Person_id char(13),@SchoolYear varchar(8), @OBJ_attribt char(30) )  
RETURNS varchar(100)
--- Frank Mi
--- May 11, 2017
--- @perason_id  
--- @OBJ_attribt   Student  Object's attribt  one of 'Number'/'Name'/Grade'/'Gender'/'Telephone'/'Parents'/ .....
AS  
   BEGIN
             declare @rValue varchar(100)
  
	if @OBJ_attribt ='SchoolCode'
     	--	declare @rValue varchar(2)
  	 	begin set @rValue =  ( select top 1 school_code from student_registrations
				          where person_id = @person_id  and left(school_code,1) ='0'  and school_year = @SchoolYear
				          order by school_year DESC , status_indicator_code  )	 	 
                          end
   	
	if @OBJ_attribt ='School'   
  	 	   begin      
	                     set @rValue = ( select top 1 '(' + school_code +') '    + dbo.school(school_code,'Name')  
			                     from student_registrations    				
					where person_id = @person_id  and left(school_code,1) ='0'  and school_year = @SchoolYear
				          order by school_year DESC , status_indicator_code)
	              end    
	if @OBJ_attribt ='Status'   
  	 	   begin      
	              set @rValue = ( select top 1  status_indicator_code
			                     from student_registrations    				
							where person_id = @person_id  and left(school_code,1) ='0'  and school_year = @SchoolYear
				          order by school_year DESC , status_indicator_code)
	              end       
	 
     if @OBJ_attribt = 'Cetificate'  
        begin  
		    if exists(select * from fs_student_awards where person_id =@Person_id and current_diploma_flag ='x'  and school_year =@schoolYear)
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
								where person_id =@Person_id and current_diploma_flag ='x'  and school_year =@schoolYear
								order by last_update_date_time DESC )
			else if exists (select * from fs_student_awards where person_id =@Person_id and current_diploma_flag ='x')
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
            else
				set @rValue = isnull(@rValue,' ')
        end  

       RETURN(@rValue)
  END



 

















