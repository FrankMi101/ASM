









-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================

 
CREATE  proc [dbo].[SIC_sys_MenuOfStudentList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@StudentID		varchar(15) = null 

as 

set nocount on 
  
 select Ptop, Pleft,Pheight,Pwidth, Category, MenuID, [Name],[Type],Orderby,
 case [dbo].[Student.Tasks.Completed]( MenuID, @SchoolYear,@SchoolCode,@StudentID) when 'Completed' then 'done-' + rtrim([image]) else [image] end as  [Image]

 from  dbo.SIC_sys_MenuListOfStudent  
 where [dbo].[Teacher.Student.Permission](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID) = 'Allow'
 order by  Category, Orderby

