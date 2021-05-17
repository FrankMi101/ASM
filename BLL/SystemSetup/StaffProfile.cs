using ClassLibrary;
using System;
using System.Collections.Generic;

namespace BLL
{
    public class StaffProfile
    {

        public static string GetSP(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "StaffProfile");
                default:
                    return GetSPInClass(action, "");
            }
        }

        public static List<T> CommonList<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList.ListOfT(sp, parameter);
               // return CommonExecute<T>.ListOfT(sp, parameter);
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
                // return CommonExecute<T>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }

        public static List<AreaList> AreaList(object parameter)
        {
            return CommonList<AreaList>("AreaList", parameter);
        }
        public static string SaveArea(object parameter)
        {
            return CommonValue<string>("AreaSave", parameter);
        }



        private static string GetSPInClass(string action, string page)
        {



            string parameters = " @Operate,@UserID";
            string parameters1 = " @Operate,@UserID,@Category,@Area,@Code,@UserRole";
            string parameters2 = " @Operate,@UserID,@IDs,@Code,@Name,@Comments,@Active";



            switch (action)
            {
                case "AreaList":
                    return "dbo.EPA_sys_SetupAppraisalArea" + parameters;
                case "AreaSave":
                    return "dbo.EPA_sys_SetupAppraisalArea" + parameters2;
                case "CategoryList":
                    return "dbo.EPA_sys_SetupAppraisalCategory" + parameters;
                case "CategorySave":
                    return "dbo.EPA_sys_SetupAppraisalCategory" + parameters2 + "@Value";
                case "MessageForRole":
                    return "dbo.EPA_sys_HelpTextMessageForRole" + parameters1;
                case "MessageForRoleSave":
                    return "dbo.EPA_sys_HelpTextMessageForRole" + parameters1 + ",@Value";



                default:
                    return action;

            }
        }

    }
}

