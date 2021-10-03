using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupMemberS: IActionApp<UserGroupMemberStudent> 
    {
        private string _sp = MapClass<UserGroupMemberStudent>.SPName("Read");
         //private readonly string _spRead = "dbo.SIC_asm_AppUserGroupMemberS_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_AppUserGroupMemberS_Edit";
        private readonly string _invalidMessage = "Invalid Group Member ID";
        private readonly string _objName = typeof(UserGroupMember).Name;
        private readonly IDataOperateService<UserGroupMemberStudent> _dataOperate;//= (IDataOperateService<UserGroupMemberStudent>)MapClass<UserGroupMemberStudent>.DBSource();  // new DataOperateService<UserGroup>(new DataOperateServiceSQL<UserGroup>());
        public ActionAppUserGroupMemberS()  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<UserGroupMemberStudent>.DBSource();
        }
        public ActionAppUserGroupMemberS(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<UserGroupMemberStudent>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {

            return _sp;
        }

        public List<UserGroupMemberStudent> GetObjList(object parameter)
        {
          //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName,_sp, parameter);
        }

        public List<UserGroupMemberStudent> GetObjByID(int id)
        {
            var para = new { Operate = "Get", UserID ="asm", IDs = id.ToString() };
            _sp = MapClass<UserGroupMemberStudent>.SPName("Edit");  //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(UserGroupMemberStudent parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(UserGroupMemberStudent parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

           return  ObjOperation("Edit", parameter);
        }
        public string RemoveObj(UserGroupMemberStudent parameter)
        {
            if (parameter.MemberID == null || parameter.MemberID == "") return _invalidMessage;

            return ObjOperation("Remove", parameter);
        }
        public string DeleteObj(int id)
        {
            if (id <= 0 ) return _invalidMessage;

             var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<UserGroupMemberStudent>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);

        }
        private string ObjOperation(string action, UserGroupMemberStudent parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<UserGroupMemberStudent>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }
        
        private object GetParameter(string operate, UserGroupMemberStudent paraObj)
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
                paraObj.GroupType,
                paraObj.Comments
            };
            return parameter;
        }

  
    }
}
