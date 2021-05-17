using ClassLibrary;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class AppsPageHelp
    {
        public static string GetSP(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "AppraisalPageHelp");
                default:
                    return GetSPInClass(action);
            }
        }

        public static List<T> CommonList<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList.ListOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }
        public static T CommonValue<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myValue = new CommonOperate<T>();
                return myValue.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }


        public static string PageHelp(string action,PageHelp parameter )
        { 
                parameter.Operate = action;
                return CommonValue<string>(action, parameter); 
        }


        public static string DocFile(object parameter)
        {
            return CommonValue<string>("DocFile", parameter);
        }
        public static string PageItem(object parameter)
        {
            return CommonValue<string>("PageItem", parameter);
        }
        public static string PageNext(object parameter)
        {
            return CommonValue<string>("PageNext", parameter);
        }

        public static string PagePrevious(object parameter)
        {
            return CommonValue<string>("PagePrevious", parameter);
        }
        public static string PageActiveFor(object parameter)
        {
            return CommonValue<string>("PageActiveFor", parameter);
        }
        public static string PageRecover(object parameter)
        {
            return CommonValue<string>("PageRecover", parameter);
        }
        public static string PageHelp(object parameter)
        {
            return CommonValue<string>("PageHelp", parameter);
        }
        public static string PageEP(object parameter)
        {
            return CommonValue<string>("PageEP", parameter);
        }

        public static string PDFReportName(object parameter)
        {
            return CommonValue<string>("PDFReportName", parameter);
        }
        public static string ReportName(object parameter)
        {
            return CommonValue<string>("ReportName", parameter);
        }
        private static string GetSPInClass(string action)
        {

            string parameters = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID,@PageID";

            switch (action)
            {
                case "PageTitle":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                 case "DocFile":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageItem":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageNext":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PagePrevious":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                case "PageHelp":
                    return "dbo.EPA_Appr_AppraisalProcess_GoPage" + parameters;
                 case "GoPage":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters;
                case "GoPageGroup":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters + ",@Term,@Category,@AppID";
                case "GoPageItems":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters + ",@Term,@Category,@AppID,@GroupID,@MemberID";
                case "HelpContent":
                    return "dbo.SIC_sys_HelpTitleContentSP";

                default:
                    return action;

            }
        }

    }
}
