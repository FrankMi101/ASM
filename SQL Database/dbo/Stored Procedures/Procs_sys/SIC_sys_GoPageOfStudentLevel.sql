








-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_GoPageOfStudentLevel '' ,'mif','Admin','20192020','0325','02', '0000202','Gift' ,'School'

CREATE  proc [dbo].[SIC_sys_GoPageOfStudentLevel]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@StudentID	 	varchar(30) = null,
	@PageID 		varchar(50) = null,
	@Term			varchar(10) = null 
	 
as 

set nocount on

declare  @Permission varchar(20) 
set @Permission  = (select top 1 [dbo].[Teacher.Student.Permission](@PageID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID)  
								from [dbo].[SIC_sys_MenuListOfStudent]
								where MenuID = @PageID )
								 
if  @Permission ='Allow'
	 select  top 1  [Site]  as PageSite ,
	         [path]			as PagePath ,
			 [Name]	,MenuID, [Type],
			 case [Page] when 'NameFunction' then [dbo].[Student.GoPage.Name](MenuID,@SchoolYear,@SchoolCode,@Grade,@Term)
						 else [Page]		 end	as PageFile,

	  case  MenuID  when 'Gift'			 then '?school_Year=' + @SchoolYear + '&school_code=' + @SchoolCode + '&person_id=' + @StudentID + '&userid=' +  @UserID  
	                when 'AlternativeRC' then '?school_Year=' + @SchoolYear + '&school_code=' + @SchoolCode + '&person_id=' + @StudentID + '&userid=' +  @UserID  
	                when 'IEPPDF2'		 then '?PersonID='    + @StudentID + '&SchoolYear=' + @SchoolYear + '&SchoolCode=' + @SchoolCode + '&Term=' +  @Term  
										 else '?SchoolYear=' + @SchoolYear + '&SchoolCode=' + @SchoolCode + '&Grade=' + @Grade + '&StudentID=' + @StudentID  end   as PagePara
	 from [dbo].[SIC_sys_MenuListOfStudent]
	 where menuID =     @PageID
else
	select '' as PageSite, ''	as PagePath,  
	'NotAllowView.aspx'			as Pagefile , 
	 [Name]	,MenuID, [Type],
	'?Reason=you have no access permission on the selected student ' + @StudentID + ' ' +  @PageID +  '!'  as PagePara 
	 from [dbo].[SIC_sys_MenuListOfStudent]
	 where menuID =  @PageID
