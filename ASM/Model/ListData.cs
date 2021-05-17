using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace ASM
{

    public class ListData : AppsBase
    {
        public ListData()
        {

        }
        public static List<T> SearchGeneralList<T>(string ListPage,object parameter)
        {
            return GeneralList<T>("GeneralList", ListPage, parameter);
        }
        public static List<T> SearchGeneralList<T>(string ListPage, object parameter, WebControl actionControl)
        {
            return GeneralList<T>("GeneralList", ListPage, parameter,actionControl);
        }
        public static string WorkingListContent(object parameter)
        {
            return GeneralValue<string>("GeneralList", "NameValue", parameter);
        }

        public static List<T> SchoolList<T>(object parameter)
        {
            return GeneralList<T>("GeneralList", "SchoolList", parameter);
        }

    }
}
 