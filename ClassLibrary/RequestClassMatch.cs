using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class RequestClassMatch : AppClass
    {
        public string ModelID { get; set; }
        public string StaffUserID { get; set; }
        public string UserName { get; set; }
        public string UserRole { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string Semester { get; set; }
        public string Term { get; set; }
        public string MatchType { get; set; }
        public string MatchValue { get; set; } 
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string GrantAction { get; set; }

    }

}
