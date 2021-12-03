using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionApps : ActionAppBase<Apps>
    {
      
       public ActionApps()
        {
        }
        public ActionApps(string dataSource) : base (dataSource) 
        {        
        }
 
        public override  object GetParameter(string operate, Apps paraObj)
        {
         
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.AppID,
                paraObj.AppName,
                paraObj.Owners,
                paraObj.Developer,
                ActiveFlag  =  paraObj.ActiveFlag ? "x" : "",
                paraObj.AppUrl,
                paraObj.AppUrlTest,
                paraObj.AppUrlTrain,
                paraObj.StartDate,
                paraObj.Comments
            };
            return parameter;
        }
    }
}
