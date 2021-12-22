
-- =================================================================================
-- Author:		Frank Mi
-- Create date: September 30, 2020
-- Description:	get student Google account information
-- ===================================================================================

CREATE FUNCTION [dbo].[Student.GAcount] 
(@StudentNo varchar(9),
 @Type		varchar(20)
)
RETURNS Varchar(50)
AS  
BEGIN

	declare @rValue  varchar(50)
	set  @rValue = ( select top 1 case @Type when 'Email' then Email when 'Account' then ADUsername else GAL_UID end
					 from dbo.tcdsb_z_ADAccounts where StudentNumber = @StudentNo and studentflag=1 )
 
	RETURN isnull(@rValue,'')
END

