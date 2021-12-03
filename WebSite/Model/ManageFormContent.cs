using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.HtmlControls;
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
           var action = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return GetListbyID(action, para);
        }
        public static List<T> GetListbyID(string dataSource,string obj, string para)
        {          
           // var action = (IActionApp<T>)MapClass<T>.DBSource(dataSource);
            var action = new ActionAppList<T, T>(dataSource);
            return action.GetObjList(obj, para);
        }
        public static List<T> GetListbyID(IActionApp<T> action, int para, HtmlControl actionControl)
        {
          //  var list = action.GetObjByID(para);

            if (WebConfig.RunningModel() == "Design") actionControl.Attributes.Add("title", action.GetSPName("Read"));

            return GetListbyID(action, para);
        }

        public static List<T> GetListbyID(string obj, int para, HtmlControl actionControl)
        {
            var action = (IActionApp<T>)MapClass<T>.ClassType(obj);
            return GetListbyID(action, para , actionControl);         
        }
    }
 
}