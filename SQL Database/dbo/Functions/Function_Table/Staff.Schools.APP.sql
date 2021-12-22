

-- ============================================================================
-- Author:		Frank Mi
-- Create date: March 21, 2021  
-- Description:	Get  Staff school list user ID  and Role
-- =============================================================================  

CREATE FUNCTION [dbo].[Staff.Schools.APP]
	(	@UserID		varchar(20) ,
		@AppID		varchar(10) ,
		@UserRole	varchar(20) ,
		@SchoolYear	varchar(8)
	 )
RETURNS @Schools  TABLE 
		(School_year	varchar(8),
		 school_code	varchar(8),
		 scope_source	varchar(50),
		 WorkingRole	varchar(20),
		 GroupScope		varchar(50),
		 RoleScope		varchar(50),
		 WorkingScope	varchar(50),
		 ScopeValue		varchar(50)
		)
AS 
BEGIN 
	-- Step 1 Get Staff SAP and working Schools
  	 insert into @Schools
	 select distinct @SchoolYear,SchoolCode ,'SAP Locations',@UserRole,'','','',''
	 from [dbo].[Staff.Schools.SAP](@UserID)

	-- Step 2 Get User working schools based on the AppID
	 insert into @Schools
	 select  @SchoolYear,GroupID ,'User Woring School',@UserRole,'','','',''
	 from [dbo].[SIC_sys_UserWorkingSchools]
	 where SchoolYear = @SchoolYear and GroupType ='School' and UserID = @UserID  and AppID = @AppID and  ActiveFlag ='X' and getdate() between StartDate and EndDate 
	       and GroupID not in (select school_code from @Schools)
 
 	-- Step 3 Get Group type from user Working school, User Assigned Group, and User Role assign access type  
    declare @GroupAccessScope varchar(20) , @RoleAccessScope varchar(20), @WorkingAccessScope varchar(20), @AccessScope varchar(20), @ScopeValue varchar(30)

	set @WorkingAccessScope = (select top 1 GroupType 
								from [dbo].[SIC_sys_UserWorkingSchools]
								where SchoolYear = @SchoolYear and UserID = @UserID and GroupType !='School' and  ActiveFlag ='X')

	set @GroupAccessScope = [dbo].[Staff.Assign.GroupType](@UserID,@AppID,@SchoolYear)
	 
	set @RoleAccessScope = [dbo].[Staff.Role.Scope](@UserRole, @AppID)  -- (select top 1  AccessScope from [dbo].[SIC_sys_UserRole]  where RoleID = @UserRole)

	--  Step 4 Get High priority access scope type  and Value
	if isnull(@GroupAccessScope,'')  = '' 
		begin
			set @AccessScope = (select    top 1 AccessScope
							 from [dbo].[SIC_sys_AccessScope]
							 where AccessScope in ( @GroupAccessScope,@RoleAccessScope,@WorkingAccessScope )
							 order by [Priority]
							 )
			set @ScopeValue =  case @AccessScope when 'Area'	then  [dbo].[Staff.Area](@UserID)
												 when 'Panel'	then  [dbo].[Staff.Panel](@UserID)
 												 when 'Board'	then  '0000'
												 else [dbo].[Staff.School](@UserID)
												 end
		end
	else
		begin
			set @AccessScope =  @GroupAccessScope
			set @ScopeValue =  [dbo].[Staff.Assign.GroupValue](@UserID,@AppID)
		end


	-- Step 5  Get School list by access type
	begin
		if @AccessScope = 'Feeders' 
			insert into @Schools
			select  @SchoolYear, F.FeederSchool, @AccessScope,@UserRole,@GroupAccessScope,@RoleAccessScope,@WorkingAccessScope,@ScopeValue
			from [dbo].[SIC_sys_UserGroup_FeederSchools] as F  
			where SchoolYear = @SchoolYear  and SchoolCode = @ScopeValue
			and F.FeederSchool not in (select school_code from @Schools)	 

			--inner join [dbo].[SIC_sys_UserGroup_FeederSchoolTeachers]	as T on F.SchoolYear =T.SchoolYear and F.SchoolCode = T.SchoolCode 
			--where T.SchoolYear = @SchoolYear and  T.MemberID = @UserID
			--and F.FeederSchool not in (select school_code from @Schools)	 
		else if @AccessScope = 'Area' 
			insert into @Schools
			select @SchoolYear, Schoolcode ,@AccessScope  ,@UserRole,@GroupAccessScope,@RoleAccessScope,@WorkingAccessScope,schoolArea
			from  [dbo].[SIC_sys_SchoolsView]
			where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5')  
			 and schoolArea in (select MemberID from [dbo].[Staff.Assign.GroupValues](@UserID,@AppID)) --  = @ScopeValue -- [dbo].[Staff.Area](@UserID)
			 and SchoolCode not in (select school_code from @Schools)
		else if @AccessScope = 'Panel'
 			insert into @Schools
			select @SchoolYear, Schoolcode, @AccessScope ,@UserRole,@GroupAccessScope,@RoleAccessScope,@WorkingAccessScope,@ScopeValue
			from [dbo].[SIC_sys_SchoolsView]
			where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5') and SchoolType =  @ScopeValue -- [dbo].[Staff.Panel](@UserID)
			 and SchoolCode not in (select school_code from @Schools)
		else if @AccessScope = 'Board' 
 			insert into @Schools
			select @SchoolYear, Schoolcode, @AccessScope ,@UserRole,@GroupAccessScope,@RoleAccessScope,@WorkingAccessScope,@ScopeValue
			from [dbo].[SIC_sys_SchoolsView]
			where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5')
			and SchoolCode not in (select school_code from @Schools)
	end
 
	Return 
 End

 /*
 if exists (select * from [dbo].[SIC_sys_UserRole] where (RoleID = @UserRole and AccessScope ='Board') or @GroupAccessScope ='Board')
		insert into @Schools
		select @SchoolYear, Schoolcode from [dbo].[SIC_sys_SchoolsView]
		where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5') 
	else if exists (select * from [dbo].[SIC_sys_UserRole] where ( RoleID = @UserRole and AccessScope ='Panel' )  or @GroupAccessScope ='Panel')
		insert into @Schools
		select @SchoolYear, Schoolcode from [dbo].[SIC_sys_SchoolsView]
		where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5')  and SchoolType = [dbo].[Staff.Panel](@UserID)
	else if exists(select * from [dbo].[SIC_sys_UserRole] where  (RoleID = @UserRole and AccessScope ='Area')  or @GroupAccessScope ='Area')
		insert into @Schools
		select @SchoolYear, Schoolcode from  [dbo].[SIC_sys_SchoolsView]
		where left(schoolcode,2) in ('02','03','04','05','AS','XI','C5')  and schoolArea = [dbo].[Staff.Area](@UserID)
	else if exists (select * from [dbo].[SIC_sys_UserRole] where (RoleID = @UserRole and AccessScope ='Feeders') or @GroupAccessScope ='Feeders')
		insert into @Schools
		select @SchoolYear, F.FeederCode
		from [dbo].[SIC_sys_UserGroup_FeederSchools]				as F   
		inner join [dbo].[SIC_sys_UserGroup_FeederSchoolTeachers]	as T on F.SchoolYear =T.SchoolYear and F.SchoolCode = T.SchoolCode 
		where T.MemberID = @UserID 	 
	else if exists(select * from [dbo].[SIC_sys_MultipleSchool_User] where UserID = @UserID )
		begin
			insert into @Schools
			select @SchoolYear, GroupID
			from [dbo].[SIC_sys_MultipleSchool_User]
			where UserID = @UserID and GroupType ='School'
		end
   else 
		insert into @Schools
		select @SchoolYear,SchoolCode
		from [dbo].[Staff.Schools.SAP](@UserID)
 */

