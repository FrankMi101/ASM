using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class ReportBase
    {
        public string ReportName { get; set; }
        public string ReportType { get; set; }
        public string ReportService { get; set; }
        public string ReportPath { get; set; }
        public string ReportFormat { get; set; }
    }
    public class ReportParameter
    {
        public string ParaName { get; set; }
        public string ParaValue { get; set; }

    }
    public class ListOfSelected
    {
        public string UserID { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string ObjID { get; set; }
        public string ObjNo { get; set; }
        public string ObjType { get; set; }
    }
}
