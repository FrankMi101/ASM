using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRoleMatch : IActionApp<AppRoleMatch> 
    {
        private string _sp = MapClass<AppRoleMatch>.SPName("Read");
        //private readonly string _spRead = "dbo.SIC_asm_AppRoleMatch_Read";
        //private readonly string _spEdit = "dbo.SIC_asm_AppRoleMatch_Edit";
        private readonly string _invalidMessage = "Invalid Role ID";
        private readonly string _objName = typeof(AppRoleMatch).Name;
        private readonly IDataOperateService<AppRoleMatch> _dataOperate;// = (IDataOperateService<AppRoleMatch>)MapClass<AppRoleMatch>.DBSource("SQL"); // new DataOperateService<AppRoleMatch>(new DataOperateServiceSQL<AppRoleMatch>());
        public ActionAppRoleMatch()  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<AppRoleMatch>.DBSource();
        }
        public ActionAppRoleMatch(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<AppRoleMatch>.DBSource(dataSource);
        }
        //  private AppClass myMap = MapClass<AppRoleMatch>.GetClass(); 
        public string GetSPName(string action)
        {
            return _sp;
        }
        public List<AppRoleMatch> GetObjList(object parameter)
        {
            // var para = new { Operate = "GetListAll", UserID = "asm", UserRole = "admin"};
          //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);// "dbo.SIC_asm_AppRoleMatchList @Operate";
                          //  var para = new { Operate = "GetList" };
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<AppRoleMatch> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRoleMatch>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, parameter);
        }

        public List<AppRoleMatch> GetObjByID(string dataSource, int id)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<AppRoleMatch>.SPName("Read");
            return _dataOperate.ListOfT(dataSource, id);
        }
        public List<AppRoleMatch> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get",UserID ="admin", IDs = id.ToString() };
            _sp = MapClass<AppRoleMatch>.SPName("Edit");   //  CheckStoreProcedureParameters.GetParamerters(_spRead, para);

            return _dataOperate.ListOfT(_objName, _sp, para);


        }
        public string AddObj(AppRoleMatch parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Add", parameter);
        }

        public string EditObj(AppRoleMatch parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;

            return ObjOperation("Edit", parameter);
        }

        public string RemoveObj(AppRoleMatch parameter)
        {
            if (parameter.RoleID == null || parameter.RoleID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);
        }

        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;
             var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<AppRoleMatch>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);

        }
        private string ObjOperation(string action, AppRoleMatch parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<AppRoleMatch>.SPName("Edit");//  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleMatchEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }

        private object GetParameter(string operate, AppRoleMatch paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.RoleID,
                paraObj.RoleType,
                paraObj.MatchDesc,
                paraObj.MatchRole,
                paraObj.MatchScope
            };
            return parameter;
        }

        public string ActionsObj(object parameter)
        {
            throw new NotImplementedException();
        }
    }
}
