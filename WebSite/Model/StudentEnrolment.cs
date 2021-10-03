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

    public class StudentEnrolment : AppsBaseDb
    {
        static string dbName = WebConfig.getDB("Trillium");
        public StudentEnrolment()
        {

        }
        public static List<T> StudnetEnrolmentRecord<T>(object parameter)
        {
            return GeneralList<T>(dbName, "StudentEnrolmentRecords", "Records", parameter);
        }
        public static List<T> StudnetEnrolmentRecord<T>(object parameter, WebControl actionControl)
        {
            return GeneralList<T>(dbName, "StudentEnrolmentRecords", "Records", parameter, actionControl);
        }



    }
}
