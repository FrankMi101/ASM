using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppsAccess : ActionAppBase<AppAccess>
    {
        private readonly string _objName = typeof(AppAccess).Name;
        public ActionAppsAccess()
        {
        }
        public ActionAppsAccess(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, AppAccess paraObj)
        {
            var parameter = new
            {
                paraObj.Operate,
                paraObj.UserID,
                paraObj.AppID,
                paraObj.UserRole,
                paraObj.ModelID
            };
            return parameter;
        }

    }
}
