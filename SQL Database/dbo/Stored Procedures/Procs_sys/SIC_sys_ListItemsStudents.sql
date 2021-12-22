


-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 23, 2020  
-- Description:	 get DDL Student list items 
-- =====================================================================================
 
-- drop  proc dbo.SIC_sys_ListItemsSchool  'SchoolList','careys02','admin','20192020','Secondary' ,'20182019' --, 'SpecialHealth', '0299' ,'Location' --  'Subactivity'   'Type'  --'Sponsor', 'Conference'
 create   proc [dbo].[SIC_sys_ListItemsStudents] 
        @Operate 	varchar(50),
		@UserID 	varchar(30)=null,
		@Para1   	varchar(50) = null, -- user role
		@Para2   	varchar(50) = null, -- school year
		@Para3   	varchar(50) = null,  -- school code
		@Para4		varchar(50) = null    -- Grade

as
set nocount on  

select person_id as Code , Student_Name as [Name]
from dbo.tcdsb_SES_Students
where school_year =@Para2 and school_code = @Para3 and grade = @Para4
 



