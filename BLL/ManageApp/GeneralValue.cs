using System;
using System.Collections.Generic;

namespace BLL
{
    public class GeneralValue : CommonSP
    {
        public override string GetSPandParametersByOverride(string action)
        {
            return GetSPNameWithParameters(action);
        }
        public static string GetSP(string action)
        {
            return GetSPNameWithParameters(action);
        }
     
        public static T CommonValue<T>(string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myValue = new CommonOperate<T>();
                return myValue.ValueOfT(sp, parameter);
                //  return CommonExecute<T>.ValueOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }
        public static T CommonValue<T>(string db, string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myValue = new CommonOperate<T>();
                return myValue.ValueOfT(db,sp, parameter);
                //  return CommonExecute<T>.ValueOfT(sp, parameter);
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
            string parameter = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";
            string parameter1 = parameter + ",@AppID,@GroupID";
            string parameter2 = parameter1 + ",@GroupName,@GroupType,@Permission,@IsActive,@Comments,@StudentMember";

            switch (action)
            {
                  case "ManageGroup":
                    return "dbo.SIC_sys_UserGroupMember" + parameter2;
                case "AppsValue":
                    return "dbo.SIC_sys_GeneralValue" + parameter;              
                case "ActionMenuList":
                    return "dbo.SIC_sys_ActionMenuList" + parameter + ",@TabID,@ObjID,@Semester,@Term";
              
               default:
                    return action;

            }


        }

    }
}
