



-- ============================================================================
-- Author		: Frank Mi
-- Create date	: Sept 19, 2021 .  
-- Description	: check staff work school selected 
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.WorkSchool.IsSelected]
(	@SchoolYear	varchar(8),
	@SchoolCode	varchar(8),
	@UserID		varchar(30)
	)  
RETURNS varchar(10) 
AS  
   BEGIN
        declare @rValue varchar(10)  

	    if exists ( select 1 from  [dbo].[SIC_sys_UserWorkingSchools] where SchoolYear = @SchoolYear and GroupType ='School' and GroupID = @SchoolCode and UserID = @UserID)
			set @rValue ='true'
		else
			set @rValue ='false'

	 RETURN(isnull(@rValue,''))
  END

