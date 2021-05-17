using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace BLL 
{
    
    public class DBConnection
      {
      
        public static string CurrentDB
        {
            get { return getNamebyKey("CurrentDB"); }
        }
        public static string TestDB
        {
            get { return getNamebyKey("Test"); }
        }
        public static string LiveDB
        {
            get { return getNamebyKey("Live"); }
        }
        public static string ConnectionSTR(string name)
        {
            return getNamebyKey(name);
        }
        public static string AuthMethod()
        {
            return getNamebyKey("LDAP");
        }
        private static string getNamebyKey(string name)
        {
            return WebConfigurationManager.ConnectionStrings[name].ToString(); // .ConnectionStrings(_name).ToString;

            //   return System.Configuration.ConfigurationManager.ConnectionStrings[name].ToString();
        }
    }
}
