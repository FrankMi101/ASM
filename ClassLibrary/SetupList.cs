using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
    public class SetupList
    {
        public string Operate { get; set; }
        public string UserID { get; set; }

        public int IDs { get; set; }
        public string RowNo { get; set; }
        public string Action { get; set; }
        public string ActionS { get; set; }
        public bool Active { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string Comments { get; set; }

    }
    public class SystemItems : SetupList
    {
        public string Orders { get; set; }
        public string KeyPoint { get; set; }


        public string Category { get; set; }
        public string Area { get; set; }

         
    }
    public class DomainList : SetupList
    {
        public int DomainID { get; set; }
        public string DomainName { get; set; }
      }
    public class CompetencyList : SetupList
    {
        public int CompetencyID { get; set; }
        public string CompetencyName { get; set; }
        public bool TPA { get; set; }  
        public bool NTP { get; set; }  
        public bool LTO { get; set; }  
     }
    public class LookForsList : SetupList
    {
        public int LookForsID { get; set; }
        public string LookForsName { get; set; }

       }


    public class AreaList : SetupList
    {
      
    }
    //public class SchoolList : SetupList
    //{
      
    //    public string Edit { get; set; }
    //    public string BriefName { get; set; }
    //    public bool TPA { get; set; }
    //    public bool PPA { get; set; }
    //    public string Header { get; set; }
    //    public string Supervisor { get; set; }
    //    public string District { get; set; }
    //    public string Panel { get; set; }
    //    public string Type { get; set; }



    //}
}
