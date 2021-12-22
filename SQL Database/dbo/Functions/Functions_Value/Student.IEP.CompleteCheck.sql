



-- =================================================================================
-- Author:		Frank Mi
-- Create date: Febuary 17, 2021 
-- Modify	  : Modify by Frank 2021/03/23  --  request by Maria
-- Description:	check student IEP completed date  with 30 days of school year start
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.IEP.CompleteCheck](
@PersonID varchar(13),
@SchoolYear varchar(8),
@SchoolCode	varchar(8), 
@CompleteDate	smalldatetime,
@CheckDatePoint varchar(10)
)
RETURNS varchar(20)
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



BEGIN
	declare @rValue varchar(20), @CheckDate smalldatetime
	if @SchoolYear ='20202021'
		set @CheckDate = Case @CheckDatePoint   when 'One' then case @SchoolCode when '0469' then '2020-11-12' when '0569' then '2020-11-12' else '2020-10-26' end
												when 'Two' then case @SchoolCode when '0469' then '2020-12-12' when '0569' then '2020-12-12' else '2020-11-25' end
												else '' end
	else
		begin
			if @SchoolCode in ('0469','0569')
			   set @CheckDate ='2020/11/12'
			else
				set @CheckDate = case @SchoolYear when '20202021' then case @SchoolCode when '0469' then '2020-11-12'
																						when '0569' then '2020-11-12'
																						else '2020-10-26' end
													 when '20192020' then '2019/11/16' -- '2019/10/16'  change by Frank at 2021/03/23
													 when '20182019' then '2018/11/17' -- '2018/10/17'
													 when '20172018' then '2017/11/18' --' 2017/10/18'
													 when '20162017' then '2016/11/19'  -- '2016/10/19'
													 else  '2020/10/20'  end

		end
	if @CompleteDate <= @CheckDate
	   set @rValue ='Completed'
	else
		set @rValue = 'Incomplete'
 
	RETURN(@rValue)
END
 
