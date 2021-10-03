using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class MapClass<T>
    {
        private static readonly string _dbType = "SQL";
        public static string DBType()
        {
            return _dbType;
        }
        public static string ObjType(object parameter)
        {
            return CheckStoreProcedureParameters.GetObjType(parameter);
        }
        public static object ClassType()
        {
            var objectType = typeof(T).Name;
            return ClassType(objectType);
        }
        public static object ClassType(string objType)
        {
            try
            {
                switch (objType)
                {
                    case "AppRolePermission":
                        return new ActionAppRolePermission();
                    case "UserGroupPermission":
                        return new ActionUserGroupPermission();
                    case "UserGroup":
                        return new ActionAppUserGroup();
                    case "UserGroupPush":
                        return new ActionAppUserGroupPush();
                    case "GroupListStudent":
                    case "UserGroupStudent":
                        return new ActionAppUserGroupMemberS();

                    case "GroupListTeacher":
                    case "UserGroupTeacher":
                        return new ActionAppUserGroupMemberT();
                    case "SchoolSelectedList":
                    case "StaffWorkingSchools":
                        return new ActionAppStaffWorkingSchools();
                    case "StaffWorkingRoles":
                        return new ActionAppStaffWorkingRoles();
                    case "StaffWorkingGroups":
                        return new ActionAppStaffWorkingGroups();
                    case "ActionAppList":
                        return new ActionAppList<T, T>();
                    default:
                        return new ActionApp<T>();
                        //  return new ActionApp<UserGroupMemberTeacher>(new ActionAppUserGroupMemberT());
                }
            }
            catch (Exception ex)
            {
                return new ActionApp<T>();
            }
        }

        public static IActionApp<T> ActionClassType(string objType)
        {   
            try
            {
                return new ActionAppService<T>();
            }
            catch (Exception ex)
            {
                return new ActionAppService<T>();
            }
        }
        public static string SPName(string action)
        {
            // return new IEPReportParameter();
            var objType = typeof(T).Name;
            return SPName(action, objType);
        }
        public static string SPName(string action, string objType)
        {
            switch (objType)
            {
                case "SchoolDateStr":
                    return "dbo.SIC_sys_SchoolDate";
                case "NameValue":
                    return "dbo.SIC_sys_ListItems";
                case "MenuItem":
                    return "dbo.SIC_sys_ActionMenuList";
                case "AppRole":
                    return "dbo.SIC_asm_AppRole_" + action;
                case "AppRoleMatch":
                    return "dbo.SIC_asm_AppRoleMatch_" + action;
                case "AppRolePermission":
                    return "dbo.SIC_asm_AppRolePermission_" + action;
                case "UserGroup":
                    return "dbo.SIC_asm_AppUserGroup_" + action;
                case "UserGroupPush":
                    return "dbo.SIC_asm_AppUserGroup_" + action;
                case "UserGroupMemberStudent":
                    return "dbo.SIC_asm_AppUserGroupMemberS_" + action;
                case "UserGroupMemberTeacher":
                    return "dbo.SIC_asm_AppUserGroupMemberT_" + action;
                case "UserGroupPermission":
                    return "dbo.SIC_asm_AppUserGroupPermission_" + action;
                case "StaffList":
                    return "dbo.SIC_asm_AppSchoolStaffs_" + action;
                case "ClassStudentList":
                    return "dbo.SIC_asm_StudentList_" + action;
                case "AppRoleList":
                    return "dbo.SIC_asm_AppRoleList_" + action;
                case "StaffMemberOf":
                    return "dbo.SIC_asm_AppSchoolStaffsMember_" + action;
                case "StaffWorkingSchools":
                    return "dbo.SIC_asm_AppStaffWorkingSchools_" + action;
                case "StaffWorkingGroups":
                    return "dbo.SIC_asm_AppStaffWorkingGroups_" + action;
                case "StaffWorkingRoles":
                    return "dbo.SIC_asm_AppStaffWorkingRoles_" + action;
                default:
                    return action;
            }
        }
        public static object DBSource()
        {
            return DBSource(_dbType);
        }
        public static object DBSource(string dbType)
        {
            switch (dbType)
            {
                case "SQL":
                    return new DataOperateServiceSQL<T>();
                case "ORA":
                    return new DataOperateServiceORA<T>();
                case "API":
                    return new DataOperateServiceAPI<T>();
                default:
                    return new DataOperateServiceSQL<T>();
            }

        }
    }

}