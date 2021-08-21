using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IDataOperate<T>
    {
        List<T> ListOfT(string apiType, string sp, object parameter);
        //T ValueOfT(string apiType, string sp, object parameter);
        //string ObjID(string apiType, string sp, object parameter);
        string EditResult(string apiType, string sp, object parameter);
    }
}
