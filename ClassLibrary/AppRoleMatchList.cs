using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClassLibrary
{
   public  class AppRoleMatchList : AppRoleMatch
    {
        public int RowNo { get; set; }
        public string Actions { get; set; }
        public string DeleteAction { get; set; }
        public string EditAction { get; set; }
    }
}
