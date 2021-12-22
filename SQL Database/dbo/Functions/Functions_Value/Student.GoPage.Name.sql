





-- =====================================================================================
-- Author:		Frank Mi
-- Create date: June 26, 2020  
-- Description:	 get report name by grade and year
-- =====================================================================================

CREATE FUNCTION [dbo].[Student.GoPage.Name] 
(@ReportType		varchar(30),
@SchoolYear varchar(8),
@SchoolCode varchar(20),
@Grade		varchar(10),
@Term		varchar(10)
)
RETURNS  varchar(250) 
AS 
  BEGIN
     declare @rValue varchar(250)   
	if @ReportType in ('IEPPDF','IEPPDF2' )
		begin
			set  @rValue = 	(select  top 1 Report_Name as rValue
							from  dbo.tcdsb_IEP_ReportFormatByYearGrade 
							where school_year =@SchoolYear and Grade = case @Grade when '09' then 'Gr.09-12' 
													 when '10' then 'Gr.09-12'
													 when '11' then 'Gr.09-12' 
													 when '12' then 'Gr.09-12'
											 else 'Gr.01-08' end )
		end
    
	else if @ReportType ='IPRCSummary'
        set  @rValue = 	  'IPRC300' 
	else if @ReportType ='IntakeForm'
         set  @rValue =  'SSF010'  
	else if @ReportType ='CCForm'
         set  @rValue =  'SSF113' 
	else if @ReportType ='SBSTForm'
         set  @rValue =  'SSF111' 
	else if @ReportType ='SBSLTForm'
         set  @rValue =  'SSF114' 
   
	else if @ReportType ='OfficeIndexCard'
        set  @rValue =  'office_index_card2' 
  
	else if @ReportType ='GiftRCPDF'
         set  @rValue =  'gifted_program'  
	else if @ReportType ='GiftRC2PDF'
         set  @rValue =  'gifted_program'  
 
	else if @ReportType ='AlternativeRCPDF'
		begin
 
			 if  @Term='1'
				 set  @rValue =  'Alter_report1_Term_1_2' 
			 else if @Term ='2'    
				  set  @rValue =  'Alter_report1_Term_1_2'  
			 else
				  set  @rValue =  'Alter_report1_Term_Progress'
		end

	else if @ReportType ='GSERC'
		begin
			 set  @rValue = dbo.tcdsbeprc_report_fn_alter_report_version (@Schoolyear,@Schoolcode, '000000000',@Term,'1')
		 
		end

 	RETURN(@rValue)
  END



