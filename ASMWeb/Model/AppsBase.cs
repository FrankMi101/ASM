using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{
    public class AppsBase : System.Web.UI.Page
    {
        public static List<T> GeneralList<T>(string sp, object parameter)
        {
            return  BLL.Common.CommonList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(string sp, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(string className, string action, object parameter)
        {
            var mySPclass = new List<CommonSP> { new GeneralList() };
            
            return GeneralList<T>(mySPclass, action, parameter);
        }
        public static List<T> GeneralList<T>(List<CommonSP> classSP ,string action, object parameter)
        {
            string sp = BLL.Common.SPName(classSP, action, parameter);
            return GeneralList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(List<CommonSP> classSP, string action, object parameter, WebControl actionControl)
        {
            string sp = BLL.Common.SPName(classSP, action, parameter);
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(string className, string action, object parameter, WebControl actionControl)
        {
            var mySPclass = new List<CommonSP> { new AppsSecurityManagement()};
            return GeneralList<T>(mySPclass, action, parameter, actionControl);
            //string sp = BLL.Common.SPName(className, action, parameter);
            //if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            //return GeneralList<T>(sp, parameter)       
        }


        public static T GeneralValue<T>(string sp, object parameter)
        {
            return BLL.Common.CommonValue<T>(sp, parameter);
        }
        public static T GeneralValue<T>(string sp, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralValue<T>(sp, parameter);
        }
        public static T GeneralValue<T>(string className, string action, object parameter)
        {
            string sp = BLL.Common.SPName(className, action, parameter);

            return GeneralValue<T>(sp, parameter);  
        }
        public static T GeneralValue<T>(string className, string action, object parameter, WebControl actionControl)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralValue<T>(sp, parameter); 
        }
    }
}