


CREATE function [dbo].[Student.GradeShow](@PersonID varchar(13),@SchoolYear varchar(8))
returns Varchar(4)
 as 
   begin
	   declare @rValue  varchar(4) 
       set @rValue = ( select top 1 grade  from student_registrations
						where person_id = @PersonID 	and school_year = @SchoolYear  and left(school_code,1) in ('0','A') 
						 order by status_indicator_code  )
       if @rValue ='12'
	      begin
			 declare @GYears int = [dbo].[Student.Grade12Years](@PersonID,@SchoolYear,'12')
			 if  @GYears > 1  set @rValue = '12~' +   Cast(@GYears as char(1))  
		  end
 
       set @rValue = isnull(@rValue, '  ')
      return @rValue
  end




