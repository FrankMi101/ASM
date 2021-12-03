using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppUserGroupPush : ActionAppBase<UserGroupPush> 
    {
          public ActionAppUserGroupPush()  
        {
         }
        public ActionAppUserGroupPush(string dataSource) : base(dataSource)
        {
         }

        public override object GetParameter(string operate, UserGroupPush paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.GroupID,
                paraObj.AppIDTo,
                paraObj.IncludeStudent,
                paraObj.IncludeTeacher
            };
            return parameter;
        }


    }
}
