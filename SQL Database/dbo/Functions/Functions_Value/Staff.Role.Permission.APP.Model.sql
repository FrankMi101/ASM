





  

-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 20, 2021  
-- Description:	Get Staff Apps content operation permission by Function or Page 
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.Role.Permission.APP.Model]
(@UserID varchar(20),@UserRole varchar(20),@AppID varchar(20),@ModelID varchar(20) ) 
RETURNS varchar(20) 
AS  
   BEGIN
        declare @Permission varchar(10)
 		if @UserRole = '' set @UserRole = [dbo].[Staff.Role.APP](@UserID, @AppID)
		set  @Permission =''
				-- Step 1 get User permission by User Role with default Model ID
		set @Permission = ( select Top 1 Permission 
							from [dbo].[SIC_sys_UserRole_AppsPermission]
							where RoleID = @UserRole and AppID = @AppID  and ModelID = @ModelID )
		--	Step 2 get User permission by a App Other Role with default Model ID
		set @Permission = ( select Top 1 Permission 
							from [dbo].[SIC_sys_UserRole_AppsPermission]
							where RoleID = 'AppOther' and AppID = @AppID  and ModelID = @ModelID )

	
	--if isnull(@Permission,'') = ''  -- if there is no Apps role permision setup of specific Model and then get generic Model (Pages)
		--	set @Permission = ( select  Top 1 Permission 
		--								from [dbo].[SIC_sys_UserRole_AppsPermission]
		--								where RoleID = @UserRole and AppID = @AppID  and ModelID = 'Pages' )
     /*    
		-- Step 3 get user permission by user role and apps ID
		  we should not to get the permision by default page ID and User Role on Model level 
		if 	isnull(@Permission,'') = ''
			set @Permission =  [dbo].[Staff.Role.Permission.APP](@UserID,@UserRole,@AppID)
	 */ 

	 RETURN  isnull(@Permission,'Deny')
  END
    
 
