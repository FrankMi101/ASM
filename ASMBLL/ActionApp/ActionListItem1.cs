using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionListItem1 : IActionGet<NameValueList> 
    {
       // private IDataOperate<NameValueList> _dataOperate = new DataOperate<NameValueList>();
        private readonly IDataOperateService<NameValueList> _dataOperate =  MapClassForDB<NameValueList>.DBSource(); // new DataOperateService<AppRole>(new DataOperateServiceSQL<AppRole>());

        private string _sp = "dbo.SIC_sys_ListItems @Operate, @UserID,@UserRole,@Para1,@Para2,@Para3,@Para4";
        public List<NameValueList> GetObjByID(int id)
        {
            throw new NotImplementedException();
        }

        public List<NameValueList> GetObjByID(string dataSource, int id)
        {
            throw new NotImplementedException();
        }

        public List<NameValueList> GetObjList(object parameter)
        {
             return _dataOperate.ListOfT(_sp, parameter);
        }

        public List<NameValueList> GetObjList(string dataSource, object parameter)
        {
            throw new NotImplementedException();
        }

        public string GetSPName(string action)
        {
            return _sp;
        }
    }
}
