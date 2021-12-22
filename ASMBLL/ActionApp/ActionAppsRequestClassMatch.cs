using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppsRequestClassMatch : ActionAppBase<RequestClassMatch>
    {
        private readonly string _objName = typeof(RequestClassMatch).Name;
        public ActionAppsRequestClassMatch()
        {
        }
        public ActionAppsRequestClassMatch(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, RequestClassMatch paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.IDs,
                paraObj.SchoolYear,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.StaffUserID,
                paraObj.UserRole,
                paraObj.Semester,
                paraObj.Term,
                paraObj.MatchType,
                paraObj.MatchValue,
                paraObj.StartDate,
                paraObj.EndDate,
                paraObj.Comments 
            };
            return parameter;
        }

    }
}
