





  

-- ============================================================================
-- Author:		Frank Mi
-- Create date: April 20, 2021  
-- Description:	Get  Staff Apps operation permission
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.Role.Permission.APP]
(@UserID varchar(20),@UserRole varchar(20),@AppID varchar(20) ) 
RETURNS varchar(20) 
AS  
   BEGIN
        declare  @ModelID varchar(20),@Permission varchar(10)
		set @ModelID ='Pages'
		if @UserRole = '' set @UserRole = [dbo].[Staff.Role.APP](@UserID, @AppID)
		set @Permission =''
		-- Step 1 get User Group permission
		set  @Permission = (select top 1 isnull(Permission,'') 
								from [dbo].[SIC_sys_UserGroup_Members]				 as M  
								inner join  [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on    M.SchoolCode = T.SchoolCode and M.AppID = T.AppID and M.GroupID = T.GroupID
								where T.AppID = @AppID and T.MemberID = @UserID  and getdate() between T.StartDate and T.EndDate and M.Active_flag ='x'
								order by case Permission when 'Deney' then '1' when 'Super' then '2' when 'Update' then '3' else '4' end
								)
		if isnull(@Permission,'') = ''
			-- Step 2 get User permission by User Role with default Model ID
			set @Permission = ( select  Top 1 isnull(Permission,'') 
									from [dbo].[SIC_sys_UserRole_AppsPermission]
									where RoleID = @UserRole and AppID = @AppID  and ModelID = @ModelID )

		if isnull(@Permission,'') = ''  -- if there is no Apps role permision setup get generic Apps (SIC)
			set @Permission = ( select    Top 1 isnull(Permission,'') 
										from [dbo].[SIC_sys_UserRole_AppsPermission]
										where RoleID = @UserRole and AppID = 'SIC'  and ModelID = @ModelID )
		
		if isnull(@Permission,'') = ''  -- if there is no Apps role permision setup get generic Apps (SIC) without check ModelID
		   set @Permission = ( select Top 1 Permission 
										from [dbo].[SIC_sys_UserRole]
										where RoleID = @UserRole and AppID = 'SIC'   )
	
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
    
 
