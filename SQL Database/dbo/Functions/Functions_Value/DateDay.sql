 


CREATE FUNCTION [dbo].[DateDay](@vType varchar(20), @Date1 datetime, @Date2 datetime)
RETURNS varchar(5) 
AS  
BEGIN 
declare @rValue varchar(5)
 
        if @vType ='Days'  
              set @rValue= day(@Date1)
              
        if @vType ='DaysGo'  
              set @rValue= DATEDIFF(day, @Date1, @Date2)        
  		 
           
    set @rValue =''
 
  return @rValue
end




















