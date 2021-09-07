
 
using System.Web.Configuration;

namespace ASMBLL
{

    public class WebConfig
    {
        public static string DataSource()
        {
            return WebConfigurationManager.ConnectionStrings["DataSource"].ConnectionString;
        }
        public static string APISite()
        {
            return WebConfigurationManager.ConnectionStrings["APISite"].ConnectionString;
        }

        public static string getDB(string source)
        {
            string currentDataSource = WebConfigurationManager.ConnectionStrings["currentDB"].ConnectionString;             
            return   source + "_" + currentDataSource;
        }
        public static string getValuebyKey(string key)
        {
            return WebConfigurationManager.AppSettings[key];
        }

        public static string AuthenticationMethod()
        {
            return getValuebyKey("AuthenticationMethod").ToString();
        }
        public static string RunningModel()
        {
            return getValuebyKey("RunningModel");
        }
        public static string SchoolSystem()
        {
            return getValuebyKey("SchoolSystem");
        }
        public static string currentDatabase()
        {
            return getValuebyKey("currentDB");
        }
        public static string LDAPServer()
        {
            return getValuebyKey("LDAP");
        }
        public static string Reportsource()
        {
            return getValuebyKey("Reportsource");
        }
        public static string ReportServer()
        {
            return getValuebyKey("ReportServer");
        }
        public static string ReportServices()
        {
            return getValuebyKey("ReportingService");
        }
        public static string ReportPath()
        {
            return getValuebyKey("ReportPath");
        }
        public static string ReportFormat()
        {
            return getValuebyKey("ReportFormat");
        }
        public static string ReportPath2(string vSES)
        {
            return getValuebyKey("ReportPath") + vSES;
        }
        public static string ReportPathWS()
        {
            return getValuebyKey("ReportPathWS");
        }
        public static string ReportUser()
        {
            return getValuebyKey("WebServiceUser");
        }
        public static string ReportPW()
        {
            return getValuebyKey("WebServiceWP");
        }
        public static string DomainName()
        {
            return getValuebyKey("NetWorkDomain");
        }
        public static string AppName()
        {
            return getValuebyKey("Application");
        }
        public static string MessageNotAllow()
        {
            return getValuebyKey("MessageNotAllow");
        }
        public static string eMailGo()
        {
            return getValuebyKey("eMailTry");
        }


    }
   
}
