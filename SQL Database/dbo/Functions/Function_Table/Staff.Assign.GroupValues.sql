﻿
 
-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021  
-- Description:	Get SAP Staff profile by user ID or CPNum
-- =============================================================================  

create FUNCTION [dbo].[Staff.Assign.GroupValues]
	(	 @UserID varchar(20),
		@AppID varchar(10)   
	 )
RETURNS @GroupMembers  TABLE 
		(MemberID varchar(20) 
		)
AS 
BEGIN 
	 insert into @GroupMembers
	 select distinct  isnull(S.MemberID, '') 
	 from [dbo].[SIC_sys_UserGroup_Members] as M
	 inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on  M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
	 inner join [dbo].[SIC_sys_UserGroup_MemberStudents] as S on  M.SchoolCode = S.SchoolCode and M.AppID =S.AppID and M.GroupID =S.GroupID
	 where  T.MemberID = @UserID and  getdate() between T.StartDate and T.EndDate
	-- order by case M.GroupType  when 'Board' then 1 when 'Panel' then 2 when 'Area'then 3 when 'Schools' then 4 when 'School' then 5 when 'Class' then '6' when 'Grade' then '7' else '8' end
			
	RETURN
END 
