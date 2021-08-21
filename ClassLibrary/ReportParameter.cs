using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
 
 
    public  class ParameterOfReport
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; }
   }
    public class ParameterOfTeacherReport : ParameterOfReport
    {
        public string EmployeeID { get; set; }
        public string SessionID { get; set; }
        public string Category { get; set; }
    }
    public class ParameterOfStudentSSForm : ParameterOfReport
    {
        public string StudentID { get; set; }
        public string FormNo { get; set; }
    }
    public class ParameterOfStudentIEP : ParameterOfReport
    {
        public string StudentID { get; set; }
    }
    public class ParameterOfStudentAlterRC : ParameterOfReport
    {
        public string StudentID { get; set; }
        public string Grade { get; set; }
    }
}
