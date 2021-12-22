

 


-- drop  proc dbo.tcdsb_LTO_ListSchools  'SchoolList','careys02','admin','20192020','Secondary' ,'20182019' --, 'SpecialHealth', '0299' ,'Location' --  'Subactivity'   'Type'  --'Sponsor', 'Conference'
 CREATE proc [dbo].[SIC_sys_SchoolList] 
        @Operate		varchar(30),
		@UserID 		varchar(30)=null,
		@UserRole	   	varchar(50) = null,
		@SchoolYear		varchar(8) = null, --  School area 
 		@SchoolCode		varchar(8) = null, --   School_year
 		@Panel			varchar(20) = null --   School_year

as
set nocount on  
if @UserRole ='Admin'
	begin
		if @Panel ='Secondary'
			select School_Code as Code, School_name as [Name] from tcdsb_Ses_schools
			where left(school_code,2 ) ='05' and active_flag ='x'  
		else if @Panel ='Elementary'

			select School_Code as Code, School_name as [Name] from tcdsb_Ses_schools
			where left(school_code,2 ) in ('02','03','04','XI','AS') and active_flag ='x'  
		else if @Panel ='SSchool'
				select School_Code as Code, School_name as [Name] from tcdsb_Ses_schools
			where left(school_code,1 ) != '0'   and active_flag ='x'   
	end
else if @UserRole in ('Principal','Teacher','SeTeacher')
	begin
		 
			select School_Code as Code, School_name as [Name] from tcdsb_Ses_schools
			where school_code =@SchoolCode  
 
	end
	




