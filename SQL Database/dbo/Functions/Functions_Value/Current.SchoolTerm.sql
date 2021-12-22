

-- =========================================================================
-- Author:		Frank Mi
-- Create date: August 22, 2017 
-- Description:	get current school term
-- =========================================================================

--drop function  dbo.CurrentSchoolTerm
CREATE FUNCTION [dbo].[Current.SchoolTerm] 
( 
  @date datetime,
  @Type varchar(1) -- 3 / 4  
)  
RETURNS varchar(1) 
AS  
BEGIN 
	declare @CurrentTerm  varchar(1) 
	if @type ='3'
	   begin
  			if month(@date) between '8' and '12' 
				set @CurrentTerm ='1'
			if  month(@date) between '1' and '3' 
				set @CurrentTerm ='2'
			if  month(@date) between '4' and '7' 
				set @CurrentTerm ='3'
	   end
	if @type ='4'
	   begin
  			if month(@date) in( '9','10','11') 
				set @CurrentTerm ='1'
			if  month(@date) in ('12','1','2')
				set @CurrentTerm ='2'
			if  month(@date) in( '3', '4') 
				set @CurrentTerm ='3'
			if  month(@date) between '5' and '6' 
				set @CurrentTerm ='4'
	   end

	return isnull(@CurrentTerm,'1')

END






