





-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021
-- Description:	to get Staff access student scope by user apps Role   
-- ===================================================================================
 
Create Function [dbo].[Staff.Role.Scope]
(
 @UserRole	varchar(30),
 @AppID		varchar(20)
)
RETURNS varchar(50)
as
begin 
	declare    @rValue varchar(50), @position varchar(200) , @classType varchar(200)
	   
		set @rValue = (	select  top 1 AccessScope
						from [dbo].[SIC_sys_UserRole]
						where RoleID = @UserRole 
						)

		set @rValue = isnull(@rValue,  'Student')

  Return(@rValue)
 
end 
 

