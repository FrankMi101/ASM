using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
 
    public class ActionAppStaffWorkingSchools: ActionAppBase<StaffWorkingSchools>
    {
         public ActionAppStaffWorkingSchools()   
        {
         }

        public ActionAppStaffWorkingSchools(string dataSource) :base (dataSource)
        {
         }

        public override object GetParameter(string operate, StaffWorkingSchools paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolYear,
                paraObj.SchoolCode,
                paraObj.StaffUserID,
                paraObj.AppID,
                paraObj.AppRole
            };
            return parameter;
        }
    }
}
