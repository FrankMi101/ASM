using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class RequestPermission : AppClass
    {
        public string ModelID { get; set; }
        public string StaffUserID { get; set; }
        public string UserName { get; set; }
        public string UserRole { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string Permission { get; set; }
        public string AccessScope { get; set; }
        public string RequestType { get; set; }
        public string RequestValue { get; set; }
        public string RequestVerify { get; set; }
        public string RequestDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string GrantAction { get; set; }

    }

}
