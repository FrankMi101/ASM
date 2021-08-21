using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public interface ISecurityManageData {
        string SPName(string action, object parameter);
    }
    public class SecurityManageData : ISecurityManageData
    {
        public string SPName(string action, object parameter)
        {
            string sp = GetSPNamebyAction(action);
            return Common.SPName(sp, parameter);
        }
        private string GetSPNamebyAction(string action) {
            string parameter = " @Operate,@UserID,@UserRole,@AppID,@RoleID,@RoleType";
            string commonPara = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";
            switch (action)
        {
            case "SecurityStaffList":
                return "dbo.SIC_sys_ListofStaffsSecurity" + commonPara+ ",@SearchBy,@SearchValue,@Scope";
            case "SecurityContentList":
                return "dbo.SIC_sys_ListofStaffsSecurityContent" + commonPara+ ",@CPNum";
            case "GroupMembersList":
                return "dbo.SIC_sys_ListofMembersSecurityGroup" + commonPara+ ",@AppID,@GroupID";
            case "SecurityGroupManage":
                return "dbo.SIC_sys_ListofSecurityGroups" + commonPara+ ",@AppID";
            case "SecurityGroupManageSub":
                return "dbo.SIC_sys_ListofSecurityGroups" + commonPara+ ",@AppID,@GroupID";
            case "SchoolDateList":
                return "dbo.SIC_sys_SchoolDateList" + commonPara;
            case "ManageGroupList":
                return "dbo.SIC_sys_UserGroupMember" + commonPara;
            case "ManageGroupContent":
                return "dbo.SIC_sys_UserGroupMember" + commonPara+ ",@AppID,@GroupID";
            case "ManageGroupMember":
                return "dbo.SIC_sys_UserGroupMember" + commonPara+ ",@AppID,@GroupID,@GroupName,@GroupType,@Permission,@IsActive,@Comments,@StudentMember";
            case "UserRoleManagement":
                return "dbo.SIC_sys_UserRoleManagement" + parameter;
            case "UserRoleManagementOperation":
                return "dbo.SIC_sys_UserRoleManagement" + parameter + ",@RoleName,@RolePriority,@AccessScope,@Permission,@Comments";
            case "UserRoleMatchManagement":
                return "dbo.SIC_sys_UserRoleMatchManagement" + parameter;
            case "UserRoleMatchManagementOperation":
                return "dbo.SIC_sys_UserRoleMatchManagement" + parameter + ",@MatchDesc,@MatchRole,@MatchScope";
            case "UserRolePermission":
                return "dbo.SIC_sys_UserRolePermission" + parameter + ",@ModelID";
            case "UserRolePermissionOperation":
                return "dbo.SIC_sys_UserRolePermission" + parameter + ",@ModelID,@AccessScope,@Permission,@Comments";
            case "GroupMemberTeacher":
                return "dbo.SIC_sys_UserGroupMember_Teachers" + commonPara+ ",@CPNum";
            case "GroupMemberStudent":
                return "dbo.SIC_sys_UserGroupMember_Students" + commonPara+ ",@AppID,@GroupID,@GroupType,@GroupMember";
            case "PushGroupToApps":
                return "dbo.SIC_sys_UserGroupMember_PushToApps @Operate,@UserID,@SchoolCode,@AppID,@GroupID,@AppIDTo,@InCludeMemberS,@InCludeMemberT";
            case "ActionMenuList":
                return "dbo.SIC_sys_ActionMenuList" + commonPara+ ",@TabID,@ObjID,@Semester,@Term,@AppID";
            default:
                return action;
        }
        }
    }
}
