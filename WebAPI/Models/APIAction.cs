using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI
{
    public class APIAction<T> : IAPIAction<T>
    {
        private readonly DataOperateService<T> _dataOperate = (DataOperateService<T>)MapClass<T>.DBSource();  // new DataOperateService<UserGroup>(new DataOperateServiceSQL<UserGroup>());

        public List<T> ListOfT(string apiType, string sp, object parameter)
        {   
            return _dataOperate.ListOfT(apiType, sp, parameter);
        }

        public string ValueOfT(string apiType, string sp, object parameter)
        {
            
            return _dataOperate.EditResult(apiType, sp, parameter);
          
        }
    }
}