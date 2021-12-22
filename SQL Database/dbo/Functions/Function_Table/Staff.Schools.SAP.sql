





-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021  
-- Description:	Get SAP Staff profile by user ID or CPNum
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Schools.SAP]
	(	 @UserID		varchar(20) = null    
	 )
RETURNS @Schools  TABLE 
		(SchoolCode varchar(8),
		 SchoolName	varchar(350),
		 PickedFor	varchar(10)
		)
AS 
BEGIN 
 
	insert into   @Schools
	select distinct   SchoolCode, Orgunit_desc as SchoolName,PickedForGAL
	from dbo.SIC_sys_Employee 
	where  UserID =   @UserID  and PickedForGAL ='X'   -- and ActiveFlag ='X' and  getdate() between StartDate and isnull(EndDate, getdate()+10) 
 
	insert into   @Schools
	select distinct   SchoolCode, Orgunit_desc as SchoolName,PickedForGAL
	from dbo.SIC_sys_Employee 
	where  UserID =   @UserID   and schoolCode not in (select SchoolCode from @Schools)  
		
	insert into  @Schools
	select distinct GroupID, dbo.[School.Name](GroupID) as schoolName,'' 
	from dbo.SIC_sys_UserWorkingSchools
	where SchoolYear = [dbo].[Current.SchoolYear]('SIC')  
		 and GroupType ='School'	
		 and GroupID not in (select SchoolCode from @Schools) 
		 and UserID = @UserID  
		 and ActiveFlag ='X' 
		 and getdate() between StartDate and isnull(EndDate, getdate()+30) 

	RETURN
END 
