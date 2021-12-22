


 

CREATE view [dbo].[SIC_sys_SchoolsView]
as
--select  dbo.SchoolType(school_code) as School_Type,
--		dbo.SchoolArea(school_code,'SuperArea') as School_area,
--	    dbo.SchoolArea(school_code,'SuperName') as School_Super,
--		dbo.SchoolArea(school_code, 'SupportOffice')as School_SupportOffice,
--		--dbo.School(school_code, 'Principal')as Principal,
--		dbo.SchoolPrincipal(school_code,'Year','NameCall') as Principal,
--		dbo.SchoolAddress(school_code,'AddressFull') as School_Address,
-- *	from schools as S

select  dbo.SchoolType(school_code) as SchoolType,
		R.RegionBriefName as SchoolArea,
	    R.RegionName as School_Super,
		 case R.RegionBriefName
		when 'Area 01' then 'West'
		when 'Area 02' then 'West'
		when 'Area 03' then 'North'
		when 'Area 04' then 'North'
		when 'Area 05' then 'South' -- 'Centr' 20092010 
		when 'Area 06' then 'South' -- 'Centr' 20092010 
		when 'Area 07' then 'East' -- 'South' -- 20092010 
		when 'Area 08' then 'East' -- 'South' -- 20092010 
		when 'Area 09' then 'Center'  --  'East' -- 
		when 'Area 10' then 'Center'  -- 'East' 20092010 
		-- when 'Area 11' then 'East'   20092010 
		else '' end  as  District,
 		dbo.SchoolPrincipal(S.school_code,'Year','ID') as PrincipalID,
		dbo.SchoolAddress(S.school_code,'AddressFull') as SchoolAddress,
		L.Disable,
		S.school_code as SchoolCode,S.school_name as SchoolName, S.school_brief_name as BriefName,S.default_school_bsid as SchoolBSID, S.active_flag as ActiveFlag, S.last_update_date_time,
		'' as SchoolEmail,
		'' as SchoolPhone,
		'' as SchoolWebSite,
		'' as SchoolWord,
		Case left(S.School_code,2) when '05' then 'S' else 'E' end as Panel
 from schools as S
	inner join dbo.tcdsb_RSecurity_RegionLocations as L on S.school_code = L.LocationID
	inner join dbo.tcdsb_RSecurity_Regions as R on L.RegionID =R.RegionID
	where R.RegionType = 'Supt'
	
union
	select dbo.SchoolType(school_code) as SchoolType,
		'Area' as SchoolArea,
	    ''    as School_Super,
	    'Center'  as  District,
 		'0000' as PrincipalID,
		dbo.SchoolAddress( school_code,'AddressFull') as SchoolAddress,
		'0' as Disable,
		 school_code as SchoolCode,school_name as SchoolName,school_brief_name as BriefName,default_school_bsid as SchoolBSID,active_flag as ActiveFlag, last_update_date_time,
		 '' as SchoolEmail,
		'' as SchoolPhone,
		'' as SchoolWebSite,
		'' as SchoolWord ,
		Case left(School_code,2) when '05' then 'S' else 'E' end as Panel
		from schools
		where school_code  in ('XIEP','AS23')

	  

