using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
   public class ActionAppList<T> :IGet<T>
    {
        //private IGet<T> _iget;
        //public ActionGridList(IGet<T> iget)
        //{
        //    this._iget = iget;
        //}
        public static List<T> GetObjList(string sp, object parameter)
        {
            return GeneralList.CommonList<T>(sp, parameter);
        }

        public List<T> GetObjByID(int id)
        {
            throw new NotImplementedException();
        }

        public List<T> GetObjList(object parameter)
        {
            throw new NotImplementedException();
        }

        public string GetSPName(string action)
        {
            throw new NotImplementedException();
        }
    }
}
