using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppRoleMatch :  ActionAppBase<AppRoleMatch> 
    {
        public ActionAppRoleMatch()  
        {
         }
        public ActionAppRoleMatch(string dataSource)  
        {
         }
   
        public override  object GetParameter(string operate, AppRoleMatch paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.RoleID,
                paraObj.RoleType,
                paraObj.MatchDesc,
                paraObj.MatchRole,
                paraObj.MatchScope
            };
            return parameter;
        }
 
    }
}
