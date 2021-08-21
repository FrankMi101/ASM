using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CommonSPandParamter 
    {
        public static string GetSPName(List<CommonSP> commonSPs, string  action)
        {
            foreach (var sp in commonSPs)
            {
                return sp.GetSPandParametersByOverride(action);
            }
            return "";
        }
        //public static List<ReportParameter> GetReportParameters(List<IReportParameter> listRPs,  ListOfSelected listSelected)
        //{
        //    foreach (var sp in listRPs)
        //    {
        //        return sp.ReportParameters(listSelected) ;
        //    }
        //    return null;
        //}
    }
}
