using System;
using System.Collections.Generic;

namespace BLL
{
    public class GeneralList : CommonSP
    {
        public override string GetSPandParametersByOverride(string action)
        {
            return GetSPNameWithParameters(action);
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
                //  return CommonExecute<T>.ListOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }
        public static List<T> CommonList<T>(string db,string action, object parameter)
        {
            try
            {
                string sp = GetSP(action);
                var myList = new CommonOperate<T>();
                return myList.ListOfT(db,sp, parameter);
                //  return CommonExecute<T>.ListOfT(sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }

        public static List<T> JsonSourceList<T>(string JsonSource, string ddlType, string action)
        { // tempraryly 
            var myList = new CommonOperate<T>();
            var parameter = new { Operate = "Json", Type = ddlType, Action = action };
            return myList.ListOfT(action, parameter);
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
            string parameter = " @Operate,@UserID,@UserRole,@Para1,@Para2,@Para3,@Para4";
            string parameter1 = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";
            string parameter2 = parameter1 + ",@Grade,@SearchBy,@SearchValue";

            switch (action)
            {
                case "BatchPrintPage":
                    return "dbo.SIC_sys_ListofStudentsForBatchPrint";// + parameter1 + ",@ReportID,@SearchBy,@SearchValue,,@Program,@Term,@Semester";
                case "TabList":
                    return "dbo.SIC_sys_ListItemsTab" + parameter1;
                case "DDList":
                    return "dbo.SIC_sys_ListItems" + parameter;
                case "DDLListSchool":
                    return "dbo.SIC_sys_ListItemsSchool" + parameter;
                case "DDLListStudents":
                    return "dbo.SIC_sys_ListItemsStudents" + parameter;
                case "SchoolList":
                    return "dbo.SIC_sys_SchoolList" + parameter1 + ",@Panel";
                case "SchoolListPage":
                    return "dbo.SIC_sys_ListofSchools" + parameter2;
                case "GroupListPage":
                    return "dbo.SIC_sys_ListofStudentGroup" + parameter2 + ",@Scope,@Program,@Term,@Semester";
                case "StudentListPage":
                    return "dbo.SIC_sys_ListofStudents" + parameter2 + ",@Scope,@Program,@Term,@Semester";
                 case "ClassListPage":
                    return "dbo.SIC_sys_ListofClasses" + parameter2 + ",@Scope,@Program,@Term,@Semester";
                case "StaffListPage":
                    return "dbo.SIC_sys_ListofSchoolStaffs" + parameter2 + ",@Scope";
                case "PrincipalListPage":
                    return "dbo.SIC_sys_ListofSchoolPrincipals" + parameter2 + ",@Scope";
                case "GroupMembersList":
                     return "dbo.SIC_sys_ListofMembersSecurityGroup" + parameter1 + ",@AppID,@GroupID,@MemberID";

                case "SchoolDateList":
                    return "dbo.SIC_sys_SchoolDateList" + parameter1;                  
                case "TPAListPage":
                    return "dbo.SIC_sys_ListofAppraisal" + parameter2 + ",@Scope";
                case "Grade":
                    return "dbo.SIC_sys_GradeList" + parameter1;
                case "ActionMenuList":
                    return "dbo.SIC_sys_ActionMenuList" + parameter1 + ",@TabID,@ObjID,@AppID,@Semester,@Term";
              
               default:
                    return action;

            }


        }

    }
}
