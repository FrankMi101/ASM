










 

 

-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: September 28, 2021  
-- Description	: get School default start date and End date
-- =====================================================================================
 
 
CREATE proc [dbo].[SIC_sys_SchoolDate]  
	@Operate		varchar(30),
	@UserID			varchar(30), 
	@SchoolCode		varchar(8) = null,
	@SchoolYear		varchar(8) = null 
as 

set nocount on
 
set  @SchoolYear = dbo.[Current.SchoolYear]('SIC')
	begin
		if exists (select 1 from dbo.SIC_sys_SchoolYear	where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode)
		   select top 1 dbo.DateF(StartDate,'YYYYMMDD')		as StartDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as EndDate 
				,dbo.DateF(getdate(),'YYYYMMDD')			as TodayDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode = @SchoolCode
		else
		   select top 1 dbo.DateF(StartDate,'YYYYMMDD')		as StartDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as EndDate 
				,dbo.DateF(getdate(),'YYYYMMDD')			as TodayDate
				,dbo.DateF(EndDate,'YYYYMMDD')				as CloseDate 
				from dbo.SIC_sys_SchoolYear
				where SchoolYear = @SchoolYear and SchoolCode in ('0204','0501') 
	end
