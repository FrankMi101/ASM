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
        public DataOperateService(string dataSource)  
        {
            this._iDataOperateService =  MapClassForDB<T>.DBSource(dataSource); 
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
        public T OperateResult(string apiType, string sp, object parameter)
        {
            return _iDataOperateService.ValueOfT(apiType, sp, parameter);

        }
    }
}
