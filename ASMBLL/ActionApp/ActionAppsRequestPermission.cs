using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppsRequestPermission : ActionAppBase<RequestPermission>
    {
        private readonly string _objName = typeof(RequestPermission).Name;
        public ActionAppsRequestPermission()
        {
        }
        public ActionAppsRequestPermission(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, RequestPermission paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolYear,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.StaffUserID,
                paraObj.UserRole,
                paraObj.Permission,
                paraObj.RequestType,
                paraObj.RequestValue,
                paraObj.AccessScope,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.Comments,
                paraObj.RequestVerify,
                paraObj.GrantAction
            };
            return parameter;
        }

    }
}
