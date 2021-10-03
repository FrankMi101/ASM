using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
 
    public class ActionAppUserGroup: IActionApp<UserGroup>
    {
        //    private readonly Type T1 = typeof(UserGroup).MakeGenericType(u.GetType());
        private string _sp = MapClass<UserGroup>.SPName("Read");
        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(UserGroup).Name;

        private readonly IDataOperateService<UserGroup> _dataOperate;// = (IDataOperateService<UserGroup>)MapClass<UserGroup>.DBSource();  // new DataOperateService<UserGroup>(new DataOperateServiceSQL<UserGroup>());
        public ActionAppUserGroup()  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<UserGroup>.DBSource();
          //  this._dataOperate = (IDataOperateService<UserGroup>)MapClass<UserGroup>.DBSource();
        }

        public ActionAppUserGroup(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =MapClassForDB<UserGroup>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {

            return _sp;

        }
    
        public List<UserGroup> GetObjList(object parameter)
        {
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<UserGroup> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<UserGroup>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(UserGroup parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Add", parameter);
        }

        public string EditObj(UserGroup parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Edit", parameter);
        }
        public string RemoveObj(UserGroup parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);

        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

             var para = new  { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<UserGroup>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private string ObjOperation(string action, UserGroup parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<UserGroup>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private object GetParameter(string operate, UserGroup paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.GroupName,
                paraObj.GroupType,
                paraObj.Permission,
                paraObj.IsActive,
                paraObj.Comments,
                paraObj.MemberID
            };
            return parameter;
        }
    }
}
