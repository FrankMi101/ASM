

 


-- =====================================================================================
-- Author:		Frank Mi
-- Create date: April 7, 2021  
-- Description:	 get system DDL  list items 
-- =====================================================================================
 
 
CREATE proc [dbo].[SIC_sys_ListItems_UDTT]   
	@Operate		as varchar(30) =null,
	@UserID			as varchar(30) = null,
	@MyParameter	as dbo.GeneralParameter  READONLY
  
as
set nocount on 
begin
      declare  @Para1 varchar(50),	@Para2   varchar(50),@Para3   varchar(50),@Para4 varchar(50) 
	  select top 1 @Para1 = Para1, @Para2 = Para2, @Para3 = Para3, @Para4 = Para4
	  from @MyParameter

        declare @DDList as table
			([Value]   varchar(30),
			[Name]	varchar(500),
			orderBy   varchar(10)  )
	

		if @Operate ='UserRole'
				 insert into @DDList
				 select distinct GroupID,GroupID, 1 from dbo.tcdsb_SES_user 
		else if @Operate ='SchoolYear'
  				 insert into @DDList
				 values('20182019','20182019',1), ( '20192020','20192020',2 ), ('20202021','20202021',3)  
		else if @Operate ='SchoolArea'
  				 insert into @DDList
				select distinct SchoolArea, schoolArea, schoolArea from [dbo].[SIC_sys_SchoolsView] 
		else if @Operate ='Age'
	  		insert into @DDList
			values( '18','18',1) ,('19','19',2)  
		else if @Operate ='Program'
			insert into @DDList
			values( 'Gift','Gift',1) ,('IEP','IEP',2),('IPRC','IPRC',3),('Alternative','Alternative',4)  
 		else if @Operate ='Grade'
			insert into @DDList
			select Grade,  case Grade when 'JK' then 'JK' when 'SK' then 'SK' else  'Gr.'+ Grade end , 
			 case Grade when 'JK' then '100' when 'SK' then '200' else '3'+ Grade end
			from [dbo].[tcdsb_SES_School_Grade]
			where school_year = @Para1 and school_code = @Para2
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
		else if @Operate ='AppsName'
			insert into @DDList
			select AppID, AppName, IDs from    [dbo].[SIC_sys_Apps] where ActiveFlag ='x'
 
		else if @Operate ='AppsGroupID'
			begin
				 
				insert into @DDList
				select  GroupID, GroupName, IDs from   [dbo].[SIC_sys_UserGroup] where AppID in ( @Para2,'SIC')
				insert into @DDList 
				select  GroupID, GroupName, IDs from   [dbo].[SIC_sys_UserGroup_Members] 
				where AppID in ( @Para2,'SIC') and schoolCode = @Para3 and GroupID not in (select GroupID from @DDList )

			end

	select * from @DDList
	order by orderBy, [Name]
 
 end  

	   

	  

