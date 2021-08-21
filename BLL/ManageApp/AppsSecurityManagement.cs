using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using ClassLibrary;
namespace BLL
{
    public class AppsSecurityManagement : CommonSP
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
            string parameter = " @Operate,@UserID,@UserRole,@AppID,@RoleID,@RoleType";
            string parameter1 = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";
 
            switch (action)
            {
                case "SecurityStaffList":
                    return "dbo.SIC_sys_ListofStaffsSecurity" + parameter1 + ",@SearchBy,@SearchValue,@Scope";
                case "SecurityContentList":
                    return "dbo.SIC_sys_ListofStaffsSecurityContent" + parameter1 + ",@CPNum";
                case "GroupMembersList":
                    return "dbo.SIC_sys_ListofMembersSecurityGroup" + parameter1 + ",@AppID,@GroupID";
                case "SecurityGroupManage":
                    return "dbo.SIC_sys_ListofSecurityGroups" + parameter1 + ",@AppID";
                case "SecurityGroupManageSub":
                    return "dbo.SIC_sys_ListofSecurityGroups" + parameter1 + ",@AppID,@GroupID";
                case "SchoolDateList":
                    return "dbo.SIC_sys_SchoolDateList" + parameter1;
                case "ManageGroupList":
                    return "dbo.SIC_sys_UserGroupMember" + parameter1;
                case "ManageGroupContent":
                    return "dbo.SIC_sys_UserGroupMember" + parameter1 + ",@AppID,@GroupID";
                case "ManageGroupMember":
                    return "dbo.SIC_sys_UserGroupMember" + parameter1 + ",@AppID,@GroupID,@GroupName,@GroupType,@Permission,@IsActive,@Comments,@StudentMember";
                case "UserRoleManagement":
                    return "dbo.SIC_sys_UserRoleManagement" + parameter;
                case "UserRoleManagementOperation":
                    return "dbo.SIC_sys_UserRoleManagement" + parameter + ",@RoleName,@RolePriority,@AccessScope,@Permission,@Comments";
                case "UserRoleMatchManagement":
                    return "dbo.SIC_sys_UserRoleMatchManagement" + parameter ;
                case "UserRoleMatchManagementOperation":
                    return "dbo.SIC_sys_UserRoleMatchManagement" + parameter +",@MatchDesc,@MatchRole,@MatchScope";
                case "UserRolePermission":
                    return "dbo.SIC_sys_UserRolePermission" + parameter + ",@ModelID";
                case "UserRolePermissionOperation":
                    return "dbo.SIC_sys_UserRolePermission" + parameter +",@ModelID,@AccessScope,@Permission,@Comments";
                case "GroupMemberTeacher":
                   return "dbo.SIC_sys_UserGroupMember_Teachers" + parameter1 +",@CPNum";
                case "GroupMemberStudent":
                    return "dbo.SIC_sys_UserGroupMember_Students" + parameter1 + ",@AppID,@GroupID,@GroupType,@GroupMember";
                case "PushGroupToApps":
                    return "dbo.SIC_sys_UserGroupMember_PushToApps @Operate,@UserID,@SchoolCode,@AppID,@GroupID,@AppIDTo,@InCludeMemberS,@InCludeMemberT";
                 case "ActionMenuList":
                    return "dbo.SIC_sys_ActionMenuList" + parameter1 + ",@TabID,@ObjID,@Semester,@Term,@AppID";
                default:
                    return action;

            }


        }
    }
}