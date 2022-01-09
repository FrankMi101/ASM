using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL.ActionApp
{
    public class ActionFactory<T>
    {
        public static IActionApp<T> GetObject(string actionObj )
        {
          //  return (IActionApp<T>) new  ActionAppsModel(_dataOperate);
            switch (actionObj)
            {
                case "Apps": return (IActionApp<T>) new ActionApps();
                case "AppsModel": return (IActionApp<T>) new ActionAppsModel();
                case "AppAccess": return (IActionApp<T>) new ActionAppsAccess();
                case "AppsRole": return (IActionApp<T>) new ActionAppRole();
                case "AppRolePermission": return (IActionApp<T>) new ActionAppRolePermission();
                case "Feedback": return (IActionApp<T>) new ActionAppsFeedback();
                case "RequestPermission": return (IActionApp<T>) new ActionAppsRequestPermission();
                case "RequestClassMatch": return (IActionApp<T>) new ActionAppsRequestClassMatch();
                case "UserGroupPermission": return (IActionApp<T>) new ActionUserGroupPermission();
                case "UserGroup": return (IActionApp<T>) new ActionAppUserGroup();
                case "UserGroupPush": return (IActionApp<T>) new ActionAppUserGroupPush();
                case "GroupListStudent":
                case "UserGroupStudent": return (IActionApp<T>) new ActionAppUserGroupMemberS();
                case "GroupListTeacher":
                case "UserGroupTeacher": return (IActionApp<T>) new ActionAppUserGroupMemberT();
                case "SchoolSelectedList":
                case "StaffWorkingSchools": return (IActionApp<T>) new ActionAppStaffWorkingSchools();
                case "StaffWorkingRoles": return (IActionApp<T>) new ActionAppStaffWorkingRoles();
                case "StaffWorkingGroups": return (IActionApp<T>) new ActionAppStaffWorkingGroups();
                case "ActionAppList": return (IActionApp<T>) new ActionAppList<T, T>();
                case "AppWorkingProfile": return (IActionApp<T>) new ActionWorkingProfile();
                default: return (IActionApp<T>) new ActionApp<T>();
             }
        }
    }
}
