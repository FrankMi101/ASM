






-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student CAT4 Information 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.CAT4] 
	(@StudentNo varchar(9), 
	 @SchoolYear varchar(8), 
	 @Grade		 varchar(2), 
	 @Attr varchar(30) 
	 )  
RETURNS varchar(50)
 
AS  
   BEGIN
            declare @rValue varchar(50)

         if exists ( select  * 	from  [dbo].[tcdsb_res_cat3_students] 	where  Student_no = @StudentNo and Grade = @Grade)  
 		      set  @rValue = ( select top 1 Case @Attr when 'Reading'  then reading_national_stanine
										when 'Math'		then mathematics_national_stanine
										when 'Language'	then language_national_stanine
										else ''end
								from [dbo].[tcdsb_res_cat3_students] 	where  Student_no = @StudentNo and Grade = @Grade
								order by school_year DESC
								)
         else
			set @rValue =''	
       RETURN(@rValue)
  END

   

