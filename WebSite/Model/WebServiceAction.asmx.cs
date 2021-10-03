using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using BLL;
using ClassLibrary;

namespace ASM.Models
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]


    public class WebServiceAction : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
       
        [WebMethod]
        public string SaveGroupTeacher(string operation, GroupOperation parameter)
        {
            try
            {
                parameter.Operate = operation;
                string sp = "dbo.SIC_sys_UserGroupMember_Teachers @Operate,@UserID,@UserRole,@SchoolYear,@SchooCode,@CPNum,@AppID,@GroupID,@Permission,@StartDate,@EndDate,@Comments";
                string result = AppsBase.GeneralValue<string>(sp, parameter);
                return result;
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "Failed";
            }

        }
        
    }
}
