using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRolePermission : IActionApp<AppRolePermission>
    {
        private string _sp = MapClass<AppRolePermission>.SPName("Read");
        //private readonly string _spRead = "dbo.SIC_asm_AppRolePermission_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_AppRolePermission_Edit";
        private readonly string _invalidMessage = "Invalid Role ID";
        private readonly string _objName = typeof(AppRolePermission).Name;
        private readonly IDataOperateService<AppRolePermission> _dataOperate;// = (IDataOperateService<AppRolePermission>)MapClass<AppRolePermission>.DBSource("SQL"); // new DataOperateService<AppRolePermission>(new DataOperateServiceSQL<AppRolePermission>());
        public ActionAppRolePermission()  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<AppRolePermission>.DBSource();
        }
        public ActionAppRolePermission(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<AppRolePermission>.DBSource(dataSource);
        }
        //  private AppClass myMap = MapClass<AppRolePermission>.GetClass(); 
        public string GetSPName(string action)
        {
            return MapClass<AppRolePermission>.SPName(action); 
        }
        public List<AppRolePermission> GetObjList(object parameter)
        {
            // var para = new { Operate = "GetListAll", UserID = "asm", UserRole = "admin"};
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);// "dbo.SIC_asm_AppRolePermissionList @Operate";
            //  var para = new { Operate = "GetList" };
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<AppRolePermission> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRolePermission>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, parameter);
        }

        public List<AppRolePermission> GetObjByID(string dataSource, int id)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRolePermission>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, id);
        }
        public List<AppRolePermission> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<AppRolePermission>.SPName("Edit");   //  CheckStoreProcedureParameters.GetParamerters(_spRead, para);

            return _dataOperate.ListOfT(_objName, _sp, para);


        }
        public string AddObj(AppRolePermission parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(AppRolePermission parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }

        public string RemoveObj(AppRolePermission parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);
        }

        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<AppRolePermission>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private string ObjOperation(string action, AppRolePermission parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<AppRolePermission>.SPName("Edit");//  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRolePermissionEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }

        private object GetParameter(string Operate, AppRolePermission paraObj)
        {
            var parameter = new
            {
                Operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.RoleID,
                paraObj.ModelID,
                paraObj.RoleType,
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
