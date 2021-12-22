



-- =================================================================================
-- Author:		Frank Mi
-- Create date: Feburay 17, 2021 
-- Description:	get Trillium School date 
-- ===================================================================================
  
CREATE FUNCTION [dbo].[School.Date] (@schoolCode char(4), @Schoolyear char(8), @DateType varchar(10))
RETURNS smalldatetime 
 
AS  
BEGIN 
    
   
     declare @rValue       	smalldatetime
	 if exists(select * from school_years where school_code = @schoolcode and school_year = @schoolyear)
		set @rValue = ( select top 1 case @Datetype when 'Start'	then [start_date] 
													when 'End'		then [end_date]		end
								from school_years where school_code =@schoolcode and school_year =@schoolyear )
	 else
		set @rValue =null --'1900/01/01'
  
 
       RETURN @rValue   
end




