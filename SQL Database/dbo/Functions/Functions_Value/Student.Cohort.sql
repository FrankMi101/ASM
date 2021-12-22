

 

-- =================================================================================
-- Author		: Frank Mi
-- Create date	: Novmber 24, 2020 
-- Description	: get student cohort
-- ===================================================================================

CREATE FUNCTION [dbo].[Student.Cohort] 
(	@SchoolYear varchar(8), @PersonID varchar(13),
	@CourseCode varchar(10),@CourseSection varchar(10), @Block varchar(10),@SchoolPeriod varchar(10), @Semester varchar(10), @Term varchar(10),
	@Teacher	varchar(50), @Room varchar(20),@RoomT varchar(20),  @StartTime varchar(10), @EndTime varchar(10),@Day varchar(1))  
RETURNS varchar(150) 
AS  
   BEGIN
        declare @rValue varchar(100)
		set @rValue = case @Day when '1'	then 'A'
								when '2'	then 'B'
								when '3'	then 'C'
								when '4'	then 'D' else '' end

	    --set  @rValue ='Course-' + isnull(@CourseCode,'') + '-' + isnull(@CourseSection,'') + ':'
					--+ 'Period-' + isnull(@SchoolPeriod, '') + ':'  
					--+ 'Seme-'	+ isnull(@semester,'') + ':' 
					--+ 'Term-'	+ isnull(@term,'') + ':' 
					--+ 'block-'  + isnull(@block, '') + ':'
					--+ 'Room-'	+ isnull(@Room,'') + ':'
					--+ 'Room2-'	+ isnull(@RoomT,'') + ':'
					--+ 'Time-'	+ isnull(@StartTime,'') + '-' + isnull(@Endtime,'') + ':'
					--+'Teacher-' + isnull(@Teacher,'') 
					--+'Day-'     + isnull(@Day,'') 
 
       RETURN(@rValue)
  END



 














