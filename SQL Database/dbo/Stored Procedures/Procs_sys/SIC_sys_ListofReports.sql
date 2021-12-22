




 


  

-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 07, 2021  
-- Description:	 get student list
-- =====================================================================================
 
-- drop  proc dbo.SIC_sys_ListofClasses  '' ,'mif','admin','20202021','0569','Regular' , 'Course','','School','','1','1'

CREATE   proc [dbo].[SIC_sys_ListofReports]  
	@Operate		varchar(30),
	@UserID			varchar(30),
	@UserRole		varchar(30) = null,
	@SchoolYear		varchar(8) = null,
	@SchoolCode		varchar(8) = null,
	@Grade			varchar(20) = null, -- JK/SK,Gr.01 --Gr.12, 00 -- All, 99 -- My Students
	@SearchBy	 	varchar(30) = null,
	@SearchValue 	varchar(50) = null  
 
as 

set nocount on

declare @RelationBy  varchar(20) ,@IPRC varchar(10),@IEP varchar(10),@ITFcode varchar(10)
declare @RelationValue varchar(50)	
 
set @SearchValue = @SearchValue +'%'
 if left(@SchoolCode,2) ='05' 
			select distinct 
				  ReportID,
				  ReportTitle,
				  ReportName,
				  ReportType,
 				  ' comments '  as Comments,
 				 [dbo].[ActionTask.Report]('Parameter',@UserID, @UserRole,@schoolYear, @SchoolCode,Category,ReportID,ReportName,ReportTitle,ReportType) as Actions,
	 			 ROW_NUMBER() OVER(ORDER BY SeqNo ) AS RowNo 
 		     from  dbo.SIC_sys_Reports  
			 where  Panel in ('S','S/E') and ActiveFlag = 'x' 
			order by RowNo 	
else
			select distinct 
				  ReportID,
				  ReportTitle,
				  ReportName,
				  ReportType,
 				  ' comments '  as Comments,
 				  [dbo].[ActionTask.Report]('Parameter',@UserID, @UserRole,@schoolYear, @SchoolCode,Category,ReportID,ReportName,ReportTitle,ReportType) as Actions,
	 			 ROW_NUMBER() OVER(ORDER BY SeqNo ) AS RowNo 

			 from  dbo.SIC_sys_Reports  
			 where  Panel in ('E','S/E') and ActiveFlag = 'x' 
			order by RowNo 	
 
 
 
