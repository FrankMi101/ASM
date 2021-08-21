using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
//using ASM.Model;
using BLL;
using ClassLibrary;
using Newtonsoft.Json;

namespace ASM.Models
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]


    public class WebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
        [WebMethod]
        public string GetHelpContentByHelpPara(string operation, HelpMessage parameter)
        {
            try
            {
                //  string sp = "dbo.SIC_sys_HelpContent";

                return ValueData.GeneralValue<string>("AppsPageHelp", "HelpContent", parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        [WebMethod]
        public string GetHelpContent(string operation, string userId, string categoryId, string areaId, string itemCode)
        {
            try
            {
                return HelpContext.Content(operation, userId, categoryId, areaId, itemCode, "Help");
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        [WebMethod]
        public string GetHelpContent(string operation, string userId, string categoryId, string areaId, string itemCode, string type)
        {
            try
            {
                return HelpContext.Content(operation, userId, categoryId, areaId, itemCode, type);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        [WebMethod]
        public string SaveHelpContent(string operation, string userId, string categoryId, string areaId, string itemCode, string value)
        {
            try
            {
                return HelpContext.Content(operation, userId, categoryId, areaId, itemCode, "Help", value);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        [WebMethod]
        public string GetTitleContent(string operation, string userId, string categoryId, string areaId, string itemCode)
        {
            try
            {
                return TitleContext.Content(operation, userId, categoryId, areaId, itemCode);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }

        }
        [WebMethod]
        public string SaveTitleContent(string operation, string userId, string categoryId, string areaId, string itemCode, string title, string subtitle)
        {
            try
            {
                return TitleContext.Content(operation, userId, categoryId, areaId, itemCode, title, subtitle);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
        }

        //[WebMethod]
        //public string SaveGroupTeacher(string operation, GroupOperation parameter)
        //{
        //    try
        //    {
        //        parameter.Operate = operation;
        //        string sp = "dbo.SIC_sys_UserGroupMember_Teachers @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode@AppID,@GroupID,@MemberID,@Permission,@StartDate,@EndDate,@Comments";
        //        string result = AppsBase.GeneralValue<string>(sp, parameter);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //       return "Failed";
        //    }
        //}

        //[WebMethod]
        //public string DeleteGroupTeacher(string operation, GroupOperation parameter)
        //{
        //    try
        //    {
        //        parameter.Operate = operation;
        //       // string sp = "dbo.SIC_sys_UserGroupMember_Teachers @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@CPNum";
        //        string result = AppsBase.GeneralValue<string>("SecuriyManage","GroupMemberTeacher", parameter);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        return "Failed";
        //    }
        //}
        //[WebMethod]
        //public string DeleteGroupMember(string operation, GroupOperation parameter)
        //{
        //    try
        //    {
        //        parameter.Operate = operation;
        //       // string sp = "dbo.SIC_sys_UserGroupMember_Students @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@AppID,@GroupID,@GroupType,@GroupMember";
        //        string result = AppsBase.GeneralValue<string>("SecuriyManage", "GroupMemberStudent", parameter);
        //        return result;
        //    }
        //    catch (Exception ex)
        //    {
        //        return "Failed";
        //    }
        //}
        [WebMethod]
        public string SaveSecurityRole(string operation, AppRoleOperation parameter)
        {
            try
            {
                string result = ValueData.GeneralValue<string>("SecuriyManage", "UserRoleManagementOperation", parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }
        [WebMethod]
        public string SaveSecurityRolePermission(string operation, AppRoleOperation parameter)
        {
            try
            {
                string result = ValueData.GeneralValue<string>("SecuriyManage", "UserRolePermissionOperation", parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }
        [WebMethod]
        public string SaveSecurityRoleMatch(string operation, AppRoleMatchOperation parameter)
        {
            try
            {
                string result = ValueData.GeneralValue<string>("SecurityManage", "UserRoleMatchManagementOperation", parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }
        [WebMethod]
        public string SaveSecurityGroup(string operation, GroupOperation parameter)
        {
            try
            {
                string result = ValueData.GeneralValue<string>("SecurityManage", "ManageGroupMember", parameter);
                 return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }
        [WebMethod]
        public string SaveSecurityGroup2(string operation, UserGroup parameter)
        {
            try
            {
                string result = ManageFormSave<UserGroup>.SaveFormContent(operation, "UserGroup", parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }

        [WebMethod]
        public string SaveSecurityGroupMember(string memberType, string operation, GroupOperation parameter)
        {
            try
            {
                string para = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@AppID,@GroupID,@MemberID,@AppRole";
                string sp = "dbo.SIC_sys_UserGroupMember_Students";
                if (memberType == "Students")
                {
                    if (operation != "Delete")
                    {
                        para = para + ",@GroupType,@Comments";
                    }
                }

                if (memberType == "Teachers")
                {
                    sp = "dbo.SIC_sys_UserGroupMember_Teachers";
                    if (operation != "Delete")
                    {
                        para = para + ",@StartDate,@EndDate,@Comments";
                    }
                }
                string result = AppsBase.GeneralValue<string>(sp + para, parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }
        [WebMethod]
        public string PushGroupToAnotherApp(string operate, UserGroupPush parameter)
        {
            try
            {
                string result = ManageFormSave<UserGroupPush>.SaveFormContent(operate, "UserGroupPush", parameter);
              //  string result = AppsBase.GeneralValue<string>("SecurityManage", "PushGroupToApps", parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }
        }

        [WebMethod]
        public List<MenuItems> ActionMenuListService(string operation, MenuListParameter parameter)
        {
            try
            {
                List<MenuItems> myList;
                myList = AppsPage.ActionMenuList<MenuItems>(parameter);
                return myList;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return null;
            }
        }

        [WebMethod]
        public List<NameValueList> CommonLists(string operate, GeneralParameter parameter)
        {
            try
            {
                var sp = "[dbo].[SIC_sys_GeneralList]";
                return GeneralList.CommonList<NameValueList>(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return null;
            }
        }
        [WebMethod]
        public List<NameValueList> GCommonList(object parameter)
        {
            try
            {
                var sp = "[dbo].[SIC_sys_GeneralList] @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@Para1,@Para2,@Para3";
                return GeneralList.CommonList<NameValueList>(sp, parameter);
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return null;
            }

        }
        [WebMethod]
        public Byte[] PrintReportService(string reportID, ListOfSelected parameter)
        {
            //try
            //{
            //    var reportParameters = new List<ReportParameter>
            //{
            //    new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
            //    new ReportParameter() { ParaName = "UserID", ParaValue = parameter.UserID },
            //    new ReportParameter() { ParaName = "SchoolYear", ParaValue =parameter.SchoolYear },
            //    new ReportParameter() { ParaName = "SchoolCode", ParaValue = parameter.SchoolCode },
            //    new ReportParameter() { ParaName = "PersonID", ParaValue = parameter.ObjID}
            //};



            var goPageparameter = new
            {
                Operate = "",
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                SchoolCode = "0205",
                Grade = "",
                StudentID = "00881172306",
                PageID = reportID,
                Term = "1"
            };
            var myGoPageItem = AppsPage.GoPageItemsList<GoPageItems>(goPageparameter)[0];
            string reportingService = myGoPageItem.PageSite;
            string reportPath = myGoPageItem.PagePath;
            string reportName = myGoPageItem.PageFile;
            string PagePara = myGoPageItem.PagePara;

            var reportPara = new ReportBase
            {
                ReportService = myGoPageItem.PageSite,
                ReportPath = myGoPageItem.PagePath,
                ReportName = myGoPageItem.PageFile,
                ReportType = "IEP",
                ReportFormat = "PDF"
            };


            Byte[] myReport = null;
            try
            {
                myReport = GeneratePDFReport.GetOneReport(reportPara, parameter);

                return myReport;

            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return null;
            }
        }
      
        [WebMethod(EnableSession = true)]
        public void SelectedStudentDataSet(string operate, List<ListOfSelected> parameters)
        {
            Session["SelectedDataSet"] = parameters; 
        }
    }
}
