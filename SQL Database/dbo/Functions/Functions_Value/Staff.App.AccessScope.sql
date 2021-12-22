





-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 22, 2021  
-- Description:	Get  Staff Assign Group Type
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.App.AccessScope]
(@UserID varchar(20),@AppID varchar(10),@ModelID varchar(50) ) 
RETURNS varchar(20) 
AS  
   BEGIN
    
        declare @rValue varchar(20), @GroupID varchar(200), @RoleID varchar(20),@SchoolCode varchar(8)
		set @rValue =''
		-- Step 1 get user group ID
		set @GroupID = [dbo].[Staff.Assign.GroupID](@UserID,@AppID)

		-- Step 2 get user app permssion by User Group if user has a group ID
		if @GroupID = ''
			begin
				set @RoleID = [dbo].[Staff.Role.App](@UserID,@AppID)
				set @rValue = [dbo].[App.UserRole.Model.AccessScope](@RoleID,@AppID,@ModelID)

			end
		else
			-- step 2 get user app permission by role if user has no group ID
			set @SchoolCode = [dbo].[Staff.Assign.School](@UserID,@AppID)
			set @rValue =  [dbo].[App.UserGroup.Model.AccessScope](@AppID,@ModelID,@GroupID,@SchoolCode)
 
	 RETURN  isnull(@rValue,'')
  END
   
   
