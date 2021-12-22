








-- =====================================================================================
-- Author:		Frank Mi
-- Create date: November 26, 2020  
-- Description:	 get student list
-- =====================================================================================

 
CREATE proc [dbo].[SIC_sys_MenuOfStaffList]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Type			varchar(30) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@EmployeeID		varchar(20) = null 

as 

set nocount on
  
 select    Ptop, Pleft,Pheight,Pwidth,Category, MenuID, [Name], [Image],[Type] , Orderby
 from  dbo.SIC_sys_MenuListOfStudent  
 where [dbo].[Teacher.Student.Permission](menuID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@Type,@EmployeeID) = 'Allow'
 order by Category, orderby
  

