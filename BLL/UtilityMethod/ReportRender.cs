using ClassLibrary;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Web.Configuration;

namespace BLL
{

    public class ReportRenderADO
    {
        public ReportRenderADO()
        {
        }

        public static void setParameterArray(MyADO.MyParameterRS[] _ParaArray, int X, string _Name, string _Value)
        {
            try
            {
                _ParaArray[X] = new MyADO.MyParameterRS();
                _ParaArray[X].pName = _Name;
                _ParaArray[X].pValue = _Value;
            }
            catch (Exception ex)
            {
                string error = ex.Message;
            }
        }
        public static void RenerReport(string _reportName,string _reportFormat, byte[] pdffile)
        {
            try
            {
                HttpContext.Current.Response.AppendHeader("content-disposition", "filename=" + _reportName + "." + _reportFormat);
                HttpContext.Current.Response.ContentType = getReportContentType(_reportFormat);
                HttpContext.Current.Response.OutputStream.Write(pdffile, 0, pdffile.GetLength(0));
                HttpContext.Current.Response.End();

            }
            catch (Exception ex)
            {
                string showmsg = ex.Message;
            }
        }

        public static void RenderReport(string _reportName, MyADO.MyParameterRS[] _reportParameter)
        {
            try
            {
                string rFormat = WebConfigurationManager.AppSettings["ReportFormat"];//  WebConfig.ReportFormat();
                Byte[] result = GetReportR2(_reportName, _reportParameter);
                RenerReport(_reportName, rFormat, result);
            }
            catch (Exception ex)
            {
                string showmsg = ex.Message;
            }

        }

        public static void RenderReport(string _reportName, string _reportFormat, List<ReportParameter> myParameter)
        {
            try
            {
                Byte[] result = GetReportR2(_reportName, _reportFormat, myParameter);

                if (result.Length != 0)
                {
                    RenerReport(_reportName, _reportFormat, result);
                }
                else
                {
                    HttpContext.Current.Response.Redirect("PDFPageFile2.aspx?");
                }
            }
            catch (Exception ex)
            {
                string showmsg = ex.Message;
            }

        }

        public static void RenderDocument(Byte[] _document, string _reportName, string _reportFormat)
        {
            try
            {
                string fileName = $"filename= { _reportName }" + getFileExtension(_reportFormat);

                HttpContext.Current.Response.AppendHeader("content-disposition", fileName);  // "filename=" + _reportName + ".xls");
                HttpContext.Current.Response.ContentType = getReportContentType(_reportFormat);
                // output the actual document contents to the response output stream
                HttpContext.Current.Response.OutputStream.Write(_document, 0, _document.GetLength(0));
                // end the response
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            catch (Exception ex)
            {
                string error = ex.Message;

            }

        }
        public static void ShowPDFWithItxt(Byte[] pdfDocument)
        {
            HttpContext.Current.Response.ContentType = "application/pdf";
            HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=IEP_Report.pdf");
            HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);

            Document doc = new Document();
            MemoryStream msOutput = new MemoryStream(pdfDocument);
            //           PdfCopy pCopy;
            PdfCopy pCopy = new PdfSmartCopy(doc, msOutput);
            doc.Open();

            MemoryStream stream1 = new MemoryStream(pdfDocument);
            MemoryStream output = new MemoryStream();

            PdfReader input = new PdfReader(stream1.ToArray());


            var pdfDoc = new Document();

            PdfWriter.GetInstance(pdfDoc, HttpContext.Current.Response.OutputStream);
            pdfDoc.Open();
            pdfDoc.Close();

            HttpContext.Current.Response.Write(pdfDoc);
            HttpContext.Current.Response.End();
        }
        public static Byte[] GetReportR2(string _reportName, MyADO.MyParameterRS[] _reportParameter)

        {
            Byte[] result;
            try
            {

                ReportingWebService.ReportExecutionService RS = new ReportingWebService.ReportExecutionService();
                //  CredentialCache cache = new CredentialCache();


                string accessUser = WebConfigurationManager.AppSettings["WebServiceUser"];// WebConfig.ReportUser();
                string accessRWSPW = WebConfigurationManager.AppSettings["WebServiceWP"];//  WebConfig.ReportPW();
                string accessDomain = WebConfigurationManager.AppSettings["NetWorkDomain"];//  WebConfig.DomainName();
                string reportingServices = WebConfigurationManager.AppSettings["ReportingService"];// WebConfig.ReportServices();
                                                                                                   // string currentDB = DBConnectionHelper.CurrentDB();
                string report = WebConfigurationManager.AppSettings["ReportPathWS"] + "/" + _reportName;//  WebConfig.ReportPathWS()  + "/" + _reportName;
                string format = WebConfigurationManager.AppSettings["ReportFormat"];//  WebConfig.ReportFormat();


                RS.Url = reportingServices;
                RS.Credentials = new System.Net.NetworkCredential(accessUser, accessRWSPW, accessDomain);


                string historyID = null;
                string devInfo = "<DeviceInfo><Toolbar>False</Toolbar></DeviceInfo>";

                string encoding = "";
                string mimeType = "";
                ReportingWebService.Warning[] warnings = new ReportingWebService.Warning[0];
                string[] streamIDs = null;


                ReportingWebService.ServerInfoHeader sh = new ReportingWebService.ServerInfoHeader();   //'ServerInfoHeader  
                RS.ServerInfoHeaderValue = sh;  //'ServerInfoHeaderValue = sh  
                                                // ReportingWebService.Warning warning = new ReportingWebService.Warning();

                int pLeng = _reportParameter.Length;
                ReportingWebService.ParameterValue[] rptParameters = new ReportingWebService.ParameterValue[pLeng];

                int i = 0;
                foreach (MyADO.MyParameterRS para in _reportParameter)
                {
                    rptParameters[i] = new ReportingWebService.ParameterValue();
                    rptParameters[i].Name = para.pName;
                    rptParameters[i].Value = para.pValue.ToString();
                    i += 1;
                }

                // ReDim rptParameters(cnt - 1)


                ReportingWebService.ExecutionInfo execInfo = new ReportingWebService.ExecutionInfo();
                ReportingWebService.ExecutionHeader execHeader = new ReportingWebService.ExecutionHeader();


                execInfo = RS.LoadReport(report, historyID);

                RS.SetExecutionParameters(rptParameters, "en-us");

                string extension = "";
                string SessionId = RS.ExecutionHeaderValue.ExecutionID;
                //   Console.WriteLine("SessionID: {0}", RS.ExecutionHeaderValue.ExecutionID);

                result = RS.Render(format, devInfo, out extension, out encoding, out mimeType, out warnings, out streamIDs);

                return result;

            }
            catch (Exception ex)
            {
                string error = ex.Message;
                return new Byte[0];
            }
        }
        public static Byte[] GetReportR2(string _reportName, string reportFormat, List<ReportParameter> _reportParameter)

        {
            //  Byte[] result;
            try
            {
                ReportingWebService.ReportExecutionService RS = new ReportingWebService.ReportExecutionService();
                //  CredentialCache cache = new CredentialCache();
                string accessUser = WebConfigurationManager.AppSettings["WebServiceUser"];// WebConfig.ReportUser();
                string accessRWSPW = WebConfigurationManager.AppSettings["WebServiceWP"];//  WebConfig.ReportPW();
                string accessDomain = WebConfigurationManager.AppSettings["NetWorkDomain"];//  WebConfig.DomainName();
                string reportingServices = WebConfigurationManager.AppSettings["ReportingService"];// WebConfig.ReportServices();
                                                                                                   // string currentDB = DBConnectionHelper.CurrentDB();
                string report = WebConfigurationManager.AppSettings["ReportPathWS"] + _reportName;//  WebConfig.ReportPathWS()  + "/" + _reportName;
                string format = reportFormat; // getReportContentType(reportFormat); //WebConfigValue.ReportFormat();

                RS.Url = reportingServices;
                RS.Credentials = new System.Net.NetworkCredential(accessUser, accessRWSPW, accessDomain);


                string historyID = null;
                string devInfo = "<DeviceInfo><Toolbar>False</Toolbar></DeviceInfo>";

                string encoding = "";
                string mimeType = "";
                ReportingWebService.Warning[] warnings = new ReportingWebService.Warning[0];
                string[] streamIDs = null;


                ReportingWebService.ServerInfoHeader sh = new ReportingWebService.ServerInfoHeader();   //'ServerInfoHeader  
                RS.ServerInfoHeaderValue = sh;  //'ServerInfoHeaderValue = sh  
                                                // ReportingWebService.Warning warning = new ReportingWebService.Warning();

                // MyCommon.MyParameterRS[] _reportParameter = GetReportParameters(_reportName, parameters);
                // List<NVListItem> _reportParameter = GetReportParameters(_reportName, parameters);

                var rptParameters = GetReportingServiceParameters(_reportParameter);

                ReportingWebService.ExecutionInfo execInfo = new ReportingWebService.ExecutionInfo();
                ReportingWebService.ExecutionHeader execHeader = new ReportingWebService.ExecutionHeader();


                execInfo = RS.LoadReport(report, historyID);

                RS.SetExecutionParameters(rptParameters, "en-us");

                string extension = "";
                string SessionId = RS.ExecutionHeaderValue.ExecutionID;
                //   Console.WriteLine("SessionID: {0}", RS.ExecutionHeaderValue.ExecutionID);

                return RS.Render(format, devInfo, out extension, out encoding, out mimeType, out warnings, out streamIDs);

                //    return result;

            }
            catch (Exception ex)
            {
                string error = ex.Message;
                return new Byte[0];
            }
        }
        public static Byte[] GetReportR3(string reportingServices, string reportPath, string reportName, string reportFormat, List<ReportParameter> _reportParameter)

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
                string format = reportFormat; // getReportContentType(reportFormat); //WebConfigValue.ReportFormat();

                RS.Url = reportingServices;
                RS.Credentials = new System.Net.NetworkCredential(accessUser, accessRWSPW, accessDomain);

                string report = reportPath + reportName;


                string historyID = null;
                string devInfo = "<DeviceInfo><Toolbar>False</Toolbar></DeviceInfo>";

                string encoding = "";
                string mimeType = "";
                ReportingWebService.Warning[] warnings = new ReportingWebService.Warning[0];
                string[] streamIDs = null;


                ReportingWebService.ServerInfoHeader sh = new ReportingWebService.ServerInfoHeader();
                RS.ServerInfoHeaderValue = sh;

                var rptParameters = GetReportingServiceParameters(_reportParameter);

                //int pLeng = _reportParameter.Count;

                //ReportingWebService.ParameterValue[] rptParameters = new ReportingWebService.ParameterValue[pLeng];

                //int i = 0;
                //foreach (var item in _reportParameter)
                //{
                //    rptParameters[i] = new ReportingWebService.ParameterValue()
                //    {
                //        Name = item.ParaName,
                //        Value = item.ParaValue.ToString()
                //    };
                //    i += 1;
                //}

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
        public static Byte[] GetReportR3WithPW(string reportingServices, string reportPath, string reportName, string reportFormat, List<ReportParameter> _reportParameter, string reviewerPassword, string ownerPassword)

        {
            //  Byte[] result;
            try
            {
                Byte[] myReport = GetReportR3(reportingServices, reportPath, reportName, reportFormat, _reportParameter);

                return AddPWtoPDFMemory(myReport, reviewerPassword, ownerPassword);


            }
            catch (Exception ex)
            {
                string error = ex.Message;
                return new Byte[0];
            }
        }

        public static Byte[] MultiplePDF(string[] mySelectIDArray, string reportName, string schoolyear, string schoolcode, string sessionID)
        {
            Document doc = new Document();
            MemoryStream msOutput = new MemoryStream();
            //           PdfCopy pCopy;
            PdfCopy pCopy = new PdfSmartCopy(doc, msOutput);
            doc.Open();

            for (int j = 0; j < mySelectIDArray.Length; j++)
            {
                string userID = HttpContext.Current.User.Identity.Name;
                string employeeID = mySelectIDArray[j].ToString();
                if (employeeID != "")
                {
                    try
                    {
                        Byte[] myPDF;
                        myPDF = GetOneReport(reportName, userID, schoolyear, schoolcode, sessionID, employeeID);
                        MemoryStream stream1 = new MemoryStream(myPDF);
                        PdfReader pdfFile1 = new PdfReader(stream1.ToArray());
                        for (int i = 1; i <= pdfFile1.NumberOfPages; i++)
                        {
                            pCopy.AddPage(pCopy.GetImportedPage(pdfFile1, i));
                        }
                        pdfFile1.Close();
                    }
                    catch { }
                }

            }
            try
            {
                pCopy.Close();
                doc.Close();
            }
            catch { }

            return msOutput.ToArray();
        }


        private static Byte[] GetOneReport(string reportName, string userID, string schoolyear, string schoolcode, string sessionID, string employeeID)
        {
            MyADO.MyParameterRS[] reportParameters = new MyADO.MyParameterRS[7];
            setParameterArray(reportParameters, 0, "Operate", "Report");
            setParameterArray(reportParameters, 1, "UserID", userID);
            setParameterArray(reportParameters, 2, "SchoolYear", schoolyear);
            setParameterArray(reportParameters, 3, "SchoolCode", schoolcode);
            setParameterArray(reportParameters, 4, "EmployeeID", employeeID);
            setParameterArray(reportParameters, 5, "SessionID", sessionID);
            setParameterArray(reportParameters, 6, "Category", "EPA");
            return GetReportR2(reportName, reportParameters);

        }

        private static Byte[] GetOneReport(string reportName, ListOfSelected parameter)
        {
            var reportParameters = GetReportParameter(parameter);
 
            return GetReportR2(reportName, "PDF", reportParameters);

        }
        private static List<ReportParameter> GetReportParameter(ListOfSelected parameter)
        {
            var reportParameters = new List<ReportParameter>();
            reportParameters.Add(new ReportParameter() { ParaName = "Operate", ParaValue = "Report" });
            reportParameters.Add(new ReportParameter() { ParaName = "UserID", ParaValue = parameter.UserID });
            reportParameters.Add(new ReportParameter() { ParaName = "SchoolYear", ParaValue = parameter.SchoolYear });
            reportParameters.Add(new ReportParameter() { ParaName = "SchoolCode", ParaValue = parameter.SchoolCode});
            reportParameters.Add(new ReportParameter() { ParaName = "EmployeeID", ParaValue = parameter.ObjID });
            reportParameters.Add(new ReportParameter() { ParaName = "SessionID", ParaValue = parameter.ObjNo});
            reportParameters.Add(new ReportParameter() { ParaName = "Category", ParaValue = parameter.ObjType});
            return reportParameters;
     }

        public static string reportFormat(string pFormat)
        {
            string rValue = "";
            switch (pFormat)
            {
                case "PDF1":
                    rValue = "&rs:Command=Render&rs:Format=PDF&rs:ClearSession=true&rc:Toolbar=false";
                    break;
                case "PDF":
                    rValue = "&rs:Command=Render&rs:Format=PDF&rs:ClearSession=true&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                case "PDFV":
                    rValue = "&rs:Command=Render&rs:Format=PDF&rs:ClearSession=true&rc:Toolbar=true&rc:LinkTarget=_blank";
                    break;
                case "CSV":
                    rValue = "&rs:Command=Render&rs:Format=CSV&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                case "EXCEL":
                    rValue = "&rs:Command=Render&rs:Format=EXCEL&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                case "IMAGE":
                    rValue = "&rs:Command=Render&rs:Format=IMAGE&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                case "HTML":
                    rValue = "&rs:Command=Render&rs:Format=HTML4.0&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                case "HTMLV":
                    rValue = "&rs:Command=Render&rs:Format=HTML4.0&rc:Toolbar=true&rc:LinkTarget=_blank";
                    break;
                case "XML":
                    rValue = "&rs:Command=Render&rs:Format=XML&rc:Toolbar=false&rc:LinkTarget=_blank";
                    break;
                default:

                    rValue = "&rs:Command=Render&rs:Format=HTML4.0&rc:Toolbar=false&rc:LinkTarget=_blank";

                    break;
            }
            return rValue;

        }
        private static string getReportContentType(string _reportFormat)
        {

            string rValue = "";
            switch (_reportFormat)
            {
                case "PDF":
                    rValue = "application/pdf";
                    break;
                case "CSV":
                    rValue = "application/csv";
                    break;
                case "EXCEL":
                    rValue = "application / vnd.ms - excel";
                    break;
                case "IMAGE":
                    rValue = "image/tiff";
                    break;
                case "HTML":
                    rValue = "application/html";
                    break;
                case "XML":
                    rValue = "application/xml";
                    break;
                default:

                    rValue = "application/pdf";

                    break;
            }
            return rValue;

        }

        public static ReportParameter GetParameter(Int16 Seq, string pName, string pValue)
        {
            var para1 = new ReportParameter
            {
                ParaName = pName,
                ParaValue = pValue
            };
            return para1;
        }

        public static string getFileExtension(string _reportFormat)
        {

            string rValue = "";
            switch (_reportFormat)
            {
                case "PDF":
                    rValue = ".pdf";
                    break;
                case "CSV":
                    rValue = ".csv";
                    break;
                case "EXCEL":
                    rValue = ".xls";
                    break;
                case "IMAGE":
                    rValue = ".gif";
                    break;
                case "HTML":
                    rValue = ".html";
                    break;
                case "XML":
                    rValue = ".xml";
                    break;
                default:
                    rValue = ".pdf";

                    break;
            }
            return rValue;

        }

        public static void AddPWtoPDFFile(string inputFile, string outputFile, string folder, string reviewerPassword, string ownerPassword)
        {
            string WorkingFolder = folder; // Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            string InputFile = Path.Combine(WorkingFolder, inputFile); // Path.Combine(WorkingFolder, "Test.pdf");
            string OutputFile = Path.Combine(WorkingFolder, outputFile);

            using (Stream input = new FileStream(InputFile, FileMode.Open, FileAccess.Read, FileShare.Read))
            {
                using (Stream output = new FileStream(OutputFile, FileMode.Create, FileAccess.Write, FileShare.None))
                {
                    PdfReader reader = new PdfReader(input);
                    PdfEncryptor.Encrypt(reader, output, true, reviewerPassword, ownerPassword, PdfWriter.ALLOW_SCREENREADERS);
                }
            }

        }
        public static Byte[] AddPWtoPDFMemory(Byte[] pdfDocument, string reviewerPassword, string ownerPassword)
        {
            try
            {
                MemoryStream stream1 = new MemoryStream(pdfDocument);
                MemoryStream output = new MemoryStream();

                PdfReader input = new PdfReader(stream1.ToArray());
                PdfEncryptor.Encrypt(input, output, true, reviewerPassword, ownerPassword, PdfWriter.ALLOW_SCREENREADERS);

                return output.ToArray();
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return null;
            }

        }

        public static void SavePDFReport(Byte[] pdfDocument, string fileName, string filePath)
        {

            fileName = fileName.Replace(@"\", "");
            fileName = fileName.Replace("/", "");
            fileName = fileName.Replace("`", "");
            fileName = fileName.Replace("'", "");
            // fileName = filePath + @"\" + fileName; 
            var goFile = Path.Combine(filePath, fileName);
            try
            {
                if (!Directory.Exists(filePath))
                { System.IO.Directory.CreateDirectory(filePath); }
                else
                {
                    if (System.IO.File.Exists(goFile))
                    { System.IO.File.Delete(goFile); }

                    var objFileStream = new FileStream(goFile, FileMode.Create);
                    var objBinaryWriter = new BinaryWriter(objFileStream);
                    objBinaryWriter.Write(pdfDocument);
                    objBinaryWriter.Close();
                    objFileStream.Close();
                }
            }
            catch (Exception ex)
            {
                var mes = ex.Message;
            }


        }

    }
  
}
