


--drop function  dbo.CurrentSchoolTerm
CREATE FUNCTION [dbo].[CurrentSchoolTerm] 
( 
  @date datetime 
)  
RETURNS varchar(1) 
AS  
BEGIN 
	declare @CurrentTerm  varchar(1) 
  	if month(@date) between '8' and '12' 
		set @CurrentTerm ='1'
	if  month(@date) between '1' and '3' 
		set @CurrentTerm ='2'
	if  month(@date) between '4' and '7' 
		set @CurrentTerm ='3'
 

	return isnull(@CurrentTerm,'1')

END





