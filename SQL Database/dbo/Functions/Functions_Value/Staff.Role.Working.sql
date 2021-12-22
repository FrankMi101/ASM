






-- =================================================================================
-- Author:		Frank Mi
-- Create date: Octomber 08, 2021
-- Description:	to get Staff Working role. This role will overwrite the SAP role   
-- ===================================================================================
 
CREATE Function [dbo].[Staff.Role.Working]
(
 @UserID	varchar(30),
 @AppID		varchar(10)
)
RETURNS varchar(50)
as
begin 
	declare @RolebyPosition  varchar(20),  @RolebyClassID  varchar(20),  @rValue varchar(50), @position varchar(200) , @classType varchar(200)

	-- Step 1 get Staff overwrite app role  
			-- All Developers should be in Admin group by default (AppID ='SIC')
			-- IEP/SS forms committee members shoul be in Admin Group of IEP (AppID ='IEP')
			-- HR hiring Staffs should be in Admin Group of LTO (AppID ='LTO')
			-- Aggle Names, Laurienne Graham, and Mark Moffett TPA coordinater should be in Admin Group of TPA (AppID ='TPA')
 		if @AppID in ('IEP','SSF')
			set @rValue = (select   top 1 RoleName  
							from dbo.tcdsb_SES_seTeacherRole
							where   UserID = @UserID )
 
  		if @rValue is null  set @rValue = (select   top 1 AppRole  
											from [dbo].[SIC_sys_UserWorkingRoles] 
											where AppID = @AppID and UserID = @UserID and LOWER(ActiveFlag) = 'x'  and getdate() between StartDate and isnull(EndDate, getdate() + 365)
											)


	-- step 2  get Default overwrite role
		if @rValue is null  set @rValue = (select top 1 AppRole 
											from [dbo].[SIC_sys_UserWorkingRoles] 
											where AppID = 'SIC' and UserID = @UserID and LOWER(ActiveFlag) = 'x'  and getdate() between StartDate and isnull(EndDate, getdate() + 365)
											)
	-- Step 3 check ITF role for some application
		if @rValue is null 
			begin
				if exists (select 1 from [dbo].[SIC_sys_UserGroup_FeederSchoolTeachers] where MemberID = @UserID and schoolYear = [dbo].[Current.SchoolYear]('SIC') )
					set @rValue = 'ITFTeacher'	
 			end

	-- step 4 get user defalt SAP role	
		if @rValue is null set @rValue  = [dbo].[Staff.Role.SAP](@UserID)

	 

  
	set @rValue = isnull(@rValue,  'Other')

  Return(@rValue)
 
end 
  
