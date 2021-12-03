using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace ASMBLL
{
    public class ActionAppList<T, T2> : IActionGet<T>
    {
        private readonly IDataOperateService<T> _dataOperateService;
        public ActionAppList()  
        {
            this._dataOperateService = MapClassForDB<T>.DBSource(); 
        }
        public ActionAppList(string dataSource)   
        {
            this._dataOperateService =  MapClassForDB<T>.DBSource(dataSource);
        }
        public List<T> GetObjByID(int id)
        {
            string sp = MapClass<T2>.SPName("Edit");
            var parameter = new { Operate = "Get", UserID = "asm", IDs = id };
            return _dataOperateService.ListOfT(sp, parameter);
          //  return GeneralList.CommonList<T>(sp, parameter);
        }

        public List<T> GetObjList(object parameter)
        {
            string sp = MapClass<T2>.SPName("Read");
            return _dataOperateService.ListOfT(sp, parameter);
         }
   
        public List<T> GetObjList(string dataSource, object parameter)
        {
            if (dataSource == "ClassCall") dataSource = MapClass<T2>.SPName("Read");

            return _dataOperateService.ListOfT(dataSource, parameter);

        }

        public string GetSPName(string action)
        {
          return  MapClass<T2>.SPName(action);
        }

     
    }
}
