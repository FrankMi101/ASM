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
 
        public static List<T> GetListbyID(ActionApp<T> action, int para)
        {
            var list = action.GetObjByID(para);
            return list;
        }
        public static List<T> GetListbyID(string obj, int para)
        {
            ActionApp<T> _action = (ActionApp<T>)MapClass<T>.ClassType(obj);
            var list = _action.GetObjByID(para);

            return list;
        }
        public static List<T> GetListbyID(ActionApp<T> action, int para, WebControl actionControl)
        {
 
            var list = action.GetObjByID(para);

            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = action.GetSPName("Read");

            return list;
        }

        public static List<T> GetListbyID(string obj, int para, WebControl actionControl)
        {
            ActionApp<T> _action = (ActionApp<T>)MapClass<T>.ClassType(obj);

            var list = _action.GetObjByID(para);

            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = _action.GetSPName("Read");

            return list;
        }
    }
 
}