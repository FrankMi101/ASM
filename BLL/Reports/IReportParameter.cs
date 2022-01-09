using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
  

    public interface IReportParameter
    {
        List<ReportParameter> ReportParameters(InputArg passparameter);
        //string ReportName(string reportType);
    }
  

    public class IEPReportParameter1 : IReportParameter 
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
               new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
               new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
               new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
               new ReportParameter() { ParaName = "Term", ParaValue = "0" },
           };
            return reportParameters ;
        }
   
    }
    public class SSFormReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
                new ReportParameter() { ParaName = "FormNo", ParaValue = _parameter.ObjNo }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }
    public class TPAReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "EmployeeID", ParaValue = _parameter.ObjID },
                new ReportParameter() { ParaName = "SessionID", ParaValue = _parameter.ObjNo },
                new ReportParameter() { ParaName = "Category", ParaValue = _parameter.ObjType }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }
    public class GiftReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
                new ReportParameter() { ParaName = "Term", ParaValue = _parameter.ObjNo }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }
    public class IndexCardReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }
    public class AlertCardReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
                new ReportParameter() { ParaName = "Term", ParaValue = _parameter.ObjNo }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }
    public class RCReportParameter1 : IReportParameter
    {
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            var reportParameters = new List<ReportParameter>
            {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = _parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
                new ReportParameter() { ParaName = "Term", ParaValue = _parameter.ObjNo }
            };
            return reportParameters;
        }
        public string ReportName(string reportType)
        {
            return reportType;
        }
    }


    public class GetCommonReportParameters
    {
        private readonly IReportParameter _iParameter;
        public GetCommonReportParameters(IReportParameter _parameter)
        {
            _iParameter = _parameter;
        }
        public List<ReportParameter> ReportParameters(InputArg _parameter)
        {
            return _iParameter.ReportParameters(_parameter);
        }
        //public string GetName(string reportType)
        //{
        //    return _iParameter.ReportName(reportType); 
        //}
    }
    public class ReportParameterFactory
    {
        public static IReportParameter GetObj(string reportType)
        {
            switch (reportType)
            {
                case "IEP": return new IEPReportParameter1();
                case "TPA": return new TPAReportParameter1();
                case "SSF": return new SSFormReportParameter1();
                case "OfficeIndixCard": return new IndexCardReportParameter1();
                case "RC": return new RCReportParameter1();
                case "AlterRC": return new AlertCardReportParameter1();
                case "GiftRC": return new GiftReportParameter1();
                default: return new IndexCardReportParameter1();
            }
        }
    }
    public class GetSpecificReportParamaters
    {
        public static List<ReportParameter> GetReportParameters(string reportType, InputArg _parameter)
        {
            IReportParameter iReport = ReportParameterFactory.GetObj(reportType);
            var rParaeter = new GetCommonReportParameters(iReport);
            return rParaeter.ReportParameters(_parameter);
        }

        public static List<ReportParameter> GetReportParameters(IReportParameter iReport, InputArg _parameter)
        {
            var rParaeter = new GetCommonReportParameters(iReport);
            return rParaeter.ReportParameters(_parameter);
        }
        public static List<ReportParameter> GetReportParameters_IEP(InputArg _parameter)
        {
            var rParaeter = new GetCommonReportParameters(new IEPReportParameter1());
            return rParaeter.ReportParameters(_parameter);
        }
        public static List<ReportParameter> GetReportParameters_SSF(InputArg _parameter)
        {
            var rParaeter = new GetCommonReportParameters(new SSFormReportParameter1());
            return rParaeter.ReportParameters(_parameter);
        }
        public static List<ReportParameter> GetReportParameters_TPA(InputArg _parameter)
        {
            var rParaeter = new GetCommonReportParameters(new TPAReportParameter1());
            return rParaeter.ReportParameters(_parameter);
        }

    }

}

