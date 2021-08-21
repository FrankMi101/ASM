using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppService<T> : IActionAppService<T> 
    {
        private string _sp = MapClass<T>.SPName("Edit");
        private readonly string _objName = typeof(T).Name;
       private readonly string _invalidMessage = "Invalid Group " + typeof(T).Name + " ID";
        private readonly DataOperateService<T> _dataOperate = (DataOperateService<T>)MapClass<T>.DBSource();  // new DataOperateService<T>(new DataOperateServiceSQL<T>());

        public string GetSPName(string action)
        {
            return  MapClass<T>.SPName(action);
        }
        public List<T> GetObjList(object parameter)
        {
            var sp = MapClass<T>.SPName("Read");
            return _dataOperate.ListOfT(_objName, sp, parameter);
        }
        public List<T> GetObjByID(int id)
        {
            if (id <= 0) return null;

            var para = new { Operate = "Get", UserID = "admin", IDs = id.ToString() };
            return _dataOperate.ListOfT(_objName, _sp, para);
        }
        public string AddObj(object parameter)
        {
            return _dataOperate.EditResult(_objName, _sp, parameter); 
        }

        public string EditObj(object parameter)
        {
             return _dataOperate.EditResult(_objName, _sp, parameter); ;
 
        }
        public string RemoveObj(object parameter)
        {
             return _dataOperate.EditResult(_objName, _sp, parameter); ;
      
        }
        public string DeleteObj(int id)
        {
            if (id <= 0) return _invalidMessage;
 
            object para = new {Operate ="Delete", UserID = "tester", IDs = id.ToString() };
            return _dataOperate.EditResult(_objName, _sp, para);
        }
       
    }
}
