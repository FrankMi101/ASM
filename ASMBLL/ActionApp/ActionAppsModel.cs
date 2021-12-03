using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppsModel : ActionAppBase<AppsModel> 
    {
         private readonly string _objName = typeof(AppsModel).Name;
        public ActionAppsModel()
        {
        }
        public ActionAppsModel(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, AppsModel paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.ModelName,
                paraObj.Developer,
                paraObj.Owners,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.Comments
            };
            return parameter;
        }
 
    }
}
