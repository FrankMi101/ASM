











-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get Grade List by School
-- =====================================================================================
 
 
CREATE proc [dbo].[SIC_sys_TabList]   
        @Operate 	varchar(50),
		@UserID 	varchar(30)=null,
		@UserRole  	varchar(50) = null,
		@SchoolYear 	varchar(8) = null,
		@SchoolCode   	varchar(8) = null
as
set nocount on 
begin
	if @Operate =''
		select 'Tab1' as [Value],'New Tab' as [Name],'1' as orderby
	else if @Operate ='GradeTab'
		begin
			select Grade as [Value],  case  Grade when 'JK' then 'JK' when 'SK' then 'SK' else 'Gr. ' + Grade end as [Name] , case Grade when 'JK' then '1' when 'SK' then '2' else '3' end as orderby 
			from  [dbo].[tcdsb_SES_School_Grade]
			where school_year = @SchoolYear and school_code = @SchoolCode
			union 
			select '00' as  [Value], 'All Grade' as [Name], '4' as Ordrby 
			union 
			select '99' as  [Value], 'My Student' as [Name], '5' as Ordrby 

			order by orderby, [Value]
		end
	else if @Operate ='ClassTypeTab'
		begin
			if left(@SchoolCode,2) ='05'
				select 'Academic' as [Value], 'Academic Class' as [Name], '1' as orderby
				union
				select 'Applied' as [Value], 'Applied Class' as [Name], '2' as orderby
				union
				select 'SpecialEd' as [Value], 'Special Education class' as [Name], '3' as orderby
				union
				select 'Giftedness' as [Value], 'Giftedness Class' as [Name], '4' as orderby
				order by orderby
			else
				select 'Regular' as [Value], 'Regular Class' as [Name], '1' as orderby
 				union
				select 'SpecialEd' as [Value], 'Special Education class' as [Name], '2' as orderby
				union
				select 'Giftedness' as [Value], 'Giftedness Class' as [Name], '3' as orderby
				order by orderby
			
		end
	else if @Operate = 'StaffTab'
		select 'Teacher' as [Value], 'Teachers' as [Name], '1' as orderby
		union
		select 'Admin' as [Value], 'Administratros' as [Name], '2' as orderby
		union
		select 'Support' as [Value], 'Support Staff' as [Name], '3' as orderby
		union
		select 'Other' as [Value], 'Other Staff' as [Name], '4' as orderby
			order by orderby, [Value]
	else if @Operate = 'TPATab'
		select 'TPA' as [Value], 'No Evaluation Year' as [Name], '2' as orderby
		union
		select 'Evaluation' as [Value], 'Evaluation Year' as [Name], '1' as orderby
		union
		select 'NTP' as [Value], 'New Tecachers' as [Name], '3' as orderby
		union
		select 'LTO' as [Value], 'Long Term Occasional Teachers' as [Name], '4' as orderby
		union
		select 'Leave' as [Value], 'Leave Staffs' as [Name], '5' as orderby
		union
		select 'Ret' as [Value], 'Retirement Staffs' as [Name], '6' as orderby
			order by orderby, [Value]
	else if @Operate = 'GroupTab'
		select 'Grade' as [Value], 'Grade List' as [Name], '1' as orderby
		union
		select 'Course' as [Value], 'Course List' as [Name], '2' as orderby
		union
		select 'SPED' as [Value], 'Special Ed. Class' as [Name], '3' as orderby
	 	order by orderby, [Value]
	else if @Operate = 'PanelTab'
		select 'Elementary' as [Value], 'Elementary School' as [Name], '1' as orderby
		union
		select 'Secondary' as [Value], 'Secondary School' as [Name], '2' as orderby
		union
		select 'Department' as [Value], 'Department' as [Name], '3' as orderby
	 	order by orderby, [Value]
	else if @Operate = 'SecurityContentTab'
		select 'SAP' as [Value], 'SAP Information' as [Name], '1' as orderby
		union
		select 'SIS' as [Value], 'Student Information Class' as [Name], '2' as orderby
		union
		select 'APP' as [Value], 'Application Security Group' as [Name], '3' as orderby
	 	order by orderby, [Value]

	else if @Operate = 'PositionRoleMatchTab'
		select 'PositionDesc' as [Value], 'SAP Position Description' as [Name], '1' as orderby
		union
		select 'ClassDesc' as [Value], 'SAP Class Description' as [Name], '2' as orderby
 	else if @Operate = 'ReportTypeTab'
		select 'Report' as [Value], 'School Base Reports' as [Name], '1' as orderby
		union
		select 'Extract' as [Value], 'School Base Data Extract' as [Name], '2' as orderby
		union
		select 'Label' as [Value], 'School Base Label' as [Name], '3' as orderby
		order by orderby
	else
		select 'Teacher' as [Value], 'Teachers' as [Name], '1' as orderby
		union
		select 'Support' as [Value], 'Support Staff' as [Name], '2' as orderby
			order by orderby, [Value]
 end  

	 


--	 select * from tcdsb_tpa_school_Staff where school_year ='20202021' and school_code ='0529'

	  

