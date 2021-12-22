

 -- drop function dbo.student

Create FUNCTION [dbo].[Student.IsInVritualSchool] (@SchoolYear varchar(8),@Person_id varchar(15) )  
RETURNS varchar(10)
--- Frank Mi
--- Sept 23, 2020
--- @perason_id   
AS  
   BEGIN
        declare @rValue varchar(10)
		if exists(  select top 1 * from dbo.tcdsb_SES_Students where school_year = @SchoolYear and person_id = @Person_id  and School_code = HomeSchool)
			set @rValue = ''
		--if @rValue not in ('0469','0569')  set @rValue =''
		else
			set @rValue =( select top 1 School_Code from dbo.tcdsb_SES_Students where school_year = @SchoolYear and person_id = @Person_id  and School_code in ('0469','0569'))
       RETURN(@rValue)
  END