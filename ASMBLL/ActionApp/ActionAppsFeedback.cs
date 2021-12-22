using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    public class ActionAppsFeedback : ActionAppBase<Feedback>
    {
        private readonly string _objName = typeof(Feedback).Name;
        public ActionAppsFeedback()
        {
        }
        public ActionAppsFeedback(string dataSource) : base(dataSource)
        {
        }
        public override object GetParameter(string operate, Feedback paraObj)
        {
            var parameter = new
            {
                Operate = operate,
                paraObj.UserID,
                paraObj.UserRole,
                paraObj.IDs,
                paraObj.SchoolYear,
                paraObj.SchoolCode,
                paraObj.AppID,
                paraObj.ModelID,
                paraObj.AppSection,
                paraObj.FeedbackType,
                paraObj.Comments
            };
            return parameter;
        }

    }
}
