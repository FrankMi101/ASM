using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   public  class Report
    {
        public int IDs { get; set; }
        public string ReportID { get; set; }
        public string ReportName { get; set; }
        public string ReportTitle { get; set; }
        public string ReportType { get; set; }

        public string Comments { get; set; }
    }
}
