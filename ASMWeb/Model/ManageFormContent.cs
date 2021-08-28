using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{
    public class ManageFormContent<T>
    {

        public static List<T> GetListbyID(IActionApp<T> action, int para)
        {
            var list = action.GetObjByID(para);
            return list;
        }
        public static List<T> GetListbyID(string obj, int para)
        {
            IActionApp<T> action = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return GetListbyID(action, para);
        }
        public static List<T> GetListbyID(IActionApp<T> action, int para, WebControl actionControl)
        {
          //  var list = action.GetObjByID(para);

            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = action.GetSPName("Read");

            return GetListbyID(action, para);
        }

        public static List<T> GetListbyID(string obj, int para, WebControl actionControl)
        {
            IActionApp<T> action = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return GetListbyID(action, para , actionControl);         
        }
    }
 
}