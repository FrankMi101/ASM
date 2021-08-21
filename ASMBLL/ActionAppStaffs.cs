using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppStaffs : IActionApp<StaffListSearch> 
    {
        private string _sp = MapClass<StaffListSearch>.SPName("Read"); 

        private readonly string _invalidMessage = "Invalid Group ID";
        private readonly string _objName = typeof(StaffListSearch).Name;
        private readonly DataOperateService<StaffListSearch> _dataOperate = (DataOperateService<StaffListSearch>)MapClass<StaffListSearch>.DBSource();  // new DataOperateService<StaffListSearch>(new DataOperateServiceSQL<StaffListSearch>());

        public string GetSPName(string action)
        {
            return _sp;
        }
        public List<StaffListSearch> GetObjList(object parameter)
        {
            return _dataOperate.ListOfT(_objName, _sp, parameter);
        }
        public List<StaffListSearch> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            _sp = MapClass<StaffListSearch>.SPName("Edit"); //  CheckStoreProcedureParameters.GetParamerters(_spEdit, para);
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(StaffListSearch parameter)
        {
            throw new NotImplementedException();
        }

        public string EditObj(StaffListSearch parameter)
        {
            throw new NotImplementedException();

        }
        public string RemoveObj(StaffListSearch parameter)
        {
            throw new NotImplementedException();

        }
        public string DeleteObj(int id)
        {
            throw new NotImplementedException();
        }
       
        private object GetParameter(string operate, StaffListSearch paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.UserRole,
                paraObj.SchoolCode,
                paraObj.SearchBy,
                paraObj.SearchValue,
                paraObj.Scope,
            };
            return parameter;
        }


    }
}
