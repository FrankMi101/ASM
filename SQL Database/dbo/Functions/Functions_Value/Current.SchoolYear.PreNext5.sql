 
-- =========================================================================
-- Author:		Frank Mi
-- Create date: August 25 2017 
-- Description:	get next school year or Previous school year by school year
-- =========================================================================
CREATE FUNCTION [dbo].[Current.SchoolYear.PreNext5] 
( @Type		varchar(10),
  @SchoolYear varchar(8)
)  
RETURNS varchar(8) 
AS  
BEGIN 
	declare @rSchoolYear varchar(8)
	declare @ThisYear int
	declare @ObjYear int
 	set @ThisYear=CAST(left(@SchoolYear,4) as int)
	if @Type = 'Previous'
		set @ObjYear=@ThisYear-5
	else
		set @ObjYear=@ThisYear+4
 

	if @Type = 'Previous'
			set @rSchoolYear =  CAST(@ObjYear as varchar(4)) + CAST(@ThisYear as varchar(4))
	if @Type = 'Next'
			set @rSchoolYear=CAST(@ObjYear as varchar(4)) + CAST(@ObjYear +1 as varchar(4))

 
	return   @rSchoolYear -- '20092010'  --

END



