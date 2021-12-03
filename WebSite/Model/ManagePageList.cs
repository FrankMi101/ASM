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
    public class ManagePageList<T, T2>
    {
      //  private static string _sp = MapClass<T2>.SPName("Read");
     
        public static List<T> GetList(string dataSource,string obj, object parameter)
        {
            return RunGetListFromDB(dataSource,obj, parameter);
        }

        public static List<T> GetList(string dataSource, string obj, object parameter, WebControl actionControl)
        {
            if (WebConfig.RunningModel() == "Design") {
               var _sp = MapClass<T2>.SPName("Read");
                actionControl.ToolTip = CheckStoreProcedureParameters.GetParamerters(_sp, parameter); ; 
            }
            return RunGetListFromDB(dataSource,obj, parameter);
        }
   
        private static List<T> RunGetListFromDB(string dataSource,string obj, object parameter)
        {
            //  var objType = "ActionAppList";
            //  IActionGet<T> action = (IActionGet<T>)MapClass<T>.ClassType(objType);

           // var action = (IActionApp<T>)MapClass<T>.ClassType(obj);
          var action = new ActionAppList<T,T2>(dataSource);
            return action.GetObjList(obj, parameter);
 
     }

        //public static List<T> GetList(ActionApp<T2> spClass, object parameter)
        //{
        //    // _sp = MapClass<T>.SPName("Read");
        //    return RunGetListFromDB(parameter);
        //}
        //public static List<T> GetList(ActionApp<T2> spClass, object parameter, WebControl actionControl)
        //{
        //    // _sp = spClass.GetSPName("");
        //    //   _sp = MapClass<T2>.SPName("Read");
        //    if (WebConfig.RunningModel() == "Design") actionControl.ToolTip = _sp;
        //    return RunGetListFromDB(parameter);
        //}
    }

}