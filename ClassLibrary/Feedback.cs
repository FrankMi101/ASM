using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class Feedback : AppClass
    {
        public string ModelID { get; set; }
        public string UserName { get; set; }
        public string UserRole { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
        public string AppSection { get; set; }
        public string FeedbackType { get; set; }  

    }

}
