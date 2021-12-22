
--drop view [dbo].[SIC_sys_Schools_view] 

CREATE view [dbo].[SIC_sys_Schools_view] 
 	WITH SCHEMABINDING
	-- create view index can not incldue a user defdined function in view  
  as 
  
    select LocationID as SchoolCode, LocationName as SchoolName,
	school_area as SchoolArea,
	default_adminID  as SchoolPrincipal,
--	[dbo].[School.Area.SIC](locationID,'Area') as SchoolArea,  -- User Definde function cann't include in a view 
--	[dbo].[School.Principal.SIC](locationID,'Name') as SchoolPrincipal, -- 
	LocationBriefName, 
	case LocationID when '0533' then 'Monsignor Fraser College' else  LocationName end as LocationName,
	LocationType, status,scope, last_update_function , last_update_date_time, last_update_uid
	
	from dbo.tcdsb_RSecurity_Locations as R
	inner join dbo.SIC_sys_Schools     as S on R.LocationID = S.school_code
   where status ='x' and LEFT(locationID,1) in ('0','1')
