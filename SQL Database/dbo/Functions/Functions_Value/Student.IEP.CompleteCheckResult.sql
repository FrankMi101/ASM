




-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 24, 2021 
 -- Description:	check student IEP completed date  with 30 days of school year start
-- ===================================================================================
CREATE FUNCTION [dbo].[Student.IEP.CompleteCheckResult]
(
@CompleteDate	smalldatetime,
@CheckDate		smalldatetime
)
RETURNS varchar(20)
AS 
Begin
	declare @rValue varchar(20)
 
	if @CompleteDate <= @CheckDate
	   set @rValue ='Completed'
	else
		set @rValue = 'Incomplete'
 
	RETURN(@rValue)
END
 
