using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionApp<T>
    {
        private readonly IActionApp<T> _iActionApp; // = (IActionApp<T>)MapClass<T>.ClassType();
       // private readonly ActionAppService<T> _iActionApp; // = (IActionApp<T>)MapClass<T>.ClassType();
        public ActionApp()
        {
           this._iActionApp =  MapClass<T>.ActionClassType("");
        }
        public ActionApp(string objType)
        {
            this._iActionApp = MapClass<T>.ActionClassType(objType);
        }

        public string AddObj(T parameter)
        {
            return _iActionApp.AddObj(parameter);
        }

        public string DeleteObj(int id)
        {
            return _iActionApp.DeleteObj(id);
        }

        public string EditObj(T parameter)
        {
            return _iActionApp.EditObj(parameter);
        }
        public string RemoveObj(T parameter)
        {
            return _iActionApp.RemoveObj(parameter);
        }
        public List<T> GetObjByID(int id)
        {
            return _iActionApp.GetObjByID(id);
        }

        public List<T> GetObjList(object parameter)
        {
            return _iActionApp.GetObjList(parameter);
        }
        public List<T> GetObjList(string dataSource, object parameter)
        {
            var dataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(dataSource);
            if (dataSource == "ClassCall") dataSource = MapClass<T>.SPName("Read");
            return dataOperateService.ListOfT(dataSource, parameter);

        }
        public string ActionsObj(string objType, object parameter)
        {
            var sp = MapClass<T>.SPName("Edit",objType);
            var dataOperateService = MapClassForDB<T>.DBSource();
            return dataOperateService.EditResult(objType, sp, parameter);
        }

        public string GetSPName(string action)
        {
            return _iActionApp.GetSPName(action);
        }

        public static List<T> GetListOfT(string dataSource, object parameter)
        {
            var dataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(dataSource);
            if (dataSource == "ClassCall") dataSource = MapClass<T>.SPName("Read");
            return dataOperateService.ListOfT(dataSource, parameter,"SP");
        }
        public static T GetValueOfT(string dataSource, object parameter)
        {
            var dataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(dataSource);
            if (dataSource == "ClassCall") dataSource = MapClass<T>.SPName("Edit");
            return dataOperateService.ValueOfT(dataSource, parameter, "SP");

         }

    }
 
}
