using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{/// <summary>
/// Data from Oracel Database
/// </summary>
/// <typeparam name="T"></typeparam>
    public class DataOperateServiceORA<T> : IDataOperateService<T>
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
            return CommonExecute<T>.ListOfT( sp, parameter);
        }

        public List<T> ListOfT(string db, string sp, object parameter)
        {
            return CommonExecute<T>.ListOfT(db, sp, parameter);
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
            return CommonExecute<T>.ValueOfT(db, sp, parameter);
        }

        public T ValueOfT(string sp, object parameter)
        {
            return CommonExecute<T>.ValueOfT( sp, parameter);
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
