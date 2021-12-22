using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public interface IDataOperateService<T>
    {
        List<T> ListOfT(string sp, object parameter);
        List<T> ListOfT(string sp, object parameter, string DapperCommandType);
        List<T> ListOfT(string db, string sp, object parameter);
        List<T> ListOfT(string db, string sp, object parameter, string DapperCommandType);


        string EditResult(string sp, object parameter);
        string EditResult(string sp, object parameter, string DapperCommandType);
        string EditResult(string db, string sp, object parameter);
        string EditResult(string db, string sp, object parameter, string DapperCommandType);

        T ValueOfT(string sp, object parameter);
        T ValueOfT(string sp, object parameter, string DapperCommandType);
        T ValueOfT(string db, string sp, object parameter);
        T ValueOfT(string db, string sp, object parameter, string DapperCommandType);
    }
}
