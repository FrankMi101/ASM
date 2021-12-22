



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================

--			  [dbo].[SIC_sys_ActionMenuList] 'SecurityContentList' ,'mif','Admin','20202021','0531','11','GLs40A-01','1','1'
CREATE  proc [dbo].[SIC_sys_ActionMenuList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null ,
	@TabID			varchar(20) = null, 
	@ObjID			varchar(50) = null,    -- Student ID
	@AppID			varchar(20) =null,
	@Semester		varchar(1) = null,
	@Term			varchar(1) = null
as 

set nocount on 

--select * from     dbo.SIC_sys_MenuListCatelog where Area = @Operate

if  @Operate = 'StudentListPage' 
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type] , C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby, 
	 case [dbo].[Student.Tasks.Completed]( MenuID, @SchoolYear,@SchoolCode,@ObjID) when 'Completed' then 'done-' + rtrim(M.[image]) else M.[image] end as  [Image]

	 from  dbo.SIC_sys_MenuListOfStudent  as M
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area =   @Operate
 	 where [dbo].[Teacher.Permission.Student](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 order by  Orderby

else if @Operate ='GroupListPage'
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type] ,  C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby, 
	 case [dbo].[Student.Tasks.Completed]( MenuID, @SchoolYear,@SchoolCode,@ObjID) when 'Completed' then 'done-' + rtrim(M.[image]) else M.[image] end as  [Image]
	 from  dbo.SIC_sys_MenuListOfGroup as M 
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area = @Operate
	 where [dbo].[Teacher.Permission.Student](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 order by  Orderby

else if @Operate ='ClassListPage'
 	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type] ,  C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby, 
	 case [dbo].[Student.Tasks.Completed]( MenuID, @SchoolYear,@SchoolCode,@ObjID) when 'Completed' then 'done-' + rtrim(M.[image]) else M.[image] end as  [Image]
	 from  dbo.SIC_sys_MenuListOfClass as M 
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area = @Operate
	 where [dbo].[Teacher.Permission.Student](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 order by  Orderby
	 
else if @Operate = 'StaffListPage'
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type] ,  C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby 
	 from  [dbo].[SIC_sys_MenuListOfStaff] as M
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area = @Operate
	 where [dbo].[Teacher.Permission.Staff](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 order by orderby

else if @Operate = 'TPAListPage'
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type], C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby 
	 from  [dbo].[SIC_sys_MenuListOfTPAList] as M
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area =   @Operate
	 where  [dbo].[Teacher.Permission.Staff](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 order by orderby

else if @Operate ='SecurityContentList'
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type],  C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby 
	 from  [dbo].[SIC_sys_MenuListOfSecurityList] as M
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area =   @Operate
	 where  [dbo].[Teacher.Permission.Staff](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	 and C.category = case @TabID when 'SIS' then 'Class Information' when 'APP' then 'Security Group' else '' end
	 order by orderby

else if @Operate ='SecurityGroupManage'
	 select    Ptop, Pleft,Pheight,Pwidth, C.Category, MenuID, [Name], M.[Image],[Type],  C.Area, @AppID as AppID,
	 case [Site] when '' then 'InApp' else 'OutApp' end as AppSource, cast(C.orderby as varchar(2)) + '-' + cast( M.OrderBy as varchar(2)) as  Orderby 
	 from  [dbo].[SIC_sys_MenuListOfSecurityList] as M
	 inner join dbo.SIC_sys_MenuListCatelog as C on C.category =M.Category and C.Area =   @Operate
	 where  [dbo].[Teacher.Permission.Staff](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@TabID,@ObjID) = 'Allow'
	-- and C.category = case @TabID when 'SIS' then 'Class Information' when 'APP' then 'Security Group' else '' end
	 order by orderby	 
