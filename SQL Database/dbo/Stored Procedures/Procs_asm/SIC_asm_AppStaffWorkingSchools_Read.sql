


 


-- =====================================================================================
-- Author		: Frank Mi
-- Create date	: Sept 23, 2021  
-- Description	: get staff work school selected
-- =====================================================================================

CREATE  proc [dbo].[SIC_asm_AppStaffWorkingSchools_Read] -- 'ListbyRanger','mif','','','Center'
	@Operate		varchar(30) =null,
	@UserID			varchar(30) =null,
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode	 	varchar(20) = null,  -- SchoolCode ==> RangerArea
	@StaffUserID	varchar(30) = null
as 

set nocount on

declare @SelectSchool as table
(SchoolCode	varchar(8),
SchoolName varchar(500),
Selected	varchar(20),
Panel		varchar(10))

if @Operate ='ListbyRanger'  	
	insert into @SelectSchool
	select   SchoolCode
			,SchoolName 
			,[dbo].[Staff.WorkSchool.IsSelected](@SchoolYear,SchoolCode,@StaffUserID) as Selected
			,[dbo].[School.Panel](SchoolCode) as Panel			 
	from [dbo].[SIC_sys_SchoolsView]	
	where District = @SchoolCode
 
else if @Operate ='List'
	insert into @SelectSchool
	select   SchoolCode
			,SchoolName 
			,[dbo].[Staff.WorkSchool.IsSelected](@SchoolYear,SchoolCode,@StaffUserID) as Selected
			,[dbo].[School.Panel](SchoolCode) as Panel	
	from 	 [dbo].[SIC_sys_SchoolsView]	 
 
else
	insert into @SelectSchool
	select   SchoolCode
			,SchoolName 
			,[dbo].[Staff.WorkSchool.IsSelected](@SchoolYear,SchoolCode,@StaffUserID) as Selected
			,[dbo].[School.Panel](SchoolCode) as Panel	
	from 	 [dbo].[SIC_sys_SchoolsView]	
	where District = @SchoolCode
	 
select *
  ,ROW_NUMBER() OVER(ORDER BY Selected Desc , Panel, SchoolName) AS RowNo 	
  from @SelectSchool
  order by RowNo

