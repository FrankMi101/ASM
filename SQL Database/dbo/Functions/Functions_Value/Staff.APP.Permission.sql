


-- ============================================================================
-- Author	  : Frank Mi
-- Create date: March 22, 2021  
-- Description:	Get Staff App permission. the permission base on the user role. 
--				No individual user grant special permission
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.APP.Permission]
(@UserID varchar(20),@UserRole varchar(30), @AppID varchar(10),@ModelID varchar(50) ) 
RETURNS varchar(20) 
AS  
   BEGIN
    
        declare @Permission varchar(20), @RolePermission varchar(20),@GroupPermission varchar(20), 
				@GroupID varchar(200),  @SchoolCode varchar(8), @DefAppID varchar(10), @DefModelID varchar(50)
		select @DefAppID ='SIC' , @DefModelID ='Pages'

		if len(isnull(@AppID,'')) = 0  set @AppID = @DefAppID  
		if len(isnull(@ModelID,'')) = 0  set @ModelID = @DefModelID

		-- Step 1 Get User app permssion from user role
		set @RolePermission = ( select   Top 1 isnull(Permission,'') 
							from [dbo].[SIC_sys_UserRole_AppsPermission]
							where RoleID = @UserRole and AppID = @AppID  and ModelID = @ModelID )

		if @RolePermission is null 
			set @RolePermission = ( select   Top 1 isnull(Permission,'') 
							from [dbo].[SIC_sys_UserRole_AppsPermission]
							where RoleID = @UserRole and AppID = @DefAppID  and ModelID = @DefModelID )
		
		-- Step 2 Get User app permission from user group
		set @GroupPermission = (select top 1 isnull(Permission,'Deny')
								from dbo.SIC_sys_UserGroup_AppsPermission as P
								inner join dbo.SIC_sys_UserGroup_MemberTeachers as T on P.SchoolCode = T.SchoolCode and P.AppID = T.AppID and P.GroupID = T.GroupID
								where T.MemberID = @UserID and getdate() between T.StartDate and T.EndDate
									and P.ModelID = @ModelID)

		-- Step 3 Get User finel Permissino based on the permission priority
		set @Permission = (select top 1 Permission
							from [dbo].[SIC_sys_AccessPermission] 
							where Permission in (@RolePermission, @GroupPermission)
							order by priority)   
	 RETURN  isnull(@Permission,'Deny')
  END
   
