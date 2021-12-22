




-- =================================================================================
-- Author:		Frank Mi
-- Create date: May  18, 2018    
-- Description:	to get Student EQAO informatino 
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.EQAO] 
	(@StudentNo varchar(9), 
	 @SchoolYear varchar(8), 
	 @Grade		varchar(1),
	 @Attr varchar(30) 
	 )  
RETURNS varchar(50)
--- Frank Mi
--- March 24 2016
--- @perason_id   
AS  
   BEGIN
        declare @rValue varchar(50)
 
			if exists(select * from dbo.tcdsb_res_eqao_elem_students where Grade = @Grade and Student_no = @StudentNo)
				begin
					   select top 1 @rValue = Case @Attr when 'Reading' then Overall_R
														 when 'Writing' then Overall_W
														 when 'Math'	 then Overall_M else '' end
						from dbo.tcdsb_res_eqao_elem_students where Grade = @Grade and Student_no = @StudentNo order by School_year DESC
				end
			else
				set @rValue =''
 
       RETURN(@rValue)
  END

