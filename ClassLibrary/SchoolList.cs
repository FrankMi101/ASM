using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public  class SchoolList :School
    {
        public string Operate { get; set; }
        public string SchoolYear { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string Comments { get; set; }
    }
    public class SchoolSelectedList : SchoolList {
        public string Selected { get; set; }
    }
}
