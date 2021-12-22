
-- =========================================================================
-- Author:		Frank Mi
-- Create date: June 11, 2020   
-- Description: get week day name
-- =========================================================================

CREATE FUNCTION [dbo].[Date.Week](@vDate datetime, @vType varchar(20))
RETURNS varchar(15) 
AS  
BEGIN 
declare @vYY varchar(4)
declare @vMM Varchar(2)
declare @vMMM Varchar(5)
declare @vDD varchar(2)
declare @rValue varchar(15)
if @vDate is not null
    begin 
		  if @vType = 'WeekDay'
             set @rValue=  datepart(dw, @vDate)                 
      else if @vType = 'L'
             set @rValue= case datepart(dw, @vDate)            
    			when 1 then 'Sunday'
  			when 2 then 'Monday'
  			when 3 then 'Tuesday'
  			when 4 then 'Wednesday'
  			when 5 then 'Thursday'
  			when 6 then 'Friday'
  			when 7 then 'Saturday'
 			else  'No' end
 	else if @vType = 'S'
             set @rValue= case datepart(dw, @vDate)            
    			when 1 then 'Sun'
  			when 2 then 'Mon'
  			when 3 then 'Tue'
  			when 4 then 'Wed'
  			when 5 then 'Thu'
  			when 6 then 'Fri'
  			when 7 then 'Sat'
 			else  'No' end
	else if @vType = 'S3'
             set @rValue= case datepart(dw, @vDate)            
    			when 1 then 'Sun'
  			when 2 then 'Mo'
  			when 3 then 'Tue'
  			when 4 then 'We'
  			when 5 then 'Thu'
  			when 6 then 'Fri'
  			when 7 then 'Sat'
 			else  'No' end
  	else if @vType = 'S2'
             set @rValue= case datepart(dw, @vDate)            
    			when 1 then 'Su'
  			when 2 then 'M'
  			when 3 then 'Tu'
  			when 4 then 'W'
  			when 5 then 'Th'
  			when 6 then 'Fr'
  			when 7 then 'Sa'
 			else  'No' end

    end
else
    set @rValue =''
 
  return @rValue
end






