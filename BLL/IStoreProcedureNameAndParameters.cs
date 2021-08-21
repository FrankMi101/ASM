using System;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public  interface IStoreProcedureNameAndParameters
    {
        string SPNameAndPara(string category, string action);
        string SPNameAndPara(string category,string action, object parameter);
    }
    public class StoreProcedureNameAndParameters : IStoreProcedureNameAndParameters
    {
        public string SPNameAndPara(string category, string action)
        {
            throw new NotImplementedException();
        }
        public string SPNameAndPara(string category, string action, object parameter)
        {
            var sp = SPNameAndPara(category,action);
            return CheckStoreProcedureParameters.GetParamerters(sp, parameter);
        }

   
    }
}
