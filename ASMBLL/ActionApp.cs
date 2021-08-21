using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionApp<T>  
    {
        private readonly IActionApp<T> _iAction;
        public ActionApp(IActionApp<T> iAction ){
            _iAction = iAction;
          //   _iGet = iGet;
        }

        public string AddObj(T parameter)
        {
            return _iAction.AddObj(parameter);
        }

        public string DeleteObj(int id)
        {
            return _iAction.DeleteObj(id);
        }

        public string EditObj(T parameter)
        {
            return _iAction.EditObj(parameter);
        }
        public string RemoveObj(T parameter)
        {
            return _iAction.RemoveObj(parameter);
        }
        public List<T> GetObjByID(int id)
        {
            return _iAction.GetObjByID(id);
        }

        public List<T> GetObjList(object parameter)
        {
            return _iAction.GetObjList(parameter);
        }

        public string GetSPName(string action)
        {
          return _iAction.GetSPName(action);
        }

    
    }
     
}
