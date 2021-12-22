





-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 20, 2021  
-- Description:	Get  Staff Apps operation permission
-- =============================================================================  

CREATE FUNCTION  [dbo].[App.UserRole.Model.Permission]
(@RoleID varchar(20),
 @AppID varchar(20), 
 @ModelID varchar(20)
 ) 
RETURNS varchar(20) 
AS  
   BEGIN
        declare   @Permission varchar(10)
		 
		set @Permission =''	 
			-- Step 2 get User permission by User Role with default Model ID
			set @Permission = ( select  Top 1 isnull(Permission,'') 
									from [dbo].[SIC_sys_UserRole_AppsPermission]
									where RoleID = @RoleID and AppID = @AppID  and ModelID = @ModelID )

		if isnull(@Permission,'') = ''  -- if there is no Apps role permision setup get generic Apps (SIC)
			set @Permission = ( select    Top 1 isnull(Permission,'') 
										from [dbo].[SIC_sys_UserRole_AppsPermission]
										where RoleID = @RoleID and AppID = 'SIC'  and ModelID = @ModelID )
		
		if isnull(@Permission,'') ='' 
			set @Permission ='Deny'	 
 

		-- Step 3 Group permision overwrite the Role permission if group permision is not null
		--if @GroupPermission in ('Super','Update','Read')
		--   set @rValue = @GroupPermission
		--else -- if @RolePermission in ('Super','Update','Read')
		--   set @rValue = @RolePermission
         
        /*  set @rValue = ( select top 1 permission 
							from [dbo].[SIC_sys_UserAccessPermission]
							where  permission in (@RolePermission,@GroupPermission)
							order by [priority]
							)
		*/
	 RETURN  isnull(@Permission,'Deny')
  END
    
 
