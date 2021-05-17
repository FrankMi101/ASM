using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   public  class Teacher : Staff
    {
        public string  HomeClass { get; set; }
        public string Degress { get; set; }
        public string Level { get; set; }
        public string  TeacherName { get; set; }
    }
}
