using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionListItem : ActionAppBase<NameValueList> 
    {
         private readonly string _objName = typeof(NameValueList).Name;
        public ActionListItem()
        {
        }
        public ActionListItem(string dataSource) : base(dataSource)
        {
        }

    }
}
