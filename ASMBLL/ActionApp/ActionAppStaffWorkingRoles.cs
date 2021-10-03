using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{

    public class ActionAppStaffWorkingRoles : IActionApp<StaffWorkingRoles>
    {
        private string _sp = MapClass<StaffWorkingRoles>.SPName("Edit");
        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(StaffWorkingRoles).Name;

        private readonly IDataOperateService<StaffWorkingRoles> _dataOperate;
        public ActionAppStaffWorkingRoles()  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<StaffWorkingRoles>.DBSource();
            //  this._dataOperate = (IDataOperateService<StaffWorkingRoles>)MapClass<StaffWorkingRoles>.DBSource();
        }

        public ActionAppStaffWorkingRoles(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<StaffWorkingRoles>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {
            return MapClass<StaffWorkingRoles>.SPName(action); ;
        }

        public List<StaffWorkingRoles> GetObjList(object parameter)
        {
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<StaffWorkingRoles> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingRoles>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(StaffWorkingRoles parameter)
        {
            if (parameter.WorkingRole == null || parameter.WorkingRole == "") return _invalidMessage;
            return ObjOperation("Add", parameter);
        }

        public string EditObj(StaffWorkingRoles parameter)
        {
            if (parameter.WorkingRole == null || parameter.WorkingRole == "") return _invalidMessage;
            return ObjOperation("Edit", parameter);
        }
        public string RemoveObj(StaffWorkingRoles parameter)
        {
            if (parameter.WorkingRole == null || parameter.WorkingRole == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);

        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingRoles>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private string ObjOperation(string action, StaffWorkingRoles parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<StaffWorkingRoles>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private object GetParameter(string operate, StaffWorkingRoles paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.StaffUserID,
                paraObj.WorkingRole,
                paraObj.StaffName,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.ActiveFlag,
                paraObj.Comments
            };
            return parameter;
        }
    }
}
