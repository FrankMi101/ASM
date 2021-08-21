using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class PrincipalList : Employee
    {

        public string SchoolName { get; set; }
        public string SchoolCode { get; set; }
        public string Operate { get; set; }
        public string SchoolYear { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }
    }
}
