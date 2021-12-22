





 


-- drop  proc dbo.SIC_sys_ListofSchools  'SchoolList','mif','admin','20202021','000','Elementary' ,'Name', '' 
 CREATE proc [dbo].[SIC_sys_ListofSchools] 
        @Operate		varchar(30),
		@UserID 		varchar(30)=null,
		@UserRole	   	varchar(50) = null,
		@SchoolYear		varchar(8) = null, --  School area 
 		@SchoolCode		varchar(8) = null, --   School_year
 		@Grade			varchar(20) = null, --   School_year
		@SearchBy	 	varchar(30) = null,
		@SearchValue 	varchar(50) = null 

as
set nocount on  

declare @SchoolsTable as table
(	SchoolCode varchar(8),
	SchoolArea	varchar(10)
)

if @UserRole ='Admin'
	begin
		if @Grade ='Secondary'
			insert into @SchoolsTable
			select SchoolCode, SchoolArea  --  as Code, School_name as [Name] 
			from  [dbo].[SIC_sys_SchoolsView]
			where left(SchoolCode,2 ) ='05' and ActiveFlag ='x'  and SchoolArea like (@SchoolCode +'%')
		else if @Grade ='Elementary'
		   	insert into @SchoolsTable
			select SchoolCode, SchoolArea  --  as Code, School_name as [Name] 
			from  [dbo].[SIC_sys_SchoolsView]
			where left(SchoolCode,2 ) in ('02','03','04','XI','AS') and ActiveFlag ='x'    and SchoolArea like (@SchoolCode +'%')

		else if @Grade ='Department'
				select SchoolCode as Code , SchoolArea	from  [dbo].[SIC_sys_SchoolsView]
			where left(SchoolCode,2 ) not in ('02','03','04','05','XI','AS')   and ActiveFlag ='x'     and SchoolArea like (@SchoolCode +'%')
	end
else if @UserRole in ('Principal','Teacher','SeTeacher')
	begin
		 insert into @SchoolsTable
			select SchoolCode, SchoolArea  --  as Code, School_name as [Name] 
			from  [dbo].[SIC_sys_SchoolsView]
			where  SchoolCode =@SchoolCode
 
	end
	


select 
S.SchoolCode,S.SchoolBSID, S.SchoolName, S.BriefName,S. SchoolArea, School_super as SchoolSuper, SchoolType,
[dbo].[School.Principal.Name](S.SchoolCode,'Name') as PrincipalName,

S.BriefName +'@tcdsb.org' as  SchoolEmail,  '(416)393-' + s.SchoolCode  as  SchoolPhone,  'https://www.tcdsb.org/' + S.BriefName as   SchoolWebSite ,'' as Comments,
[dbo].[ActionTask.School]('TaskMenu',@UserID, @UserRole, @SchoolYear, S.Schoolcode, S.SchoolName) as Actions,
case ActiveFlag when 'X' then 'true' else 'false' end as ActiveFlag,
	 	 ROW_NUMBER() OVER(ORDER BY  S.SchoolName ) AS RowNo 
from  [dbo].[SIC_sys_SchoolsView] as S
inner join @SchoolsTable			as T on S.schoolCode =T.SchoolCode
order by SchoolName	 


