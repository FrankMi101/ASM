

-- =================================================================================
-- Author:		Frank Mi
-- Create date: Febuary 17, 2021 
-- Modify	  : Modify by Frank 2021/03/23  --  request by Maria
-- Modify	  : Modify by Frank 2021/03/24  --  request by Maria
-- Description:	check student IEP completed date  with 30 days of school year start
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.IEP.CompleteCheckDate](
@SchoolYear varchar(8),
@SchoolCode	varchar(8), 
@CheckDatePoint varchar(10)
)
RETURNS smalldatetime
AS 


/*
As an update to the information below, could you please provide the following data?
For each academic year, the number of IEP that are incomplete as of the following dates:
2019 -2020         November 16
2018-2019          November 17
2017-2018          November 18
2016-2017          November 19
Please do not total the incomplete IEP from October and November combined.

*/

/*

Having reviewed this data, I am in need of a further breakdown of this year’s (2020) data to include the following:

Total IEP complete/incomplete as of November 25, 2020 for Brick and Mortar school students.
Total IEP complete/incomplete as of December 12, 2020 for St. Anne students. 
This data can be presented in a separate document.



Number of students with IEP as of September 8, 2020.
Number of IEP completed as of October 26, 2020 for students enrolled in Brick and Mortar Schools.
Number of IEP completed as of November 12, 2020 for students enrolled at St. Anne. 
 
If you are unable to separate the data as indicated above then the total number of IEP for all students completed on October 25, 2020 and November 12, 2020 would be helpful.
 
B.
Number of students with IEP as of the first day of school and number of IEP completed 30 days later.
 
Sept. 3/October 16, 2019
Sept. 4/October 17, 2018
Sept. 5/October 18, 2017
Sept. 5/ October 19, 2016
*/

/*
Could you please complete another data capture that indicates completed IEPs? 
Principals have had the opportunity to complete the IEP that were shown as pending. 
The data should show a much higher level of completion. Please use today’s date (Monday, May 3/21) to check for completed IEP. 
*/

BEGIN
	declare @rValue varchar(20), @CheckDate smalldatetime
	if @CheckDatePoint ='30'
			set @CheckDate = Case @SchoolYear	when '20162017' then '2016-10-16' 
												when '20172018' then '2017-10-17' 
												when '20182019' then '2018-10-18' 
												when '20192020' then '2019-10-19' 
												when '20202021' then  case  @SchoolCode	when '0469' then '2020-11-12'
																						when '0569' then '2020-11-12'
																						else '2020-10-26'  end
												else '' end
 
 	if @CheckDatePoint ='60'
			set @CheckDate = Case @SchoolYear	when '20162017' then '2016-11-16' 
												when '20172018' then '2017-11-17' 
												when '20182019' then '2018-11-18' 
												when '20192020' then '2019-11-19' 
												when '20202021' then  case  @SchoolCode	when '0469' then '2020-12-12'
																						when '0569' then '2020-12-12'
																						else '2020-11-26'  end
												else '' end

  	if @CheckDatePoint ='Now'
			set @CheckDate = Case @SchoolYear	when '20162017' then '2017-05-03' 				
												when '20172018' then '2018-05-03' 				
												when '20182019' then '2019-05-03' 				
												when '20192020' then '2020-05-03' 				
												when '20202021' then '2021-05-03' else '' end	

 
	RETURN(@CheckDate)
END
 
