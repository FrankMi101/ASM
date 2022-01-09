using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{

    public class ActionAppStaffWorkingRoles : ActionAppBase<StaffWorkingRoles>
    {
        public ActionAppStaffWorkingRoles()  //DataOperateService<T> iDos)
        {
        }

        public ActionAppStaffWorkingRoles(string dataSource) : base(dataSource)
        {
        }

        public override object GetParameter(string operate, StaffWorkingRoles paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.StaffUserID,
                paraObj.WorkingRole,
                paraObj.AppID,
                paraObj.ScopeBy,
                paraObj.ScopeByValue,
                paraObj.StaffName,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.ActiveFlag,
                paraObj.Comments
            };
            return parameter;
        }
    }
}
