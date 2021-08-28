using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionApp<T>  
    {
        private readonly IActionApp<T> _iActionApp;
        public ActionApp(string objType ){
            this._iActionApp = (IActionApp<T>)MapClass<T>.ClassType(objType);
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

        public string GetSPName(string action)
        {
          return _iActionApp.GetSPName(action);
        }

    
    }
     
}
