







-- =================================================================================
-- Author:		Frank Mi
-- Create date: July 24, 2018
-- Description:	get student Picture 
-- ===================================================================================

CREATE FUNCTION [dbo].[Student.Picture] 
(	@SchoolYear varchar(8),
	@SchoolCode varchar(8),
	@PersonID varchar(13)
	 )  
RETURNS  VARBINARY(max) -- image
AS  
   BEGIN
   --  *** User defind function does not support the image data type.  
   --  *** if Verbinary dose not work in applicaiton, need to join the   dbo.tcdsb_TMM_Net_student_image in SP, directly get the image filed
      declare @StudentNo varchar(13), @imageStudent as VARBINARY(max) --  @imageStudent image ,
	  set @StudentNo = (select top 1 student_no from persons where person_id = @PersonID)
	  if exists (select * from  dbo.tcdsb_TMM_Net_student_image where student_no = @StudentNo)
	      set @imageStudent = (select top 1  CONVERT(VARBINARY(max), [image]) from   dbo.tcdsb_TMM_Net_student_image where student_no = @StudentNo)
      else
	      set @imageStudent = null

      return  @imageStudent
  END

   

















