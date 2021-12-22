

-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021
-- Description:	to get Staff App Role  
-- ===================================================================================

CREATE Function [dbo].[Staff.Role.APP]
(
 @UserID	varchar(30),
 @AppID		varchar(20)
)
RETURNS varchar(50)
as
begin 
	 declare @rValue varchar(50) 
	 set @rValue = [dbo].[Staff.Role.Working](@UserID, @AppID) 

			set @rValue =(select  top 1 case @AppID when 'IEP'	then RoleIEP
													when 'SSF'	then RoleSSF
													when 'TPA'	then RoleTPA
													when 'PPA'	then RolePPA
													when 'LTO'	then RoleLTO
													else @rValue end
					      from [dbo].[SIC_sys_UserRole_Apps]
						  where RoleID = @rValue)
 
	set @rValue = isnull(@rValue,  'Other')

  Return(@rValue)
 
end 
