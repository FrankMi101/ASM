using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL 
{
   abstract class ParameterFactory
    {
        public ParameterFactory()
        {
            this.CreateParameter(); 
        }
        public abstract object CreateParameter();
    }
     class IEPParameterFactory : ParameterFactory
    {
        public override object CreateParameter()
        {
           return new IEPPara();
        }
    }
    class SSFParameterFactory : ParameterFactory
    {
        public override object CreateParameter()
        {
           return new SSFPara(); 
        }
    }
    abstract class Para {
        public virtual List<ReportParameter> rParameter(InputArg parameter) {
            var rParameter = new List<ReportParameter>();
            return rParameter;
        } 
    }
   class IEPPara : Para { 
        public IEPPara() {
        }
        public override List<ReportParameter> rParameter(InputArg parameter)
        {
            var rParameter = new List<ReportParameter> {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = parameter.ObjID }
            };
            return rParameter;
        }
    }
    class SSFPara : Para {
        public SSFPara()
        {
        }
        public override List<ReportParameter> rParameter(InputArg parameter)
        {
            var rParameter = new List<ReportParameter> {
                new ReportParameter() { ParaName = "Operate", ParaValue = "Report" },
                new ReportParameter() { ParaName = "UserID", ParaValue = parameter.UserID },
                new ReportParameter() { ParaName = "SchoolYear", ParaValue = parameter.SchoolYear },
                new ReportParameter() { ParaName = "SchoolCode", ParaValue = parameter.SchoolCode },
                new ReportParameter() { ParaName = "PersonID", ParaValue = parameter.ObjID },
                new ReportParameter() { ParaName = "FormNo", ParaValue = parameter.ObjNo }
            };
            return rParameter;
        }
    }
}
