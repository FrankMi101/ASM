using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupMemberT : IActionApp<UserGroupMemberTeacher>
    {
        private string _sp = MapClass<UserGroupMemberTeacher>.SPName("Read");
        //private readonly string _spRead = "dbo.SIC_asm_AppUserGroupMemberT_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_AppUserGroupMemberT_Edit";
        private readonly string _invalidMessage = "Invalid Group Member ID";
        private readonly string _objName = typeof(UserGroupMember).Name;
        private readonly IDataOperateService<UserGroupMemberTeacher> _dataOperate = (IDataOperateService<UserGroupMemberTeacher>)MapClass<UserGroupMemberTeacher>.DBSource();  // new DataOperateService<UserGroup>(new DataOperateServiceSQL<UserGroup>());
        public string GetSPName(string action)
        {
           
            return _sp;
        }
        public List<UserGroupMemberTeacher> GetObjList(object parameter)
        {
          //  _sp = _spRead;// CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }

        public List<UserGroupMemberTeacher> GetObjByID(int id)
        {
            var para = new { Operate = "Get", UserID = "asm", IDs = id.ToString() };
           _sp =  MapClass<UserGroupMemberTeacher>.SPName("Edit");
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(UserGroupMemberTeacher parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(UserGroupMemberTeacher parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }
        public string RemoveObj(UserGroupMemberTeacher parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

            return ObjOperation("Remove", parameter);
        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;
            var para = new UserGroupMemberTeacher() { UserID = "admin", IDs = id.ToString() };
            return ObjOperation("Delete", para);
        }
        private string ObjOperation(string action, UserGroupMemberTeacher parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<UserGroupMemberTeacher>.SPName("Edit");  // CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }

        private object GetParameter(string operate, UserGroupMemberTeacher paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.MemberID,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.Comments
            };
            return parameter;
        }


    }
}
