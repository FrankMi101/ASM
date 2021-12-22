





-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 20, 2021  
-- Description:	Get  Staff Apps operation permission
-- =============================================================================  

CREATE FUNCTION  [dbo].[App.UserRole.Model.AccessScope]
(@RoleID varchar(20),
 @AppID varchar(20), 
 @ModelID varchar(20)
 ) 
RETURNS varchar(20) 
AS  
   BEGIN
        declare   @AccessScope varchar(10)
		 
		set @AccessScope =''	 
			 
			set @AccessScope = ( select  Top 1 isnull(Permission,'') 
									from [dbo].[SIC_sys_UserRole_AppsPermission]
									where RoleID = @RoleID and AppID = @AppID  and ModelID = @ModelID )

		if isnull(@AccessScope,'') = ''  -- if there is no Apps role permision setup get generic Apps (SIC)
			set @AccessScope = ( select    Top 1 isnull(Permission,'') 
										from [dbo].[SIC_sys_UserRole_AppsPermission]
										where RoleID = @RoleID and AppID = 'SIC'  and ModelID = @ModelID )
		
  
	 RETURN  isnull(@AccessScope,'')
  END
    
 
