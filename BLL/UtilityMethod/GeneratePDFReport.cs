
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace BLL
{
    public class GeneratePDFReport
    {
        public static Byte[] GetOneReport2(InputArg parameter, ReportBase reportPara)
        {
            var reportParameters = BuildReportingParameters.GetReportParameter(reportPara.ReportType, parameter);

            return getPDFReport(reportPara, reportParameters);
        }
        public static Byte[] GetOneReport(ReportBase reportPara, InputArg parameter)
        {
            var reportParameters = GetSpecificReportParamaters.GetReportParameters(reportPara.ReportType, parameter);
           // var reportParameters = BuildReportingParameters.GetReportParameter(reportPara.ReportType, parameter);
          

            return getPDFReport(reportPara, reportParameters);
        }

        public static Byte[] GetMultipleReports(ReportBase reportPara, List<InputArg> myList)
        {
            Document doc = new Document();
            MemoryStream msOutput = new MemoryStream();
            PdfCopy pCopy = new PdfSmartCopy(doc, msOutput); // using iTextSharp pdf function
            doc.Open();
            foreach (var item in myList)
            {
                try
                {
                    Byte[] myPDF = GetOneReport(reportPara, item); // item  => InputArg
                    if (myPDF.Length > 10)
                    {
                        AddFileToPCopy(ref pCopy, myPDF);
                    }
                }
                catch { }
            }
            try
            {
                pCopy.Close();
                doc.Close();
            }
            catch { }

            return msOutput.ToArray();
        }
        private static void AddFileToPCopy(ref PdfCopy pCopy, byte[] pdfFile)
        {
            MemoryStream stream1 = new MemoryStream(pdfFile);
            PdfReader pdfFile1 = new PdfReader(stream1.ToArray());
            for (int i = 1; i <= pdfFile1.NumberOfPages; i++)
            {
                pCopy.AddPage(pCopy.GetImportedPage(pdfFile1, i));
            }
            pdfFile1.Close();
        }
  
        private static Byte[] getPDFReport(ReportBase reportPara, List<ReportParameter> _reportParameter)

        {
            //  Byte[] result;
            try
            {
                ReportingWebService.ReportExecutionService RS = new ReportingWebService.ReportExecutionService();
                //  CredentialCache cache = new CredentialCache();
                string accessUser = WebConfigurationManager.AppSettings["WebServiceUser"];// WebConfig.ReportUser();
                string accessRWSPW = WebConfigurationManager.AppSettings["WebServiceWP"];//  WebConfig.ReportPW();
                string accessDomain = WebConfigurationManager.AppSettings["NetWorkDomain"];//  WebConfig.DomainName();
                                                                                           //  string reportingServices = WebConfigurationManager.AppSettings["ReportingService"];// WebConfig.ReportServices(); 
                                                                                           //  string reportPath = WebConfigurationManager.AppSettings["ReportPathWS"];//  WebConfig.ReportPathWS()  + "/" + _reportName;
                string format = reportPara.ReportFormat;

                RS.Url = reportPara.ReportService;
                RS.Credentials = new System.Net.NetworkCredential(accessUser, accessRWSPW, accessDomain);

                string report = reportPara.ReportPath + reportPara.ReportName;


                string historyID = null;
                string devInfo = "<DeviceInfo><Toolbar>False</Toolbar></DeviceInfo>";

                string encoding = "";
                string mimeType = "";
                ReportingWebService.Warning[] warnings = new ReportingWebService.Warning[0];
                string[] streamIDs = null;


                ReportingWebService.ServerInfoHeader sh = new ReportingWebService.ServerInfoHeader();
                RS.ServerInfoHeaderValue = sh;

                var rptParameters = GetReportingServiceParameters(_reportParameter);

                ReportingWebService.ExecutionInfo execInfo = new ReportingWebService.ExecutionInfo();
                ReportingWebService.ExecutionHeader execHeader = new ReportingWebService.ExecutionHeader();

                execInfo = RS.LoadReport(report, historyID);

                RS.SetExecutionParameters(rptParameters, "en-us");

                string extension = "";
                string SessionId = RS.ExecutionHeaderValue.ExecutionID;
                return RS.Render(format, devInfo, out extension, out encoding, out mimeType, out warnings, out streamIDs);

            }
            catch (Exception ex)
            {
                string error = ex.Message;
                return new Byte[0];
            }
        }
        //private static string getReportLocation(string reportName, string locationType)
        //{
        //    if (locationType == "Service") return WebConfigurationManager.AppSettings["ReportingService"];
        //    switch (reportName)
        //    {
        //        case "IEP":
        //        case "IEPReport":
        //            return "SES_Reports/IEP/Production";
        //        case "SSF":
        //        case "SSForm":
        //            return "SES_Reports/SSForm/Production";
        //        default:
        //            return "TC_Report/Production";
        //    }
        //}
        private static ReportingWebService.ParameterValue[] GetReportingServiceParameters(List<ReportParameter> _reportParameter)
        {
            int pLeng = _reportParameter.Count;

            ReportingWebService.ParameterValue[] rptParameters = new ReportingWebService.ParameterValue[pLeng];

            int i = 0;
            foreach (var item in _reportParameter)
            {
                rptParameters[i] = new ReportingWebService.ParameterValue()
                {
                    Name = item.ParaName,
                    Value = item.ParaValue.ToString()
                };
                i += 1;
            }
            return rptParameters;
        }

    }
}
