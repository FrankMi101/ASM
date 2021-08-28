using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IActionApp<T>:IActionGet<T>
    {
        ////List<T> GetObjList(object parameter);
        ////List<T> GetObjByID(int id);
        string AddObj(T parameter);
        string EditObj(T parameter);
        string RemoveObj(T parameter);
        string DeleteObj(int id);
    }
}
