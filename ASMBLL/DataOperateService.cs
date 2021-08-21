using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{ /// <summary>
/// Data Operate control Class
/// </summary>
/// <typeparam name="T"></typeparam>
    public class DataOperateService<T>
    {
        private readonly IDataOperateService<T> _iDos;
        public DataOperateService(IDataOperateService<T> iDos)
        {
            this._iDos = iDos;
        }
        public string EditResult(string apiType, string sp, object parameter)
        {
           return _iDos.EditResult(apiType, sp, parameter);
    
        }

        public List<T> ListOfT(string apiType, string sp, object parameter)
        {
            return _iDos.ListOfT(apiType, sp, parameter);
        
        }
        public List<T> ListOfT(string sp, object parameter)
        {
            return _iDos.ListOfT( sp, parameter);
        }
    }
}
