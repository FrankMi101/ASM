using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    interface IReportParameter
    {
        List<ReportParameter> ReportParameters();
    }
    public class IEPReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public IEPReportParameter(ListOfSelected parameter)
        {
            this._parameter = parameter;
        }
        public List<ReportParameter> ReportParameters()
        {
            var reportParameters = new List<ReportParameter>
            {
               new ReportParameter() { ParaName = "PersonID", ParaValue = _parameter.ObjID },
               new ReportParameter() { ParaName = "SchoolYear", ParaValue = _parameter.SchoolYear },
               new ReportParameter() { ParaName = "SchoolCode", ParaValue = _parameter.SchoolCode },
               new ReportParameter() { ParaName = "Term", ParaValue = "0" },
           };
            return reportParameters;
        }
    }
    public class SSFormReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public SSFormReportParameter(ListOfSelected parameter)
        {
            this._parameter = parameter;
        }
        public List<ReportParameter> ReportParameters()
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
    }
    public class TPAReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public TPAReportParameter(ListOfSelected parameter)
        {
            this._parameter = parameter;
        }

        public List<ReportParameter> ReportParameters()
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
    }
    public class GiftReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public GiftReportParameter(ListOfSelected parameter)
        {
            this._parameter = parameter;
        }

        public List<ReportParameter> ReportParameters()
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
    }
    public class IndexCardReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public IndexCardReportParameter(ListOfSelected parameter)
        {
            this._parameter = parameter;
        }
        public List<ReportParameter> ReportParameters()
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
    }
    public class AlertCardReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;

        public AlertCardReportParameter(ListOfSelected parameter)
        {
            _parameter = parameter;
        }

        public List<ReportParameter> ReportParameters()
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
    }
    public class RCReportParameter : IReportParameter
    {
        readonly ListOfSelected _parameter;
        public RCReportParameter(ListOfSelected parameter)
        {
            _parameter = parameter;
        }

        public List<ReportParameter> ReportParameters()
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
    }

    public class BuildReportingParameters
    {
        public static List<ReportParameter> GetReportParameter(string reportType, ListOfSelected parameter)
        {
            //ParameterFactory pFactory = new ParameterFactory();
            //var pFactory = new ParameterFactory(new IEPPara()) ;
            //return pFactory.rParameter(parameter);
            //  IReportParameter iParameter = new IReportParameter(parameter);

            // var mySPclass = new List<IReportParameter> { new IEPReportParameter() };

            switch (reportType)
            {
                case "IEP":
                    return new IEPReportParameter(parameter).ReportParameters();
                case "TPA":
                    return new TPAReportParameter(parameter).ReportParameters();

                case "SSF":
                    return new SSFormReportParameter(parameter).ReportParameters(); ;

                case "OfficeIndixCard":
                    return new IndexCardReportParameter(parameter).ReportParameters();

                case "RC":
                    return new RCReportParameter(parameter).ReportParameters();
                    ;
                case "AlterRC":
                    return new AlertCardReportParameter(parameter).ReportParameters();

                case "GiftRC":
                    return new GiftReportParameter(parameter).ReportParameters();

                default:
                    return new IEPReportParameter(parameter).ReportParameters();

            }
        }
    }
    public class GenerallObject 
    {

        public static T ObjectOfT<T>(string reportType, ListOfSelected parameter)
        {
            try
            {
                return default(T);
            }
            catch (Exception ex)
            {
                var exm = ex.Message;
                throw;
            }
        }
    }

}
