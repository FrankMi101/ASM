using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IActionAppService<T>:IGet<T>
    {
        ////List<T> GetObjList(object parameter);
        ////List<T> GetObjByID(int id);
        string AddObj(object parameter);
        string EditObj(object parameter);
        string RemoveObj(object parameter);
        string DeleteObj(int id);
    }
}
