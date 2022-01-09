using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IActionGet<T>
    {
        List<T> GetObjList(string dataSource, object parameter);
        List<T> GetObjList(object parameter);
        List<T> GetObjByID(int id);
        List<T> GetObjByID(string dataSource,int id);
        string GetSPName(string action);
    }
}
