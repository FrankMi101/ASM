using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class AppsPatameter 
    {
        public string SearchBy { get; set; }
        public string SearchValue { get; set; }
    }
    public class BaseParameter
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string UserRole { get; set; }  
    }
    public class Base2Parameter :BaseParameter
    {
        public string SchoolYear { get; set; }
        public string SchoolCode { get; set; } 
    }

    public class CommonListParameter : BaseParameter
    {
      
        public string Para1 { get; set; }
        public string Para2 { get; set; }
        public string Para3 { get; set; }
        public string Para4 { get; set; }
    }
    public class GeneralParameter : Base2Parameter
    {
        public string Para1 { get; set; }
        public string Para2 { get; set; }
        public string Para3 { get; set; }
    }
    public class SchoolListParameter : Base2Parameter
    {
        public string Panel { get; set; }
    }
    public class MenuListParameter: SchoolListParameter
    {
        public string TabID { get; set; }
        public string ObjID { get; set; }
        public string PageID { get; set; }

        public string Term { get; set; }
        public string Semester { get; set; }

        public string Grade { get; set; }
        public string StudentID { get; set; }
        public string Category { get; set; }
        public string AppID { get; set; }
        public string GroupID { get; set; }
        public string MemberID { get; set; }

    }
    public class PageHelp
    {
        public string Operate { get; set; }
        public string UserID { get; set; }
        public string Category { get; set; }
        public string Area { get; set; }
        public string Code { get; set; }
    }

    public class ParametersForStudentList
    {
        public string SchoolYear {get; set;}
        public string SchoolCode { get; set; }
        public string Grade { get; set; }
    }

}
