

 


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Oct 15, 2020  
-- Description	: get system DDL  list items 
-- =====================================================================================
 
CREATE proc [dbo].[SIC_sys_UserAppsRole]    
        @Operate 	varchar(50),
		@UserID 	varchar(30),
		@BaseRole	varchar(30),
		@AppID		varchar(50)
as
set nocount on 
begin
  
  select top 1  case @AppID when 'IEP' then RoleIEP 
							when 'SSF' then RoleSSF
							when 'TPA' then RoleTPA
							when 'PPA'	then RoleTPA
							when 'LTO'	then RoleLTO
							else RoleSIC end
    from [dbo].[SIC_sys_UserRole_Apps] 
	where RoleID  = @BaseRole
   
 end   
  


	  

