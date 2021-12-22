
-- =================================================================================
-- Author		: Frank Mi
-- Create date	: Novmber 24, 2020 
-- Description	: get student cohort
-- ===================================================================================

CREATE FUNCTION [dbo].[School.Class.Teacher] 
(	@SchoolYear varchar(8), 
	@SchoolCdoe varchar(8),
	@ClassCode  varchar(20),
	@Type		varchar(10)
	)  
RETURNS varchar(50) 
AS  
   BEGIN
		declare @teacherID  varchar(15), @rVal varchar(50)
		set @rVal = ( select top 1 person_id  from dbo.term_teachers  where school_code =@SchoolCdoe and school_year =@SchoolYear and class_code = @ClassCode )
		if @Type ='Name' set  @rVal =  [dbo].[Teacher.Name.ByID](@rVal, 'Name')
 	 
	 return @rVal
  END
