using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{

    public class ActionAppStaffWorkingGroups : IActionApp<StaffWorkingGroups>
    {
        private string _sp = MapClass<StaffWorkingGroups>.SPName("Read");
        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(StaffWorkingGroups).Name;

        private readonly IDataOperateService<StaffWorkingGroups> _dataOperate;
        public ActionAppStaffWorkingGroups()  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<StaffWorkingGroups>.DBSource();
         }

        public ActionAppStaffWorkingGroups(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate = MapClassForDB<StaffWorkingGroups>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {
            return MapClass<StaffWorkingGroups>.SPName(action); ;
        }

        public List<StaffWorkingGroups> GetObjList(object parameter)
        {
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<StaffWorkingGroups> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingGroups>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(StaffWorkingGroups parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Add", parameter);
        }

        public string EditObj(StaffWorkingGroups parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Edit", parameter);
        }
        public string RemoveObj(StaffWorkingGroups parameter)
        {
            if (parameter.GroupID == null || parameter.GroupID == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);

        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

            var para = new { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingGroups>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private string ObjOperation(string action, StaffWorkingGroups parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<StaffWorkingGroups>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private object GetParameter(string operate, StaffWorkingGroups paraObj)
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
