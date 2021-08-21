using ClassLibrary;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class AppsPageHelp : CommonSP
    {
        public override string GetSPandParametersByOverride(string action)
        {
            return  GetSPNameWithParameters(action);
        }
        public static string GetSP(string action)
        {
            return GetSPNameWithParameters(action);
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
       
        private static string GetSPNameWithParameters(string action)
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
        private static string GetSPInClass(string action)
        {

            string parameters = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode,@Grade,@StudentID,@PageID";

            switch (action)
            {
              
                case "GoPage":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters;
                case "GoPageGroup":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters + ",@Term,@Category,@AppID";
                case "GoPageItems":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters + ",@Term,@Category,@AppID,@GroupID,@MemberID";
                case "MultipleReport":
                    return "dbo.SIC_sys_ActionMenu_GoPage" + parameters + ",@Term";
                case "HelpContent":
                    return "dbo.SIC_sys_HelpTitleContentSP";

                default:
                    return action;

            }
        }

    }
}
