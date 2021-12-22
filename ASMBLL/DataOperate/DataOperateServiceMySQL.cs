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
        public string EditResult(string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public string EditResult(string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }

        public string EditResult(string db, string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public string EditResult(string db, string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }

        public List<T> ListOfT(string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public List<T> ListOfT(string db, string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public List<T> ListOfT(string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }

        public List<T> ListOfT(string db, string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }

        public T ValueOfT(string db, string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public T ValueOfT(string sp, object parameter)
        {
            throw new NotImplementedException();
        }

        public T ValueOfT(string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }

        public T ValueOfT(string db, string sp, object parameter, string DapperCommandType)
        {
            throw new NotImplementedException();
        }
    }
}
