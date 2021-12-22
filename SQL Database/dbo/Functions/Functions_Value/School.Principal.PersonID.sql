
-- =================================================================================
-- Author:		Frank Mi
-- Create date: Novermber 21, 2017  
-- Description:	to get current school principal ID by User ID
-- ===================================================================================


-- drop function    select dbo.SchoolPrincipalCurrent ('0290', '20132014','ID')
CREATE Function [dbo].[School.Principal.PersonID]
(@UserID  varchar(20)  )
RETURNS varchar(15)
as
begin 
	declare @rValue varchar(15)
  
   set @rValue = (select top 1 SS.Person_id  
				   from  school_staff as SS  
				   inner join  dbo.fs_staff_custom	as FS  on SS.person_id =FS.person_id 	
			       where SS.school_year = dbo.[Current.SchoolYear]('SES') and network_userid = @UserID
				   order by  SS.last_update_date_time DESC
				)
  Return(@rValue)
 
 
end 
 


