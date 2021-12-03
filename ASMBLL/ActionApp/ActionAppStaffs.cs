using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppStaffs : ActionAppBase<StaffListSearch> 
    {
    
        public ActionAppStaffs()  
        {
         }
        public ActionAppStaffs(string dataSource):base (dataSource)
        {
         }
     
    }
}
