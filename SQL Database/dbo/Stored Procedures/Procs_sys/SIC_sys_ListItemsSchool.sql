








-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get DDL school list items 
-- =====================================================================================
 
-- drop  proc dbo.SIC_sys_ListItemsSchool  'SchoolList','mif','Admin','20202021','0361' ,'All' --, 'SpecialHealth', '0299' ,'Location' --  'Subactivity'   'Type'  --'Sponsor', 'Conference'
 CREATE  proc [dbo].[SIC_sys_ListItemsSchool] 
        @Operate 	varchar(50),
		@UserID 	varchar(30)=null,
		@Para1   	varchar(50) = null, -- user role
		@Para2   	varchar(50) = null, -- school year
		@Para3   	varchar(50) = null,  -- school code
		@Para4		varchar(50) = null    -- panel

as
set nocount on  
if @Para1 ='Admin'
	begin
		if left(@Para4,1) ='S'
			select School_Code as [Value], School_name as [Name] from dbo.SIC_sys_Schools
			where left(school_code,2 ) ='05' and active_flag ='x'  
			order by [Name]
		else if left(@Para4,1) ='E'
			select School_Code as [Value], School_name as [Name] from  dbo.SIC_sys_Schools
			where left(school_code,2 ) in ('02','03','04','XI','AS') and active_flag ='x'  
			order by [Name]
		else if @Para4 ='All'

			select '0000' as [Value],'TCDSB' as [Name], '0' as orderby
			union
			select '0001' as [Value],'-- Elementary Schools -- ' as [Name], '1' as orderby
			union
			select School_Code as [Value], School_name as [Name] , '1' as orderby from  dbo.SIC_sys_Schools
			where left(school_code,2 ) in  ( '02','03','04')   and active_flag ='x'   
 
			union
			select '0002' as [Value],'-- Secondary Schools -- ' as [Name], '2' as orderby
			union
			select School_Code as [Value], School_name as [Name]  , '2' as orderby  from  dbo.SIC_sys_Schools
			where left(school_code,2 ) in  ( '05')   and active_flag ='x'   
		 
			union
			select '0003' as [Value],'-- CEC Department -- ' as [Name], '3' as orderby
			union
			select School_Code as [Value], School_name as [Name], '3' as orderby   from  dbo.SIC_sys_Schools
			where left(school_code,2 ) not in  ( '02','03','04','05')   and active_flag ='x'   
			order by orderby,[Name]
			 
			  
	end
else if @Para1 in ('Principal','Teacher','SeTeacher')
	begin
		 
			select School_Code as [Value], School_name as [Name] from  dbo.SIC_sys_Schools
			where school_code =@Para3  
			order by [Name]

 
	end
	




