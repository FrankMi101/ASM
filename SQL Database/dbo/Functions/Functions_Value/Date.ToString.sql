 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: November 10, 2021  
-- Description	: Date format
-- =====================================================================================

CREATE FUNCTION [dbo].[Date.ToString](@vDate datetime, @vType varchar(20))
RETURNS varchar(15) 
AS  
BEGIN 
	declare @vYY char(4), @vMM char(2) , @vDD char(2) , @vMMM Varchar(5), @rValue varchar(15) 
	if @vDate is not null
		begin
			set @vYY  =  cast(year(@vDate) as varchar(4))  
			set @vMM  =  right('0' + cast(month(@vDate) as varchar(2)),2)   
			set @vDD  =  right('0' + cast(day(@vDate) as varchar(2)),2)  
			set @vMMM =  FORMAT(@vDate, 'MMM')  --  DATENAME(month,@vDate)   
		 --	set @rValue = @vYY + '-' + @vMM + '-' + @vDD
			set @rValue = Case 	 @vType when 'MMMDDYYYY'	then rtrim(@vMMM) + ' ' + @vDD + ', ' + @vYY  
										when 'YYYYMMDD'		then @vYY + '/' + @vMM + '/' + @vDD
										when 'YYYY-MM-DD'	then @vYY + '-' + @vMM + '-' + @vDD	
										when 'YYMM'			then @vYY + '/' + @vMM 
										when 'MMDD'			then @vMM  +'/' + @vDD 
										when 'Month'		then DATENAME(month,@vDate)  
										when 'WeekDay'		then cast(datepart(dw, @vDate) as varchar(2) )    
										when 'Week'			then DATENAME(weekday,@vDate)
										when 'WeekS'		then left(DATENAME(weekday,@vDate),3)
										when 'Week2'		then left(DATENAME(weekday,@vDate),2)
										else @vYY + '-' + @vMM + '-' + @vDD	end
		end	
	else
		 set @rValue =''
 
	return @rValue
END




















