using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionGet<T> 
    {
        private readonly IActionGet<T> _iGet;
        public ActionGet(IActionGet<T> iGet){
            _iGet = iGet;
        }

        public List<T> GetObjByID(int id)
        {
            return _iGet.GetObjByID(id);
        }

        public List<T> GetObjList(object parameter)
        {
            return _iGet.GetObjList(parameter);
        }

        public string GetSPName(string action)
        {
            return _iGet.GetSPName(action);
        }
    }
     
}
