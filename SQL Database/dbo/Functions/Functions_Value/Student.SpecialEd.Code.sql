
-- =================================================================================
-- Author		: Frank Mi
-- Create date	: May 21, 2021
-- Description	: get  Special Education Exceptionality and Placemnt Convert to Trillium
-- ===================================================================================
   
CREATE FUNCTION [dbo].[Student.SpecialEd.Code](
@Category varchar(10),
@ReturnCategory varchar(20),
@Code varchar(10) )

RETURNS varchar(150) 
AS 
BEGIN
	declare @rValue varchar(150)

	if @Category ='Excep'
		begin
			if @ReturnCategory ='Name'
				begin
				   if len(@Code) = 9  set @Code = case @Code 
												 When '000110016' then '010'
												 When '000110017' then '020'
												 When '000110018' then '030'
												 When '000110019' then '040'
												 When '000110020' then '050'
												 When '000110021' then '060'
												 When '000110022' then '070'
												 When '000110023' then '080'
												 When '000110024' then '090'
												 When '000110025' then '100'
												 When '000110026' then '105'
												 When '000110027' then '200'
												 When '000110028' then '110' else '' end
 

					set @rValue =  case @Code
								When '010' then 'Autism'
								When '020' then 'Behaviour'
								When '030' then 'Blind and Low Vision'
								When '040' then 'Deaf and Hard-of-Hearing'
								When '050' then 'Developmental Disability'
								When '060' then 'Giftedness'
								When '070' then 'Language Impairment'
								When '080' then 'Learning Disability'
								When '090' then 'Mild Intellectual Disability'
								When '100' then 'Physical Disability'
								When '105' then 'Multiple Exceptionalities'
								When '200' then 'Speech Impairment '
								When '110' then 'Not Applicable'  	Else  ''  end
				end
 		  else
					set @rValue =  case @Code
											 When '010' then '000110016'
											 When '020' then '000110017'
											 When '030' then '000110018'
											 When '040' then '000110019'
											 When '050' then '000110020'
											 When '060' then '000110021'
											 When '070' then '000110022'
											 When '080' then '000110023'
											 When '090' then '000110024'
											 When '100' then '000110025'
											 When '105' then '000110026'
											 When '200' then '000110027'
											 When '110' then '000110028' 
												 When '000110016' then '010'
												 When '000110017' then '020'
												 When '000110018' then '030'
												 When '000110019' then '040'
												 When '000110020' then '050'
												 When '000110021' then '060'
												 When '000110022' then '070'
												 When '000110023' then '080'
												 When '000110024' then '090'
												 When '000110025' then '100'
												 When '000110026' then '105'
												 When '000110027' then '200'
												 When '000110028' then '110' else '' end
 		end

	else if @Category ='Placement'
		begin
			if @ReturnCategory = 'Name'
				set @rValue =  case @Code
									When '1'	then 'Regular Class with Indirect Support'
									When '2'	then 'Regular Class with Resource Assistance'
									When '3'	then 'Regular Class with Withdrawal Assistance'
									When '4'	then 'Special Education Class with Partial Integration'
									When '5'	then 'Special Education Class Full Time'
									When '6'	then 'N/A'
									 When 'IS'  then 'Regular Class with Indirect Support'
									 When 'RA'  then 'Regular Class with Resource Assistance'
									 When 'WA'  then 'Regular Class with Withdrawal Assistance'
									 When 'PI'  then 'Special Education Class with Partial Integration'
									 When 'FSC' then 'Special Education Class Full Time'
 									Else  ''  end
				else
						set @rValue =  case @Code
									 When 'IS' then '1'
									 When 'RA' then '2'
									 When 'WA' then '3'
									 When 'PI' then '4'
									 When 'FSC' then '5'
									 When 'NA' then '6'
									 When '1' then 'IS'
									 When '2' then 'RA'
									 When '3' then 'WA'
									 When '4' then 'PI'
									 When '5' then 'FSC'
									 When '6' then 'NA'   else '' End
		end
	 
  set @rValue = isnull(@rValue,'') 
  RETURN(@rValue)
END
 
 