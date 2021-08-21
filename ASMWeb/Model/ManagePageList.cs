using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{
    public class ManagePageList<T, T2>
    {
        private static string _sp = MapClass<T2>.SPName("Read"); 
        public static List<T> GetList(ActionApp<T2> spClass, object parameter)
        {
           // _sp = MapClass<T>.SPName("Read");
            return RunGetListFromDB(parameter);
        }
        public static List<T> GetList(string obj, object parameter)
        {
           // ActionApp<T2> spClass = (ActionApp<T2>)MapClass<T>.ClassType(obj);
          //  _sp = MapClass<T2>.SPName("Read");
            return RunGetListFromDB(parameter);
        }
        public static List<T> GetList(ActionApp<T2> spClass, object parameter, WebControl actionControl)
        {
            // _sp = spClass.GetSPName("");
         //   _sp = MapClass<T2>.SPName("Read");
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = _sp;
            return RunGetListFromDB(parameter);
        }
        public static List<T> GetList(string obj, object parameter, WebControl actionControl)
        {
            //  ActionApp<T2> spClass = (ActionApp<T2>)MapClass<T>.ClassType(obj);
            //    _sp = spClass.GetSPName("");
           // _sp = MapClass<T2>.SPName("Read");
            if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = _sp;
            return RunGetListFromDB(parameter);
        }

        public static List<T> GetListbyT2(string obj, object parameter)
        {
            // _sp = MapClass<T2>.SPName("");

            return RunGetListFromDB(parameter);
        }
        private static List<T> RunGetListFromDB( object parameter)
        {
          return ActionAppList<T>.GetObjList(_sp, parameter);
        }
    }
   
}