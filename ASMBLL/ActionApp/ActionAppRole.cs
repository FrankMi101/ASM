using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRole : ActionAppBase<AppRole> 
    {

        public ActionAppRole()
        {
         }
        public ActionAppRole(string dataSource) : base(dataSource)
        {
         }
        public override object GetParameter(string operate, AppRole paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.RoleID,
                paraObj.RoleType,
                paraObj.RoleName,
                paraObj.RolePriority,
                paraObj.AccessScope,
                paraObj.Permission,
                paraObj.Comments
            };
            return parameter;
        }
 
    }
}
