using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupMemberS : ActionAppBase<UserGroupMemberStudent>
    {
        public ActionAppUserGroupMemberS()
        {

        }
        public ActionAppUserGroupMemberS(string dataSource) : base(dataSource)
        {

        }

        public override object GetParameter(string operate, UserGroupMemberStudent paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.MemberID,
                paraObj.GroupType,
                paraObj.Comments
            };
            return parameter;
        }


    }
}
