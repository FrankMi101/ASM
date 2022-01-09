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
    public class ActionService<T> 
    {
        private readonly IActionApp<T> _actionApp;
 
        public ActionService(IActionApp<T> iAction) {
            _actionApp = iAction;
        }
        public string GetSPName(string action)
        {
            return _actionApp.GetSPName(action);
        }

        public List<T> GetObjList(object parameter)
        {
            return _actionApp.GetObjList(parameter);
        }
        public List<T> GetObjByID(  int id)
        { 
            return _actionApp.GetObjByID(id);
        }
        public string GetValue(object parameter)
        {
            return _actionApp.GetValue(parameter);
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
            return _actionApp.RemoveObj(parameter);
        }

        public string DeleteObj(int id)
        {
            return _actionApp.DeleteObj(id);
        }

    }
}