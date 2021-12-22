

-- =========================================================================
-- Author:		Frank Mi
-- Create date: June 11, 2020   
-- Description: get month   name
-- =========================================================================
 

CREATE FUNCTION [dbo].[Date.Month](@vDate datetime, @vType varchar(20))
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
			 if @vType ='Month'  
				set @rValue= case month(@vDate)            
  				when 1 then 'Jan'
  				when 2 then 'Feb'
  				when 3 then 'March'
  				when 4 then 'Apr'
  				when 5 then 'May'
  				when 6 then 'June'
  				when 7 then 'July'
  				when 8 then 'Aug'
  				when 9 then 'Sept'
  				when 10 then 'Oct'
  				when 11 then 'Nov'
  				when 12 then 'Dec'
							else   'No' end
			else if @vType ='L'  
				set @rValue= case month(@vDate)            
  				when 1 then 'January'
  				when 2 then 'February'
  				when 3 then 'March'
  				when 4 then 'April'
  				when 5 then 'May'
  				when 6 then 'June'
  				when 7 then 'July'
  				when 8 then 'August'
  				when 9 then 'September'
  				when 10 then 'October'
  				when 11 then 'November'
  				when 12 then 'December'
				else  'No' end
		   else  if @vType ='S'  
				set @rValue= case month(@vDate)            
  				when 1 then 'Jan.'
  				when 2 then 'Feb.'
  				when 3 then 'March'
  				when 4 then 'Apr.'
  				when 5 then 'May'
  				when 6 then 'June'
  				when 7 then 'July'
  				when 8 then 'Aug.'
  				when 9 then 'Sept.'
  				when 10 then 'Oct.'
  				when 11 then 'Nov.'
  				when 12 then 'Dec.'
							else   'No' end
        end
  
	else
		set @rValue =''
 
   return @rValue
    end

