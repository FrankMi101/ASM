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
    public class ActionAppService<T> : IActionApp<T>
    {
        private string _sp = MapClass<T>.SPName("Edit");
        private readonly string _objName = typeof(T).Name;
        private readonly IActionApp<T> _actionApp;

        public ActionAppService()
        {
            //  this._actionApp = (IActionApp<T>)MapClass<T>.ClassType() ;
            //  this._actionApp =  MapClass<T>.ActionClassType("");
            _actionApp = (IActionApp<T>)new ActionApp<T>();
        }
        public ActionAppService(IActionApp<T> iActionapp)
        {
            _actionApp = iActionapp;
            //   this._actionApp = (IActionApp<T>)MapClass<T>.ClassType(objType);
            //   this._actionApp = MapClass<T>.ActionClassType(objType);
        }
        public string GetSPName(string action)
        {
            return _actionApp.GetSPName(action);
        }
        public List<T> GetObjList(object parameter)
        {
            return _actionApp.GetObjList(parameter);
        }
        public List<T> GetObjList(string source, object parameter)
        {
            return _actionApp.GetObjList(parameter);
        }
        public List<T> GetObjByID(int id)
        {
            if (id <= 0) return null;
            return _actionApp.GetObjByID(id);
        }
        public List<T> GetObjByID(string source, int id)
        {
            if (id <= 0) return null;
            return _actionApp.GetObjByID(id);
        }
        public string AddObj(object parameter)
        {
            return _actionApp.AddObj((T)parameter);
        }

        public string EditObj(object parameter)
        {
            return _actionApp.EditObj((T)parameter);
        }
        public string EditObj(string obj, object parameter)
        {
            return _actionApp.EditObj((T)parameter);
        }
        public string RemoveObj(object parameter)
        {
            return _actionApp.EditObj((T)parameter);
        }
        public string DeleteObj(int id)
        {
            return _actionApp.DeleteObj(id);
        }

        public string AddObj(T parameter)
        {
            return _actionApp.AddObj(parameter);
        }

        public string EditObj(T parameter)
        {
            return _actionApp.EditObj(parameter);
        }

        public string RemoveObj(T parameter)
        {
            return _actionApp.EditObj(parameter);
        }
    }
}
