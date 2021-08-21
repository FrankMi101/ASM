using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{
    public class AppsBaseDb : System.Web.UI.Page
    {
        public static List<T> GeneralList<T>(string db,string sp, object parameter)
        {
            return  BLL.Common.CommonList<T>(db,sp, parameter);
        }
        public static List<T> GeneralList<T>(string db,string sp, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(db,sp, parameter);
        }
        public static List<T> GeneralList<T>(string db, string className, string action, object parameter)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            return GeneralList<T>(db,sp, parameter);
        }

        public static List<T> GeneralList<T>(string db, string className, string action, object parameter, WebControl actionControl)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(db,sp, parameter);
        }


        public static T GeneralValue<T>(string db, string sp, object parameter)
        {
            return BLL.Common.CommonValue<T>(db,sp, parameter);
        }
        public static T GeneralValue<T>(string db,string sp, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralValue<T>(db, sp, parameter);
        }
        public static T GeneralValue<T>(string db, string className, string action, object parameter)
        {
            string sp = BLL.Common.SPName(className, action, parameter);

            return GeneralValue<T>(db,sp, parameter);  
        }
        public static T GeneralValue<T>(string db, string className, string action, object parameter, WebControl actionControl)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralValue<T>(db, sp, parameter); 
        }
    }
}