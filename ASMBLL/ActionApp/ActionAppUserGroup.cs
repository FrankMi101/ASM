using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
 
    public class ActionAppUserGroup: ActionAppBase<UserGroup>
    {
         public ActionAppUserGroup()   
        {
         }

        public ActionAppUserGroup(string dataSource): base (dataSource)
        {
         }

        public override object GetParameter(string operate, UserGroup paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.GroupName,
                paraObj.GroupType,
                paraObj.Permission,
                paraObj.IsActive,
                paraObj.Comments,
                paraObj.MemberID
            };
            return parameter;
        }
    }
}
