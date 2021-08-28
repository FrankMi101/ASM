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
        private readonly IDataOperateService<T> _iDataOperateService;
        public DataOperateService(string dataSource) //IDataOperateService<T> iDos)
        {
            this._iDataOperateService = (IDataOperateService<T>)MapClass<T>.DBSource(dataSource);// iDos;
        }
        public string EditResult(string apiType, string sp, object parameter)
        {
           return _iDataOperateService.EditResult(apiType, sp, parameter);
    
        }

        public List<T> ListOfT(string apiType, string sp, object parameter)
        {
            return _iDataOperateService.ListOfT(apiType, sp, parameter);
        
        }
        public List<T> ListOfT(string sp, object parameter)
        {
            return _iDataOperateService.ListOfT( sp, parameter);
        }
    }
}
