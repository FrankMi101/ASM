










-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================

 
CREATE  proc [dbo].[SIC_sys_MenuOfGroupList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@TabID			varchar(20) = null, 
	@SelectedObjID	varchar(50) = null,
	@Semester		varchar(1) = null ,
	@Term			varchar(1) = null 

as 

set nocount on 
  
 select Ptop, Pleft,Pheight,Pwidth, Category, MenuID, [Name],[Type],Orderby,
 case [dbo].[Student.Tasks.Completed]( MenuID, @SchoolYear,@SchoolCode,@SelectedObjID) when 'Completed' then 'done-' + rtrim([image]) else [image] end as  [Image]

 from  dbo.SIC_sys_MenuListOfGroup  
 where [dbo].[Teacher.Student.Permission](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@SelectedObjID,@Semester) = 'Allow'
 order by  Category, Orderby

