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
        private readonly IDataOperateService<StaffListSearch> _dataOperate;// = (IDataOperateService<StaffListSearch>)MapClass<StaffListSearch>.DBSource("SQL");  // new DataOperateService<StaffListSearch>(new DataOperateServiceSQL<StaffListSearch>());
        public ActionAppStaffs()  //DataOperateService<T> iDos)
        {
            this._dataOperate = (IDataOperateService<StaffListSearch>)MapClass<StaffListSearch>.DBSource();
        }
        public ActionAppStaffs(string dataSource)  //DataOperateService<T> iDos)
        {
            this._dataOperate = (IDataOperateService<StaffListSearch>)MapClass<StaffListSearch>.DBSource(dataSource);
        }
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
    }
}
