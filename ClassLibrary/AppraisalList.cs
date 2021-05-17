using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   public  class AppraisalList : Appraisee
    {
        public string ALP { get; set; }
        public string EPA { get; set; }
        public string CurrentSession { get; set; }
        public string Appraisal1 { get; set; }
        public string Appraisal2 { get; set; }
        public string Appraisal3 { get; set; }
        public string Appraisal4 { get; set; }
        public string AppraisalOutcome { get; set; }
        public int RowNo { get; set; }
        public string Actions { get; set; }
    }
}
