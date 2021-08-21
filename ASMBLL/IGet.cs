using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IGet<T>
    {
        List<T> GetObjList(object parameter);
        List<T> GetObjByID(int id);
        string GetSPName(string action);
    }
}
