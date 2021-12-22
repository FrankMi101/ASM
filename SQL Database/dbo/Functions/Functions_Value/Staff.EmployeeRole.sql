

-- =================================================================================
-- Author:		Frank Mi
-- Create date: November 29, 2020
-- Description:	to get current tcdsb staff role
-- ===================================================================================
 
CREATE Function [dbo].[Staff.EmployeeRole]
(@UserID	varchar(30) 
 )
RETURNS varchar(50)
as
begin 
	declare @rValue varchar(50) 

	select top 1  @rValue = UserRole 
	from dbo.SIC_sys_UserProfileMatch
	where PositionDesc = (select top 1 PositionDesc   from dbo.SIC_sys_Employee where UserID = @UserID  order by pickedForGAL DESC)
	 

  Return(isnull(@rValue,'Teacher'))
 
end 
 
