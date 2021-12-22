using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class AppWorkingProfile : AppClass
    {
        public string UserRole { get; set; }
        public string ModelID { get; set; }
        public string Permission { get; set; }
        public string AccessScope { get; set; }
    }

}
