



-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 25, 2020  
-- Description:	 get student list
-- =====================================================================================


-- drop  proc dbo.SIC_sys_ActionMenu_GoPage 'MultipleReport' ,'mif','Admin','20202021','0325','02', '0000202211','IEP' ,'1'

CREATE  proc [dbo].[SIC_sys_ActionMenu_GoPage]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(10) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@StudentID	 	varchar(100) = null,
	@PageID 		varchar(50) = null,
	@Term			varchar(10) = null ,
	@Category		varchar(100) = null ,
	@AppID			varchar(20) =  null,
	@GroupID		varchar(200) = null,
	@MemberID		varchar(100) = null
	 
as 

set nocount on

declare  @Permission varchar(20) 
if @Operate ='StudentListPage'
	begin
		set @Permission  = (select top 1 [dbo].[Teacher.Student.Permission](@PageID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID)  
										from [dbo].[SIC_sys_MenuListOfStudent]
										where MenuID = @PageID )
									 
		if  @Permission ='Allow'
			 select  top 1  [Site]  as PageSite ,
					 [path]			as PagePath ,
					 [Name]	,MenuID, [Type],
					 case [Page] when 'NameFunction' then [dbo].[Student.GoPage.Name](MenuID,@SchoolYear,@SchoolCode,@Grade,@Term)
								 else [Page]		 end	as PageFile,
			  case  MenuID  when 'GiftRC'		 then '?school_Year=' + @SchoolYear + '&school_code=' + @SchoolCode + '&person_id=' + @StudentID + '&userid=' +  @UserID  
							when 'AlternativeRC' then '?school_Year=' + @SchoolYear + '&school_code=' + @SchoolCode + '&person_id=' + @StudentID + '&userid=' +  @UserID  
							when 'IEPPDF2'		 then '?PersonID='    + @StudentID  + '&SchoolYear='  + @SchoolYear + '&SchoolCode=' + @SchoolCode + '&Term=' +  @Term  
												 else '?Source=SIC&UserID=' + @UserID + '&UserRole=' + @UserRole + '&SchoolYear=' + @SchoolYear + '&SchoolCode=' + @SchoolCode + '&Grade=' + @Grade + '&StudentID=' + @StudentID
												 end   as PagePara
			 from [dbo].[SIC_sys_MenuListOfStudent]
			 where menuID =     @PageID
		else
			select '' as PageSite, ''	as PagePath,  
			'NotAllowView.aspx'			as Pagefile , 
			 [Name]	,MenuID, [Type],
			'?Reason=you have no access permission on the selected student ' + @StudentID + ' ' +  @PageID +  '!'  as PagePara 
			 from [dbo].[SIC_sys_MenuListOfStudent]
			 where menuID =  @PageID
	end
else if @Operate ='SecurityContentList'
	begin
		set @Permission  = (select top 1 [dbo].[Teacher.Student.Permission](@PageID,[Level], @UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID)  
										from [dbo].[SIC_sys_MenuListOfSecurityList]
										where MenuID = @PageID )
									 
		if  @Permission ='Allow'
			 select  top 1  [Site]  as PageSite ,
					 [path]			as PagePath ,
					 [Name]	,MenuID, [Type],
					 case [Page] when 'NameFunction' then [dbo].[Student.GoPage.Name](MenuID,@SchoolYear,@SchoolCode,@Grade,@Term)
								 else [Page]		 end	as PageFile,
			       '?Source=SIC&UserID=' + @UserID + '&UserRole=' + @UserRole + '&SchoolYear=' + @SchoolYear + '&SchoolCode=' + @SchoolCode + '&Grade=' + @Grade + '&ObjID=' + @StudentID + '&AppID=' + @AppID + '&Action=' + PageAction  + '&GroupID=' + isnull(@GroupID,'') + '&MemberID=' + isnull(@MemberID,'')
					as PagePara
			  from   [dbo].[SIC_sys_MenuListOfSecurityList]  
			 where menuID =     @PageID
		else
			select '' as PageSite, ''	as PagePath,  
			 [Name]	,MenuID, [Type],
			'NotAllowView.aspx'			as Pagefile , 
			'?Reason=you have no access permission on the selected student ' + @StudentID + ' ' +  @PageID +  '!'  as PagePara 
			 from [dbo].[SIC_sys_MenuListOfSecurityList]
			 where menuID =  @PageID
	end
else if @Operate ='MultipleReport'
	begin
		select  top 1 ReportType as [Type],ReportID,ReportService  as PageSite, FilePath as PagePath ,
					 case [fileName] when 'NameFunction' then [dbo].[Report.Name.ByGradeandTerm](ReportID,@SchoolYear,@SchoolCode,@Grade,@Term)
									 else [fileName]	 end	as PageFile 
	    from  dbo.SIC_sys_ReportsManagement  
		where ReportID = @PageID

	end
