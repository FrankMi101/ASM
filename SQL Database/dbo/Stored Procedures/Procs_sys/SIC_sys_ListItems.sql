











-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get system DDL  list items 
-- =====================================================================================

 --[dbo].[SIC_sys_ListItems]  'AppRoleAvailable','mif','admin','20202021','0569'
CREATE proc [dbo].[SIC_sys_ListItems]  
        @Operate 	varchar(50),
		@UserID 	varchar(30)=null,
		@Para1   	varchar(50) = null,
		@Para2   	varchar(50) = null,
		@Para3   	varchar(50) = null,
		@Para4		varchar(50) = null
as
set nocount on 
begin
     declare @DDList as table
			([Value]   varchar(100),
			[Name]	varchar(500),
			orderBy   varchar(10)  )
  
	
		if @Operate =''
			insert into @DDList
			values('','','1')
		else if @Operate ='AccessScope'
			insert into @DDList
			select AccessScope, AccessScope, [Priority] 
			from  [dbo].[SIC_sys_AccessScope]  
			 
		else if @Operate ='AccessScopeValue'
			begin
				if @Para1 ='Board'
					insert into @DDList
					select '0000', 'All TCDSB Schools', 1 
				else if @Para1 ='Panel'
					insert into @DDList
					select 'E', 'All Elemantray Schools', 1 
					union 
					select 'S', 'All Secondary Schools', 2
				else 
					EXEC [dbo].[SIC_sys_ListItems]  @Para1,@UserID,@Para1,@Para2,@Para3,@Para4
			 
			end
		else if @Operate ='Age'
	  		insert into @DDList
			values( '18','18',1) ,('19','19',2)    
		else if @Operate ='AppRole'
			insert into @DDList
			select RoleID, RoleID,RolePriority from [dbo].[SIC_sys_UserRole]
		else if @Operate ='AppRoleAvailable'
			insert into @DDList
			select RoleID,RoleName, right('00' + cast(ROW_NUMBER() OVER(ORDER BY RoleName) as varchar(2)),2)
			from [dbo].[SIC_sys_UserRole]
			where  RoleID not in ('Admin','Director','Superintendent','Coordinator','AppOther')
			order by RoleName
		else if @Operate ='AppsGroupID'
			begin
				if @Para3 ='0000'  
					insert into @DDList
					select    GroupID, GroupName, '1' 
					from    [dbo].[SIC_sys_UserGroup_Members]   where AppID in ( @Para2,'SIC') and SchoolCode ='0000'
                else 
					begin						 
						insert into @DDList 
						select  distinct GroupID, GroupName, '2' from   [dbo].[SIC_sys_UserGroup_Members] 
						where AppID in ( @Para2,'SIC') and schoolCode = @Para3 -- and GroupID  not in (select [Value] from @DDList )
					end	 
			end
		else if @Para1 ='Area'
					insert into @DDList 
					select School_area, School_area, '1'
					from [dbo].[SIC_sys_SchoolAreas]
		
 		else if @Operate ='AppsModel'
			insert into @DDList
			select ModelID, ModelName, 0 from   [dbo].[SIC_sys_AppsModels] 
			where AppID  = @Para2
		else if @Operate ='AppsName'
			insert into @DDList
			select AppID, AppName, IDs from    [dbo].[SIC_sys_Apps] where ActiveFlag ='x'
		else if @Para1 ='Board'
			insert into @DDList 
			values( '0000','Board', '1' )
		else if @Operate ='Courses'
			begin
				if left(@Para2,2) ='05'
					insert into @DDList
					select distinct Class_code, Class_code, 0--  ROW_NUMBER() OVER(ORDER BY Class_code) as RowNo
					from [dbo].[SIC_sys_SchoolClasses_S]
					where school_year = @Para1 and school_code = @Para2 and Semester = @Para3  
				else
					insert into @DDList
					select distinct Class_code, Class_code, 0 -- ROW_NUMBER() OVER(ORDER BY Class_code) as RowNo
					from [dbo].[SIC_sys_SchoolClasses_E]
					where school_year =  @Para1 and school_code = @Para2 and Semester = @Para3  
			end
 		else if @Operate ='Class'
					insert into @DDList 
				   select distinct class_code, class_code, '1' from [dbo].[SIC_sys_SchoolClasses]
				   where school_year =@Para2 and school_code = @Para3 and full_name !='Closed'
		else if @Operate ='Course'
					insert into @DDList 
					select Course_Code, Course_Title ,'1' 
					from [dbo].[School.Courses] (@Para2,@Para3,'Y') 
		else if @Operate ='DemitReason'
			insert into @DDList
				 select '15 Days Absent','15 Days Absent', '1'--	15 Days Absent
			union select 'Apprentice.','Apprentice.', '2'--	Apprentice.
			union select 'Care,Treat,Corr','Care,Treat,Corr', '3'--	Care,Treat,Corr
			union select 'Cert. of Ed.','Cert. of Ed.', '3'--	Cert. of Ed.
			union select 'Cert. of Train.','Cert. of Train.', '4'--	Cert. of Train.
			union select 'College','College', '5'--	College
			union select 'Courts','Courts', '6'--	Courts
			union select 'Deceased','Deceased', '7'--	Deceased
			union select 'Demit Error','Demit Error', '8'--	Demit Error
			union select 'Educ Other Prov','Educ Other Prov', '9'--	Educ Other Prov
			union select 'Employ.-OSSD','Employ.-OSSD', '10'--	Employ.-OSSD
			union select 'Employ.-SSGD','Employ.-SSGD', '11'--	Employ.-SSGD
			union select 'Employment-CAN','Employment-CAN', '12'--	Employment-CAN
			union select 'Employment-ON','Employment-ON', '13'--	Employment-ON
			union select 'Employment-OTH','Employment-OTH', '14'--	Employment-OTH
			union select 'English-French','English-French', '15'--	English-French
			union select 'Expelled','Expelled', '16'--	Expelled
			union select 'Extend. Vac.','Extend. Vac.', '17'--	Extend. Vac.
			union select 'French-English','French-English', '18'--	French-English
			union select 'From NS & SS','From NS & SS', '19'--	From NS & SS
			union select 'Home','Home', '20'--	Home
			union select 'HomeSch','HomeSch', '21'--	HomeSch
			union select 'Never Attended','Never Attended', '22'--	Never Attended
			union select 'No Diploma/Cert.','No Diploma/Cert.', '23'--	No Diploma/Cert.
			union select 'OSSD','OSSD', '24'--	OSSD
			union select 'SSGD','SSGD', '25'--	SSGD
			union select 'SSHGD','SSHGD', '26'--	SSHGD
			union select 'Other','Other', '30'--	Other
			union select 'Other Board','Other Board', '31'--	Other Board
			union select 'Other Country','Other Country', '32'--	Other Country
			union select 'Other Province','Other Province', '33'--	Other Province
			union select 'Post Sec O/Cntry','Post Sec O/Cntry', '34'--	Post Sec O/Cntry
			union select 'Post Sec O/Prov ','Post Sec O/Prov ', '35'--	Post Sec O/Prov 
			union select 'Private School','Private School', '36'--	Private School
			union select 'Recvd COA','Recvd COA', '37'--	Recvd COA
			union select 'Recvd Diploma','Recvd Diploma', '38'--	Recvd Diploma
			union select 'Recvd OSSC','Recvd OSSC', '39'--	Recvd OSSC
			union select 'Ret-Unknown','Ret-Unknown', '40'--	Ret-Unknown
			union select 'Ryerson','Ryerson', '50'--	Ryerson
			union select 'This Board','This Board', '51'--	This Board
			union select 'University','University', '52'--	University
			union select 'Unknown','Unknown', '53'--	Unknown
			union select 'Work','Work', '54'--	Work
		else if @Operate ='District'
			insert into @DDList
				select 'W','West Area','1'
				union
				select 'N','North Area','2'
				union
				select 'S','South Area','3'
				union
				select 'E','East Area','4'
				union
				select 'C','Central Area','5'
		else if @Operate ='EnrolmentType'
			insert into @DDList
			select '1','Entry','1'
			union
			select '2','Enrolment','2'
			union
			select '3','Funding','3'
			union
			select '4','Arrival','4'
			union
			select '5','Departure','5'
 
		else if @Operate ='EntryTypeName'
			insert into @DDList
				  select 'Admissions','Admissions', '1'--	Admissions
			union select 'Beginner','Beginner', '2'--	Beginner
			union select 'Care Treat Corr','Care Treat Corr', '3'--	Care/Treat/Corr
			union select 'Day Care','Day Care', '4'--	Day Care
			union select 'Demit Error','Demit Error', '5'--	Demit Error
			union select 'Error Demit','Error Demit', '6'--	Error Demit
			union select 'Extend Vacation','Extend Vacation', '7'--	Extend Vacation
			union select 'Home Schooling','Home Schooling', '8'--	Home Schooling
			union select 'HomeSch','HomeSch', '9'--	HomeSch
			union select 'Native Ed. Auth','Native Ed. Auth', '10'--	Native Ed. Auth
			union select 'Other','Other', '11'--	Other
			union select 'Other Board','Other Board', '12'--	Other Board
			union select 'Other Province','Other Province', '13'--	Other Province
			union select 'Other Country','Other Country', '14'--	Other Country
			union select 'Private School','Private School', '15'--	Private School
			union select 'Re-Entrant','Re-Entrant', '16'--	Re-Entrant
			union select 'Returning','Returning', '17'--	Returning
			union select 'This Board','This Board', '18'--	This Board
			union select 'Vacation','Vacation', '19'--	Vacation
			union select 'Unknown','Unknown', '20'--	Unknown
		else if @Operate ='FundingSourceType'
			insert into @DDList
				 select 'Board','Board', '1'--	Board
			union select 'Gov-Can','Gov-Can', '2'--	Gov-Can
			union select 'Gov-Ont','Gov-Ont', '3'--	Gov-Ont
			union select 'Other','Other', '4'--	Other
			union select 'Out-Can','Out-Can', '5'--	Out-Can
			union select 'Person','Person', '6'--	Person
			union select 'Stu-Visa','Stu-Visa', '7'--	Stu-Visa

		else if @Operate ='Grade'
			insert into @DDList
			select Grade,  case Grade when 'JK' then 'JK' when 'SK' then 'SK' else  'Gr.'+ Grade end , 
			 case Grade when 'JK' then '100' when 'SK' then '200' else '3'+ Grade end
			from  [dbo].[SIC_sys_SchoolGrade]
			where schoolyear = @Para2 and schoolcode = @Para3
		else if @Operate ='GroupType'
			begin
				if @Para3 = '0000'
					insert into @DDList 
					select  distinct GroupType, GroupType, '1' from   [dbo].[SIC_sys_UserGroup_Members] 
					where AppID ='SIC' and schoolCode = '0000'  and GroupType ! = 'Schools'
				else
					insert into @DDList 
					select  distinct GroupType, GroupType, '1' from   [dbo].[SIC_sys_UserGroup_Members] 
					where AppID ='SIC' and schoolCode = '0000'  and GroupType  in ('School','Grade','Class','Student')

			end

 		else if @Para1 ='Panel'
					insert into @DDList 
					values( 'E','E', '1' ),('S','S','2')
		else if @Operate ='School'
			insert into @DDList
			select  school_code, school_name,'0' 
			from dbo.schools where left(school_Code,1 ) ='0'
		else if @Operate ='ListSchool'
			insert into @DDList
			select  school_code, school_name,'0' 
			from dbo.schools where left(school_Code,1 ) ='0'
		else if @Operate ='ListSchoolCode'
			insert into @DDList
			select  school_code, school_code,'0' 
			from dbo.schools where left(school_Code,1 ) ='0'

		else if @Operate ='MatchRole'
			insert into @DDList
			select RoleID, RoleName,RolePriority from [dbo].[SIC_sys_UserRole] where RoleType ='SAP'
		else if @Operate ='Program'
			insert into @DDList
			values( 'Gift','Gift',1) ,('IEP','IEP',2),('IPRC','IPRC',3),('Alternative','Alternative',4)  
		else if @Operate ='RegisterCode'
			insert into @DDList
				  select 'CEA','CEA', '1'--	CEA
			union select 'CEC','CEC', '3'--	CEC
			union select 'CELN','CELN', '4'--	CELN
			union select 'CES','CES', '5'--	CES
			union select 'FT','FT', '6'--	FT
			union select 'HT','HT', '7'--	HT
			union select 'IS','IS', '8'--	IS
			union select 'NA','NA', '1'--	NA
			union select 'PT','PT', '10'--	PT
		else if @Operate ='Report&Form'
			insert into @DDList
			select  ReportID, [Name],IDs from [dbo].SIC_sys_ReportsManagement

		else if @Operate ='ReportPeriod'
					insert into @DDList 
					select Mark_code, Mark_title ,'1'   
					From [dbo].[School.Marks.Period] (@Para2,@Para3) 
		else if @Operate ='SchoolArea'
  				 insert into @DDList
				select distinct SchoolArea, schoolArea, schoolArea from [dbo].[SIC_sys_SchoolsView] 
		else if @Operate ='SchoolBSID'
			insert into @DDList
			select default_school_bsid,default_school_bsid,'0'
			from dbo.schools where left(school_Code,1 ) ='0'
		else if @Operate ='SchoolStaff'
			begin
				if @Para3 ='0000'
					insert into @DDList
					select userID, LastName + ', ' + FirstName + ' (' + [dbo].[Staff.Role.SAP](userID) + ')', '1'
					from dbo.SIC_sys_Employee 
					where left(SchoolCode,2) not in ('02','03','04','05')  and userid is not null
				else
					insert into @DDList
					select userID, LastName + ', ' + FirstName + ' (' + [dbo].[Staff.Role.SAP](userID) + ')', '1'
					from dbo.SIC_sys_Employee 
					where SchoolCode = @Para3 and userid is not null
			end
		else if @Operate ='SchoolYear'
  				 insert into @DDList
				 select distinct SchoolYear, schoolyear ,'1' 
				 from [dbo].[SIC_sys_SchoolYear]
				 Where schoolcode in ('0204','0505')
		else if @Operate ='SchoolYearTrack'
			insert into @DDList
			select 'All Day','All Day', '1'--	All Day
			union select 'AM','AM', '2'--	AM
			union select 'PM','PM', '3'--	PM
			union select 'Regular','Regular', '4'--	Regular
			union select 'SAll Day','SAll Day', '5'--	SAll Day
			union select 'SAM','SAM', '6'--	SAM
			union select 'SPM','SPM', '7'--	SPM
			union select 'TMarian','TMarian', '8'--	TMarian
			union select 'Zapple','Zapple', '9'--	Zapple
			union select 'Zcico','Zcico', '10'--	Zcico		 
		else if @Operate ='StudentMember'
			begin
				insert into @DDList 
				values('','','0')
				if @Para1 ='Grade'
					begin
						if @Para3 ='0000'
							insert into @DDList 
							select  distinct Grade, Grade, '1'  from [dbo].[SIC_sys_SchoolGrade]
							where schoolyear = @Para2 and schoolcode in ('0204','0501')
						else
							insert into @DDList 
							select  distinct Grade, Grade, '1'  from [dbo].[SIC_sys_SchoolGrade]
							where schoolyear = @Para2 and schoolcode = @Para3
					end
				if @Para1 ='School'
					insert into @DDList 
				   select top 1 schoolCode,schoolCode, '1' from  [dbo].[SIC_sys_SchoolsView]
				   where  schoolCode = @Para3 
				if @Para1 ='Board'
					insert into @DDList 
				   values( '0000','0000', '1' )
 				if @Para1 ='Panel'
					insert into @DDList 
					values( 'E','E', '1' ),('S','S','2')
 				if @Para1 ='Area'
					insert into @DDList 
					select School_area, School_area, '1'
					from [dbo].[SIC_sys_SchoolAreas]
			end
		else if @Operate ='UserGroup'
				 insert into @DDList
				 select distinct GroupID, GroupName,IDs  
				 from [dbo].[SIC_sys_UserGroup_Members]  
				 where  AppID = @Para4 and SchoolCode = @Para3 and Active_flag ='X'


		else if @Operate ='UserRole'
				 insert into @DDList
				 select distinct  RoleID,RoleID , case RoleID when 'Other' then 0 else 1 end  
				 from  [dbo].[SIC_sys_UserRole_Apps] where  AppID ='SIC'

 

	select distinct * from @DDList
	order by orderBy, [Name]
 
 end  

	    
					 

