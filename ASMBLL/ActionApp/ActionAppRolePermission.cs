using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRolePermission : ActionAppBase<AppRolePermission>
    {
    
        public ActionAppRolePermission()   
        {       
        }
        public ActionAppRolePermission(string dataSource)  : base (dataSource)
        {
         }
    
        public override object GetParameter(string Operate, AppRolePermission paraObj)
        {
            var parameter = new
            {
                Operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.RoleID,
                paraObj.ModelID,
                paraObj.RoleType,
                paraObj.Permission,
                paraObj.AccessScope,
                paraObj.Comments
            };
            return parameter;
        }
    }
}
