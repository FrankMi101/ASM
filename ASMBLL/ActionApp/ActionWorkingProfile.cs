using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionWorkingProfile : ActionAppBase<AppWorkingProfile> 
    {
         private readonly string _objName = typeof(AppWorkingProfile).Name;
        public ActionWorkingProfile()
        {
        }
        public ActionWorkingProfile(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, AppWorkingProfile paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.UserRole
            };
            return parameter;
        }
 
    }
}
