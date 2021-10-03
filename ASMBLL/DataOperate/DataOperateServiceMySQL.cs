using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{/// <summary>
/// Data from SQL Server 
/// </summary>
/// <typeparam name="T"></typeparam>
    public class DataOperateServiceMySQL<T> : IDataOperateService<T>
    {
        public string EditResult(string apiType, string sp, object parameter)
        {
            return GeneralValue.CommonValue<string>(sp, parameter);
        }

        public List<T> ListOfT(string apiType, string sp, object parameter)
        {
            return GeneralList.CommonList<T>(sp, parameter);
        }
        public List<T> ListOfT(string sp, object parameter)
        {
            return GeneralList.CommonList<T>(sp, parameter);
        }

        public T OperateResult(string db, string sp, object parameter)
        {
            throw new NotImplementedException();
        }
    }
}
