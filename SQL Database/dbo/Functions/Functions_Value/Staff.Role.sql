







-- =================================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021
-- Description:	to get Staff login application 
-- ===================================================================================
 
CREATE Function [dbo].[Staff.Role]
(
 @UserID	varchar(30),
 @AppID		varchar(10)	
 )
RETURNS varchar(50)
as
begin 
	declare  @Role varchar(50)

	-- App Role always has high priority 

    -- Step 1 get Staff App Role
		set @Role = [dbo].[Staff.Role.App](@UserID, @AppID)


	-- Step 2 if App Role is noting then get Staff nature SAP Role from SAP table
		if @Role in ('Other','EA','NA','') set @Role = [dbo].[Staff.Role.SAP](@UserID)

 
		set @Role = isnull(@Role,  'Other')

  Return(@Role)
 
end 
 

