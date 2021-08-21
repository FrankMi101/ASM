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
        private static readonly string _dbSource = "SQL";
        public static object ClassType(string objType)
        {
            // return new IEPReportParameter();
            // var objType = typeof(T).Name;
            switch (objType)
            {

                case "UserGroup":
                    return new ActionApp<UserGroup>(new ActionAppUserGroup());
                case "UserGroupPush":
                    return new ActionApp<UserGroupPush>(new ActionAppUserGroupPush());
                case "GroupListStudent":
                case "UserGroupStudent":
                    return new ActionApp<UserGroupMemberStudent>(new ActionAppUserGroupMemberS());

                case "GroupListTeacher":
                case "UserGroupTeacher":
                    return new ActionApp<UserGroupMemberTeacher>(new ActionAppUserGroupMemberT());
                default:
                    return null;
            }
        }
        public static string SPName(string action)
        {
            // return new IEPReportParameter();
            var objType = typeof(T).Name;
            switch (objType)
            {
                case "NameValue":
                    return "dbo.SIC_sys_ListItems";
                case "MenuItem":
                    return "dbo.SIC_sys_ActionMenuList";
                case "AppRole":
                    return "dbo.SIC_asm_AppRole_" + action;
                case "UserGroup":
                    return "dbo.SIC_asm_AppUserGroup_" + action;
                case "UserGroupPush":
                    return "dbo.SIC_asm_AppUserGroup_" + action;
                case "UserGroupMemberStudent":
                    return "dbo.SIC_asm_AppUserGroupMemberS_" + action;
                case "UserGroupMemberTeacher":
                    return "dbo.SIC_asm_AppUserGroupMemberT_" + action;
                case "StaffList":
                    return "dbo.SIC_asm_AppSchoolStaffs";
                case "StaffMemberOf":
                    return "dbo.SIC_asm_AppSchoolStaffs_MemberOf";
                default:
                    return action;
            }
        }
        public static object DBSource()
        {
            switch (_dbSource)
            {
                case "SQL":
                    return new DataOperateService<T>(new DataOperateServiceSQL<T>());
                case "ORA":
                    return new DataOperateService<T>(new DataOperateServiceORA<T>());
                case "API":
                    return new DataOperateService<T>(new DataOperateServiceAPI<T>());
                default:
                    return null;
            }

        }
    }

}