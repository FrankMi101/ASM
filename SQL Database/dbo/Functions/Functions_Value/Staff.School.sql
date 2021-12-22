


 
-- ============================================================================
-- Author		: Frank Mi
-- Create date	: November 18, 2021  
-- Description	: Get Staff home school 
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.School](@UserID varchar(20) )  
RETURNS varchar(20) 
   
AS  
   BEGIN
        declare @rValue varchar(100), @CPNum varchar(10) 

		set @rValue = (select top 1 OrgUnit_Code 
						from dbo.SIC_sys_Employee 
						where UserID = @UserID and lower(PickedForGAL) ='x'
						order by FTE desc)
		if @rValue is null
			set @rValue = (	select top 1 OrgUnit_Code 
							from dbo.SIC_sys_Employee 
							where UserID = @UserID and lower(PositionDesc) !='na'
							order by FTE desc)
		if @rValue is null		 
			    set @rValue = ( select top 1 GroupID
							 from [dbo].[SIC_sys_UserWorkingSchools]
							 where SchoolYear = [dbo].[Current.SchoolYear]('') 
							       and GroupType ='School' and UserID = @UserID and  ActiveFlag ='X' and getdate() between StartDate and EndDate 
							 order by case AppID when 'SIC' then '1' else '2' end 	  
						)
	 
 		 
	 RETURN  isnull(@rValue,'')
  END


   
