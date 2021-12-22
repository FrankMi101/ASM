


-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 22, 2021  
-- Description:	Get  Staff Assign Group Type
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.Assign.School]
(@UserID varchar(20),@AppID varchar(10)) 
RETURNS varchar(8) 
AS  
   BEGIN
    
        declare @rValue varchar(8) 
		-- Step 1 get user group ID for specific AppID
 		set @rValue = (	select top 1 isnull(M.SchoolCode, '') 
						from [dbo].[SIC_sys_UserGroup_Members] as M
						inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on  M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
						where T.AppID = @AppID and T.MemberID = @UserID and getdate() between T.StartDate and T.EndDate
						order by case M.GroupType  when 'Board' then 1 when 'Panel' then 2 when 'Area'then 3 when 'Schools' then 4 when 'School' then 5  else 6 end
					  )
		-- Step 2 if user not setup group in specific AppID, get general (SIC) group ID
		if isnull(@rValue,'') =''
			set @rValue = (	select top 1 isnull(M.SchoolCode, '') 
						from [dbo].[SIC_sys_UserGroup_Members] as M
						inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on  M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
						where T.AppID = 'SIC' and T.MemberID = @UserID and getdate() between T.StartDate and T.EndDate
						order by case M.GroupType  when 'Board' then 1 when 'Panel' then 2 when 'Area'then 3 when 'Schools' then 4 when 'School' then 5  else 6 end
					  )
	 RETURN  isnull(@rValue,'')
  END
   
   
