





-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: April 02, 2021  
-- Description	: get staff Secrity set up content 
-- =====================================================================================

-- drop  proc dbo.SIC_sys_ListofStaffsSecurityContent 'SchoolYearDate' ,'mif','Support','20202021','0393' ,'00007742'

CREATE proc [dbo].[SIC_sys_SchoolDateList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null 
as 

set nocount on
  if @Operate ='SchoolYearDate'
	begin
		--if exists (select 1 from dbo.SIC_sys_SchoolYear	where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode)
		--   select top 1  StartDate, EndDate, getdate() as TodayDate,EndDate as CloseDate 
		--   from dbo.SIC_sys_SchoolYear
		--   where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode
		--else
		--	select top 1  StartDate, EndDate, getdate() as TodayDate,EndDate as CloseDate 
		--	from dbo.SIC_sys_SchoolYear
		--	where SchoolYear = @SchoolYear and SchoolCode in ('0204','0501')
	 
		if exists (select 1 from dbo.SIC_sys_SchoolYear	where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode)
		   select top 1 dbo.DateF(StartDate,'YYYY-MM-DD')		as StartDate
				,dbo.DateF(EndDate,'YYYY-MM-DD')				as EndDate 
				,dbo.DateF(getdate(),'YYYY-MM-DD')			as TodayDate
				,dbo.DateF(EndDate,'YYYY-MM-DD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode
		else
		   select top 1 dbo.DateF(StartDate,'YYYY-MM-DD')			as StartDate
				,dbo.DateF(EndDate,'YYYY-MM-DD')				as EndDate 
				,dbo.DateF(getdate(),'YYYY-MM-DD')			as TodayDate
				,dbo.DateF(EndDate,'YYYY-MM-DD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode in ('0204','0501') 
	 
	end
