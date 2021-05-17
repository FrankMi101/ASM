using System;
using System.Collections.Generic;

namespace BLL
{
    public class GeneralList
    {
        public static string GetSP(string action)
        {
            switch (SPSource.SPFile)
            {
                case "JsonFile":
                    return GetSPFrom.JsonFile(action);
                case "DBTable":
                    return GetSPFrom.DbTable(action, "AppraisalGeneral");
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
                //  return CommonExecute<T>.ListOfT(sp, parameter);
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
                //  return CommonExecute<T>.ValueOfT(sp, parameter);
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

        private static string GetSPInClass(string action)
        {
            string parameter = " @Operate,@UserID,@Para1,@Para2,@Para3,@Para4";
            string parameter1 = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";
            string parameter2 = parameter1 + ",@Grade,@SearchBy,@SearchValue";

            switch (action)
            {

                case "DDList":
                    return "dbo.SIC_sys_ListItems" + parameter;
                case "DDLListSchool":
                    return "dbo.SIC_sys_ListItemsSchool" + parameter;
                case "DDLListStudents":
                    return "dbo.SIC_sys_ListItemsStudents" + parameter;
                case "SchoolList":
                    return "dbo.SIC_sys_SchoolList" + parameter1 + ",@Panel,";
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
                 case "GroupMembersList":
                     return "dbo.SIC_sys_ListofMembersSecurityGroup" + parameter1 + ",@AppID,@GroupID,@MemberID";

              // case "SecurityStaffList":
               //     return "dbo.SIC_sys_ListofStaffsSecurity" + parameter2 + ",@Scope";
               // case "SecurityContentList":
               //     return "dbo.SIC_sys_ListofStaffsSecurityContent" + parameter1 + ",@CPNum";

               // case "SecurityGroupManage":
               //     return "dbo.SIC_sys_ListofSecurityGroups" + parameter1 + ",@AppID";
               //  case "SecurityGroupManageSub":
               //     return "dbo.SIC_sys_ListofSecurityGroups" + parameter1 + ",@AppID,@GroupID";
               //case "UserRoleManagement":
               //     return "dbo.SIC_sys_UserRoleManagement" + parameter1 + ",@AppID,@RoleID,@RoleType";
                case "SchoolDateList":
                    return "dbo.SIC_sys_SchoolDateList" + parameter1;                  
                case "TPAListPage":
                    return "dbo.SIC_sys_ListofAppraisal" + parameter2 + ",@Scope";
                case "Grade":
                    return "dbo.SIC_sys_GradeList" + parameter1;
                case "TabList":
                    return "dbo.SIC_sys_TabList" + parameter1;
                case "ActionMenuList":
                    return "dbo.SIC_sys_ActionMenuList" + parameter1 + ",@TabID,@ObjID,@Semester,@Term,@AppID";
              
               default:
                    return action;

            }


        }

    }
}
