


 
-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021  
-- Description:	Get  Staff Area by user ID or CPNum
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Area](@UserID varchar(20) )  
RETURNS varchar(20) 
AS  
   BEGIN
        declare @rValue varchar(100), @CPNum varchar(10)
 		if exists (select 1 from [dbo].[SIC_sys_SchoolAreas] where UserID = @UserID  or Officer = @UserID)
				set @rValue = (select top 1  School_Area from [dbo].[SIC_sys_SchoolAreas]
							   where UserID = @UserID or  Officer = @UserID
							   )
		else if exists (select 1 from [dbo].[SIC_sys_SchoolAreaUser] where UserID = @UserID)
				set @rValue = (select top 1  SchoolArea from [dbo].[SIC_sys_SchoolAreaUser]
								where UserID = @UserID
							   )
		else if exists (select 1 from [dbo].[SIC_sys_UserGroup]			as G
				inner join [dbo].[SIC_sys_UserGroup_Members]		as M on G.GroupID = M.GroupID and M.GroupType ='Area'
		  		inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
				where T.MemberID = @UserID and getdate() between T.StartDate and T.EndDate )
			set @rValue = (select Top 1 G.GroupValue 
							from [dbo].[SIC_sys_UserGroup]				as G
							inner join [dbo].[SIC_sys_UserGroup_Members]		as M on G.GroupID = M.GroupID and M.GroupType ='Area'
		  					inner join [dbo].[SIC_sys_UserGroup_MemberTeachers] as T on  M.SchoolCode = T.SchoolCode and M.AppID =T.AppID and M.GroupID =T.GroupID
							where T.MemberID = @UserID and getdate() between T.StartDate and T.EndDate
							)
		else 
			set @rValue =''
			--set @rValue = (select top 1  SchoolArea 
			--				from [dbo].[SIC_sys_SchoolsView]
			--				where SchoolCode = (select top 1 SchoolCode from [dbo].[Staff.Schools.SAP](@UserID))
			--				)
							 
	 RETURN  isnull(@rValue,'')
  END


   
