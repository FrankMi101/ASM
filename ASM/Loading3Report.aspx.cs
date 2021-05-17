using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;
namespace ASM
{
    public partial class Loading3Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                var parameter = new MenuListParameter
                {
                    Operate = Page.Request.QueryString["area"],
                    UserID = User.Identity.Name,
                    UserRole = Page.Request.QueryString["uRole"],
                    SchoolYear = Page.Request.QueryString["sYear"],
                    SchoolCode = Page.Request.QueryString["sCode"],
                    Grade = Page.Request.QueryString["grade"],
                    StudentID = Page.Request.QueryString["sID"],
                    PageID = Page.Request.QueryString["pageID"],
                    Term = Session["Term"].ToString(),
                    Category = Page.Request.QueryString["category"],

                };


                var myGoPageItem = AppsPage.GoPageItemsList<GoPageItems>(parameter)[0];
                string reportingService = myGoPageItem.PageSite;
                string reportPath = myGoPageItem.PagePath;
                string reportName = myGoPageItem.PageFile;
                string PagePara = myGoPageItem.PagePara;

                var myParameter = GetReportParameter(parameter);
                Byte[] myReport = null;
                try
                {
                    myReport = ReportRender.GetReportR3(reportingService, reportPath, reportName, "PDF", myParameter);              
                }
                catch (Exception ex)
                {
                     NotPDFReport.Text = "Can't find the Report -- " + reportName + " at " + reportPath;
                   NotPDFReport.Visible = true;
                }

                // add password to the PDF file. it works
                // *************************if necessaray ********************************************************************************
                // Byte[] myReportWithPW = ReportRender.AddPWtoPDFMemory(myReport, parameter.StudentID, null);

                try
                {
                    // *************************if necessaray ********************************************************************************
                    // send a email with attachment of myReport 
                   // SendtheReportAsAttachment(myReportWithPW, parameter.StudentID + "_IEP_Report.pdf", "application/pdf");
                }
                catch (Exception ex)
                { }

                try
                {    // *************************if necessaray *****************************************************
                    // save encrypted report 
                  //  SavePDF(myReportWithPW, parameter.SchoolYear, parameter.SchoolCode, parameter.Grade, parameter.StudentID, "IEPReports");
                }
                catch (Exception ex)
                { }
                 // ***************************************************************************************************************************
                try
                {
                    if (myReport.Length < 100)
                        NotPDFReport.Visible = true;
                    else
                         ReportRender.RenderDocument(myReport, reportName, "PDF");
                      //  ReportRender.RenderDocument(myReportWithPW, reportName, "PDF");

                }
                catch (Exception ex)
                {
                     NotPDFReport.Text = "Can't find the Report -- " + reportName + " at " + reportPath;
                   NotPDFReport.Visible = true;
                }


            }
        }
        private void SendtheReportAsAttachment(Byte[] pdfReport, string fileName, string fileType)
        {
            try
            {
                var myMail = new EmailNotice
                {
                    EmailTo = "mif@tcdsb.org",
                    EmailBody = "This is Test IEP Report as Attachment from Memory stream",
                    EmailFormat = "HTML",
                    EmailFrom = "mif@tcdsb.org",
                    EmailSubject = "Student IEP Report",
                    EmailType = "Notice",
                    FileMemory = pdfReport,
                    FileName = fileName,
                    FileType = fileType
                };
                eMailNotification.SendMail(myMail);
            }
            catch (Exception ex)
            { }

        }
        private void SavePDF(Byte[] pdfReport, string schoolYear, string schoolCode, string grade, string studentID, string AppID)
        {
            try
            {
                string fileServer = WebConfig.getValuebyKey("PDFFileSavePath");
                string fileName = grade + "_" + studentID + "_IEPReport" + ".pdf";
                string filePath = $@"{fileServer}\{AppID}\{schoolYear}\{schoolCode}";
                //   string filePath = fileServer + @"\" + AppID + @"\" + schoolYear + @"\" + schoolCode;

                //  filePath = filePath.Replace(@"\\", @"\");

                ReportRender.SavePDFReport(pdfReport, fileName, filePath);
            }

            catch (Exception ex)

            {
            }

        }
        private List<ReportParameter> GetReportParameter(MenuListParameter parameter)
        {

            var myParameter = new List<ReportParameter>();


            switch (parameter.PageID)
            {

                case "OfficeIndexCard":
                    myParameter.Add(ReportRender.GetParameter(1, "SchoolYear", parameter.SchoolYear));
                    myParameter.Add(ReportRender.GetParameter(2, "SchoolCode", parameter.SchoolCode));
                    myParameter.Add(ReportRender.GetParameter(3, "PersonID", parameter.StudentID));

                    break;
                case "AlternativeRCPDF":
                    myParameter.Add(ReportRender.GetParameter(1, "userid", User.Identity.Name));
                    myParameter.Add(ReportRender.GetParameter(2, "school_year", parameter.SchoolYear));
                    myParameter.Add(ReportRender.GetParameter(3, "school_code", parameter.SchoolCode));
                    myParameter.Add(ReportRender.GetParameter(4, "person_id", parameter.StudentID));
                    myParameter.Add(ReportRender.GetParameter(5, "terms", Session["Term"].ToString()));
                    myParameter.Add(ReportRender.GetParameter(6, "semester", Session["Semester"].ToString()));

                    break;
                case "GiftPDF":
                    myParameter.Add(ReportRender.GetParameter(1, "userid", User.Identity.Name));
                    myParameter.Add(ReportRender.GetParameter(2, "school_year", parameter.SchoolYear));
                    myParameter.Add(ReportRender.GetParameter(3, "school_code", parameter.SchoolCode));
                    myParameter.Add(ReportRender.GetParameter(4, "person_id", parameter.StudentID));
                    myParameter.Add(ReportRender.GetParameter(5, "terms", Session["Term"].ToString()));
                    break;
                case "IEPPDF":
                    myParameter.Add(ReportRender.GetParameter(1, "PersonID", parameter.StudentID));
                    myParameter.Add(ReportRender.GetParameter(2, "SchoolYear", parameter.SchoolYear));
                    myParameter.Add(ReportRender.GetParameter(3, "SchoolCode", parameter.SchoolCode));
                    myParameter.Add(ReportRender.GetParameter(4, "Term", Session["Term"].ToString()));
                    break;
                case "StudentTimeTable":
                    myParameter.Add(ReportRender.GetParameter(1, "UserID", parameter.StudentID));
                    myParameter.Add(ReportRender.GetParameter(2, "SchoolYear", parameter.SchoolYear));
                    myParameter.Add(ReportRender.GetParameter(3, "SchoolCode", parameter.SchoolCode));
                    myParameter.Add(ReportRender.GetParameter(4, "Grade", parameter.Grade));
                    myParameter.Add(ReportRender.GetParameter(5, "PersonID", parameter.StudentID));

                    break;
                default:
                    myParameter.Add(new ReportParameter() { ParaName = "SchoolYear", ParaValue = parameter.SchoolYear });
                    myParameter.Add(new ReportParameter() { ParaName = "SchoolCode", ParaValue = parameter.SchoolCode });
                    myParameter.Add(new ReportParameter() { ParaName = "StudentID", ParaValue = parameter.StudentID });
                    break;
            }


            return myParameter;
        }
    }
}