


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Oct 15, 2020  
-- Description	: get system DDL  list items 
-- =====================================================================================

  --[dbo].[SIC_sys_GeneralList]   'ClassList','mif','admin','20202021','0531',1,1
 
CREATE proc [dbo].[SIC_sys_GeneralList]    
        @Operate 	varchar(50),
		@UserID 	varchar(30)	= null,
		@UserRole 	varchar(30)	= null,
		@SchoolYear	varchar(8)	= null,
		@SchoolCode	varchar(8)	= null,
		@Para1   	varchar(50) = null,
		@Para2   	varchar(50) = null,
		@Para3   	varchar(50) = null 
as
set nocount on 
begin
 
 
        declare @DDList as table
			([Value]   varchar(30),
			[Name]	varchar(250),
			orderBy   int )
	

		if @Operate ='UserRole'
				 insert into @DDList
				 select distinct RoleID,RoleName, IDs from [dbo].[SIC_sys_UserRole]
		else if @Operate ='SchoolYear'
  				 insert into @DDList
				 values('20182019','20182019',1), ( '20192020','20192020',2 ), ('20202021','20202021',3)  
		else if @Operate ='SchoolList'
  			begin
				if @SchoolCode ='S'
					insert into @DDList
					select School_Code as Code, School_name as [Name],  ROW_NUMBER() OVER(ORDER BY School_name) as RowNo
					from dbo.tcdsb_Ses_schools
					where left(school_code,2 ) ='05' and active_flag ='x'  
					order by RowNo
				else if @SchoolCode ='E'
					insert into @DDList
					select School_Code as Code, School_name as [Name], ROW_NUMBER() OVER(ORDER BY School_name) as RowNo
					from dbo.tcdsb_Ses_schools
					where left(school_code,2 ) in ('02','03','04','XI','AS') and active_flag ='x'  
					order by RowNo
				else  -- ES
					insert into @DDList
					select School_Code as Code, School_name as [Name], ROW_NUMBER() OVER(ORDER BY School_name) as RowNo
					from dbo.tcdsb_Ses_schools
					where left(school_code,1 ) in ('0','X','A') and active_flag ='x'  
					order by RowNo
			end
				 
		else if @Operate ='Age'
	  		insert into @DDList
			values( '18','18',1) ,('19','19',2)  
		else if @Operate ='Program'
			insert into @DDList
			values( 'Gift','Gift',1) ,('IEP','IEP',2),('IPRC','IPRC',3),('Alternative','Alternative',4)  
 		else if @Operate ='Grade'
			insert into @DDList
			select Grade,  case Grade when 'JK' then 'JK' when 'SK' then 'SK' else  'Gr.'+ Grade end , 
			 case Grade when 'JK' then '100' when 'SK' then '200' else '300'+ Grade end
			from [dbo].[tcdsb_SES_School_Grade]
			where school_year = @SchoolYear and school_code = @SchoolCode
 		else if @Operate ='Courses'
			begin
				if left(@SchoolCode,2) ='05'
					insert into @DDList
					select distinct Class_code, Class_code, 0--  ROW_NUMBER() OVER(ORDER BY Class_code) as RowNo
					from [dbo].[SIC_sys_SchoolClasses_S]
					where school_year = @SchoolYear and school_code = @SchoolCode and Semester = @Para1 and Term = @Para2
				else
					insert into @DDList
					select distinct Class_code, Class_code, 0 -- ROW_NUMBER() OVER(ORDER BY Class_code) as RowNo
					from [dbo].[SIC_sys_SchoolClasses_E]
					where school_year =  @SchoolYear and school_code = @SchoolCode and Semester = @Para1 and Term = @Para2
			end

	select distinct * from @DDList
	order by orderBy , [Name]
 
 end  

	  


	  

