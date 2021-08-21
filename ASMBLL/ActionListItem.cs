using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionListItem : IGet<NameValueList> 
    {
       // private IDataOperate<NameValueList> _dataOperate = new DataOperate<NameValueList>();
        private readonly DataOperateService<NameValueList> _dataOperate = (DataOperateService<NameValueList>)MapClass<NameValueList>.DBSource(); // new DataOperateService<AppRole>(new DataOperateServiceSQL<AppRole>());

        private string _sp = "dbo.SIC_sys_ListItems @Operate, @UserID,@Para1,@Para2,@Para3,@Para4";
        public List<NameValueList> GetObjByID(int id)
        {
            throw new NotImplementedException();
        }

        public List<NameValueList> GetObjList(object parameter)
        {
             return _dataOperate.ListOfT("ListItems", _sp, parameter);
        }

        public string GetSPName(string action)
        {
            return _sp;
        }
    }
}
