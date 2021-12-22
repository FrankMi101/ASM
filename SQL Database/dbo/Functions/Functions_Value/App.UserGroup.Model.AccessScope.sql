
-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 22, 2021  
-- Description:	Get  Staff Assign Group Type
-- =============================================================================  

Create FUNCTION  [dbo].[App.UserGroup.Model.AccessScope]
(@AppID varchar(10),
@ModelID varchar(20),  -- ususally it is Page for Applicaiont. it Could be a specific Page ID  
@GroupID varchar(200),
@SchoolCode varchar(8) ) 
RETURNS varchar(20) 
AS  
   BEGIN
    
        declare @rValue varchar(20) 
		set @rValue = (	select top 1 isnull(AccessScope, '') 
						from [dbo].[SIC_sys_UserGroup_AppsPermission] 
						where SchoolCode = @SchoolCode and AppID = @AppID and GroupID = @GroupID and ModelID = @ModelID
 					  )

		if @rValue =''
			set @rValue = (	select top 1 isnull(AccessScope, '') 
						from [dbo].[SIC_sys_UserGroup_AppsPermission] 
						where SchoolCode = @SchoolCode and AppID = 'SIC' and GroupID = @GroupID and ModelID = @ModelID
 					  )
	 RETURN  isnull(@rValue,'')
  END
   
