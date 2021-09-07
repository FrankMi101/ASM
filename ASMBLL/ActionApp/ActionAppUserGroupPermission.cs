using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionUserGroupPermission : IActionApp<UserGroupPermission>
    {
        private string _sp = MapClass<UserGroupPermission>.SPName("Read");
        //private readonly string _spRead = "dbo.SIC_asm_UserGroupPermission_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_UserGroupPermission_Edit";
        private readonly string _invalidMessage = "Invalid Role ID";
        private readonly string _objName = typeof(UserGroupPermission).Name;
        private readonly IDataOperateService<UserGroupPermission> _dataOperate;// = (IDataOperateService<UserGroupPermission>)MapClass<UserGroupPermission>.DBSource("SQL"); // new DataOperateService<UserGroupPermission>(new DataOperateServiceSQL<UserGroupPermission>());
        public ActionUserGroupPermission()  //DataOperateService<T> iDos)
        {
            this._dataOperate = (IDataOperateService<UserGroupPermission>)MapClass<UserGroupPermission>.DBSource();
        }
        public ActionUserGroupPermission(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate = (IDataOperateService<UserGroupPermission>)MapClass<UserGroupPermission>.DBSource(dataSource);
        }
        //  private AppClass myMap = MapClass<UserGroupPermission>.GetClass(); 
        public string GetSPName(string action)
        {
            return _sp;
        }
        public List<UserGroupPermission> GetObjList(object parameter)
        {
            // var para = new { Operate = "GetListAll", UserID = "asm", UserRole = "admin"};
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);// "dbo.SIC_asm_UserGroupPermissionList @Operate";
            //  var para = new { Operate = "GetList" };
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<UserGroupPermission> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<UserGroupPermission>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, parameter);
        }

        public List<UserGroupPermission> GetObjByID(string dataSource, int id)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<UserGroupPermission>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, id);
        }
        public List<UserGroupPermission> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "GetbyID", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<UserGroupPermission>.SPName("Edit");   //  CheckStoreProcedureParameters.GetParamerters(_spRead, para);

            return _dataOperate.ListOfT(_objName, _sp, para);


        }
        public string AddObj(UserGroupPermission parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(UserGroupPermission parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }

        public string RemoveObj(UserGroupPermission parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);
        }

        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new UserGroupPermission { UserID = "tester", IDs = id.ToString() };
            return ObjOperation("Delete", para);
        }
        private string ObjOperation(string action, UserGroupPermission parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<UserGroupPermission>.SPName("Edit");//  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_UserGroupPermissionEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }

        private object GetParameter(string Operate, UserGroupPermission paraObj)
        {
            var parameter = new
            {
                Operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.GroupID,
                paraObj.Permission,
                paraObj.AccessScope,
                paraObj.Comments


            };
            return parameter;
        }

        public string ActionsObj(object parameter)
        {
            throw new NotImplementedException();
        }
    }
}
