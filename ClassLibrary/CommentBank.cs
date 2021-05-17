using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   
    public class CommentBank
    {
        public string Comments { get; set; }
        public string DomainName { get; set; }
        public string Shared { get; set; }
        public string IDs { get; set; }
        public string DomainID { get; set; }
        public string SharedID { get; set; }
        public string Active { get; set; }
        public int RowNo { get; set; }
        public string Action { get; set; }

        public string ActionS { get; set; }

    }

    public class StrategyBank  : CommentBank
    {
        public string Panel { get; set; }
        public int TreeLevel { get; set; }
        public string Notes { get; set; }
        public string CompetencyID { get; set; }
        public string LookForsID { get; set; }

        public string TipsID { get; set; }
        
        public string ItemCode { get; set; }

        


    }
}
