



-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 22, 2021  
-- Description:	Get  Staff Assign Group Type
-- =============================================================================  

CREATE FUNCTION  [dbo].[Staff.Assign.GroupType]
(@UserID varchar(20),@AppID varchar(10),@SchoolYear varchar(8) ) 
RETURNS varchar(20) 
AS  
   BEGIN
    
        declare @rValue varchar(100), @GroupType varchar(10)
		set @rValue = (	select top 1 isnull(M.GroupType, '') 
						from [dbo].[SIC_sys_UserGroup_Members] as M
						inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on  M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
						where  T.MemberID = @UserID and  getdate() between T.StartDate and T.EndDate
						order by case M.GroupType  when 'Board' then 1 when 'Panel' then 2 when 'Area'then 3 when 'Schools' then 4 when 'School' then 5 when 'Class' then '6' when 'Grade' then '7' else '8' end
					  )
  
	 RETURN  isnull(@rValue,'')
  END

   
