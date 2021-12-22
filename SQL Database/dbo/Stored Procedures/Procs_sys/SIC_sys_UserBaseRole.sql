

 


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Oct 15, 2020  
-- Description	: get system DDL  list items 
-- =====================================================================================
 
CREATE proc [dbo].[SIC_sys_UserBaseRole]    
        @Operate 	varchar(50),
		@UserID 	varchar(30) 
as
set nocount on 
begin
  
	select top 1 M.UserRole
	from dbo.SIC_sys_Employee  as E
	inner join [dbo].[SIC_sys_UserProfileMatch] as M on E.PositionDesc = M.PositionDesc
	where E.UserID = @UserID 
	order by PickedForGAL DESC
 end   

	  


	  

