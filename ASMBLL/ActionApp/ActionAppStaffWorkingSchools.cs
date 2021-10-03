using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
 
    public class ActionAppStaffWorkingSchools: IActionApp<StaffWorkingSchools>
    {
        //    private readonly Type T1 = typeof(StaffWorkingSchools).MakeGenericType(u.GetType());
        private string _sp = MapClass<StaffWorkingSchools>.SPName("Read");
        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(StaffWorkingSchools).Name;

        private readonly IDataOperateService<StaffWorkingSchools> _dataOperate;// = (IDataOperateService<StaffWorkingSchools>)MapClass<StaffWorkingSchools>.DBSource();  // new DataOperateService<StaffWorkingSchools>(new DataOperateServiceSQL<StaffWorkingSchools>());
        public ActionAppStaffWorkingSchools()  //DataOperateService<T> iDos)
        {
            this._dataOperate =  MapClassForDB<StaffWorkingSchools>.DBSource();
          //  this._dataOperate = (IDataOperateService<StaffWorkingSchools>)MapClass<StaffWorkingSchools>.DBSource();
        }

        public ActionAppStaffWorkingSchools(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate =MapClassForDB<StaffWorkingSchools>.DBSource(dataSource);
        }
        public string GetSPName(string action)
        {
            return MapClass<StaffWorkingSchools>.SPName(action); ;
        }
    
        public List<StaffWorkingSchools> GetObjList(object parameter)
        {
            //  _sp = _spRead;//  CheckStoreProcedureParameters.GetParamerters(_spRead, parameter);
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<StaffWorkingSchools> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingSchools>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(StaffWorkingSchools parameter)
        {
            if (parameter.SchoolCode == null || parameter.SchoolCode == "") return _invalidMessage;
            return ObjOperation("Add", parameter);
        }

        public string EditObj(StaffWorkingSchools parameter)
        {
            if (parameter.SchoolCode == null || parameter.SchoolCode == "") return _invalidMessage;
            return ObjOperation("Edit", parameter);
        }
        public string RemoveObj(StaffWorkingSchools parameter)
        {
            if (parameter.SchoolCode == null || parameter.SchoolCode == "") return _invalidMessage;
            return ObjOperation("Remove", parameter);

        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;

             var para = new  { Operate = "Delete", UserID = "tester", IDs = id.ToString() };
            _sp = MapClass<StaffWorkingSchools>.SPName("Edit");
            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private string ObjOperation(string action, StaffWorkingSchools parameter)
        {
            var para = GetParameter(action, parameter);
            _sp = MapClass<StaffWorkingSchools>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);// "dbo.SIC_asm_AppRoleEdit @Operate,@UserID,@IDs,@RoleID,@RoleName";

            return _dataOperate.EditResult(_objName, _sp, para);
        }
        private object GetParameter(string operate, StaffWorkingSchools paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolYear,
                paraObj.SchoolCode,
                paraObj.StaffUserID 
            };
            return parameter;
        }
    }
}
