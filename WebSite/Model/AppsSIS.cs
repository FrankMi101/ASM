using ASMBLL;
using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{
    public class AppsSIS: System.Web.UI.Page
    {
        public static List<T> GeneralList<T>(string sp, object parameter)
        {
            return BLL.SISInfoBase.CommonList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(string sp, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(sp, parameter);
        }
        public static List<T> GeneralList<T>(string className, string action, object parameter)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            return GeneralList<T>(sp, parameter);
        }

        public static List<T> GeneralList<T>(string className, string action, object parameter, WebControl actionControl)
        {
            string sp = BLL.Common.SPName(className, action, parameter);
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = sp;
            return GeneralList<T>(sp, parameter);
        }


        public static T GeneralValue<T>(string sp, object parameter)
        {
            return BLL.SISInfoBase.CommonValue<T>(sp, parameter);
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


        public static void BuildingList(System.Web.UI.WebControls.ListControl myListControl, string action, CommonListParameter parameter)
        {
            AssemblingList2.SetLists("", myListControl, action, parameter);
        }

        public static void BuildingList(System.Web.UI.WebControls.ListControl myListControl, string action, CommonListParameter parameter, object initialValue)
        {
            AssemblingList2.SetLists("", myListControl, action, parameter, initialValue);
        }

        public static void BuildingList(System.Web.UI.WebControls.ListControl myListControl, string operate, string userId, string para1, string para2, string para3)
        {
            var parameter = CommonParameters.GetListParameters(operate, userId, para1, para2, para3);
            BuildingList(myListControl, operate, parameter);
        }
        public static void BuildingList(System.Web.UI.WebControls.ListControl myListControl, string operate, string userId, string para1, string para2, string para3, object initialvalue)
        {
            var parameter = CommonParameters.GetListParameters(operate, userId, para1, para2, para3);
            BuildingList(myListControl, operate, parameter, initialvalue);
        }

        public static void BuildingList(System.Web.UI.WebControls.ListControl myCodeListControl, System.Web.UI.WebControls.ListControl myListNameControl, string action, CommonListParameter parameter)
        {
            AssemblingList2.SetListSchool(myCodeListControl, myListNameControl, action, parameter);
        }
        public static void BuildingList(System.Web.UI.WebControls.ListControl myCodeListControl, System.Web.UI.WebControls.ListControl myListNameControl, string action, CommonListParameter parameter, object initialValue)
        {
            AssemblingList2.SetListSchool(myCodeListControl, myListNameControl, action, parameter, initialValue);
        }
    }
}