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
    public class DataOperateServiceSQL<T> : IDataOperateService<T>
    {
  
        public List<T> ListOfT(string sp, object parameter)
        {
            // return GeneralList.CommonList<T>(sp, parameter);
            return CommonExecute<T>.ListOfT(sp, parameter);
        }
        public List<T> ListOfT(string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<T>.ListOfT(sp, parameter, DapperCommandType);
        }
        public List<T> ListOfT(string db, string sp, object parameter)
        {
            // return GeneralList.CommonList<T>(db, sp, parameter);
            return CommonExecute<T>.ListOfT(db, sp, parameter);
        }
        public List<T> ListOfT(string db, string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<T>.ListOfT(db, sp, parameter, DapperCommandType);
        }



        public T ValueOfT(string sp, object parameter)
        {
            return CommonExecute<T>.ValueOfT(sp, parameter);
        }
        public T ValueOfT(string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<T>.ValueOfT(sp, parameter, DapperCommandType);
        }
        public T ValueOfT(string db, string sp, object parameter)
        {
            //  return GeneralValue.CommonValue<T>(db, sp, parameter);
            return CommonExecute<T>.ValueOfT(db, sp, parameter);
        }
        public T ValueOfT(string db, string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<T>.ValueOfT(db, sp, parameter, DapperCommandType);
        }

        public string EditResult(string sp, object parameter)
        {
            return CommonExecute<string>.ValueOfT(sp, parameter);
        }
        public string EditResult(string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<string>.ValueOfT(sp, parameter, DapperCommandType);
        }
        public string EditResult(string db, string sp, object parameter)
        {
            // return GeneralValue.CommonValue<string>(db,sp, parameter);
            return CommonExecute<string>.ValueOfT(db, sp, parameter);
        }
        public string EditResult(string db, string sp, object parameter, string DapperCommandType)
        {
            return CommonExecute<string>.ValueOfT(db, sp, parameter, DapperCommandType);
        }
    }
}
