





-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_StudentList '' ,'mif','admin','20192020','0325','00', 'SurName','','School'

CREATE  proc [dbo].[SIC_sys_GoPageOfSchoolLevel]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@PageID 		varchar(50) = null 

as 

set nocount on

 select 'NotAllowView.aspx?Reason=you have no access permission on the student ' + @PageID + '!'

