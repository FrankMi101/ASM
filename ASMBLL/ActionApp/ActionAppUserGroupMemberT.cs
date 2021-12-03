using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupMemberT : ActionAppBase<UserGroupMemberTeacher>
    {
          public ActionAppUserGroupMemberT()  
        {
           
        }
        public ActionAppUserGroupMemberT(string dataSource):base(dataSource)
        {
           
        }

        public override object GetParameter(string operate, UserGroupMemberTeacher paraObj)
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
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.Comments
            };
            return parameter;
        }


    }
}
