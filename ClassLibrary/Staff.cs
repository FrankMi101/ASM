using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Staff : Employee
    {
        public string PersonID { get; set; }
        public string StaffName { get; set; }
        public string HireDate { get; set; }
        public string SchoolName { get; set; }
        public string SchoolCode { get; set; }
        public string FTE { get; set; }
        public string PickedForGAL { get; set; }
        public string Category { get; set; }

    }
    
}
