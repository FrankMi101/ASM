using System;
using System.Collections.Generic;
using System.Data;
using System.DirectoryServices;
using System.Text;
using System.Web.Configuration;

namespace BLL
{

    public class Authentication
    {
        public Authentication()
        { }
        public static bool IsAuthenticated1(string _domain, string username, string pwd)
        {
            string _path = WebConfigurationManager.AppSettings["LDAP"];//  WebConfig.getValuebyKey("LDAP");
            string domainAndUsername = _domain + "\\" + username;
            DirectoryEntry entry = new DirectoryEntry(_path, domainAndUsername, pwd);
            try
            {
                Object obj = entry.NativeObject;
                DirectorySearcher search = new DirectorySearcher(entry)
                {
                    Filter = "(SAMAccountName=" + username + ")"
                };
                search.PropertiesToLoad.Add("cn");
                SearchResult result = search.FindOne();


                if (result == null)
                    return false;
                else
                    return true;
            }
            catch (Exception ex)
            {
                // throw new Exception("Error authenticating user." + ex.Message);
                var exm = ex.Message;
                return false;
            }

        }

        public static bool IsAuthenticated(string _domain, string username, string pwd)
        {

            string _path = WebConfigurationManager.AppSettings["LDAP"]; // WebConfig.getValuebyKey("LDAP");
            string domainAndUsername = _domain + "'\'" + username;
            DirectoryEntry entry = new DirectoryEntry(_path, username, pwd);
            try
            {
                Object obj = entry.NativeObject; //  .NativeObject;
                DirectorySearcher search = new DirectorySearcher(entry)
                {
                    Filter = "(SAMAccountName=" + username + ")"
                };
                search.PropertiesToLoad.Add("cn");
                SearchResult result = search.FindOne();

                if (result == null)
                    return false;
                else
                    return true;

            }
            catch (Exception ex)
            {
                string em = ex.Message;
                return false; ;

            }
        }
        public static string AuthenticateMethod()
        {
            string authMethod = WebConfigurationManager.AppSettings["AuthenticateMethod"];
            if (authMethod == "NameOnly")
            {
                string hostName = System.Net.Dns.GetHostName();
                string appServers = WebConfigurationManager.AppSettings["AppServers"];
                if (appServers.Contains(hostName)) authMethod = "NameOnlyFalse";
            }
            return authMethod;
        }

        public static string AuthenticateMethod(string loginUser)
        {
            string authMethod = WebConfigurationManager.AppSettings["AuthenticateMethod"];
            string hostName = System.Net.Dns.GetHostName();
            if (authMethod == "NameOnly")
            {
                string appServers = WebConfigurationManager.AppSettings["AppServers"];
                if (appServers.Contains(hostName)) authMethod = "NameOnlyFalse";
            }
            else
            {
                string developers = WebConfigurationManager.AppSettings["Developers"];
                if (developers.Contains(loginUser.ToLower())) authMethod = "NameOnly";
            }
            return authMethod;
        }

        public static string GetDomain()
        { 
            return System.Environment.UserDomainName; 
        }
        public static string GetDomain(string objName)
        {  if (objName == "") return GetDomain();
            int stop = objName.IndexOf("\\");
            return (stop > -1) ? objName.Substring(0, stop) : string.Empty;
        }
        public static string GetUserName()
        { 
            return System.Environment.UserName;
        }
        public static string GetUserName(string objName)
        {
            if (objName == "") return GetUserName();
            int stop = objName.IndexOf("\\");
            return (stop > -1) ? objName.Substring(stop + 1, objName.Length - stop - 1) : string.Empty;
        }

        //public static string UserRole(string userID)
        //{
        //    try
        //    {
        //        return UserProfile.UserLoginRole(userID);
        //    }
        //    catch (Exception ex)
        //    {
        //        string myEx = ex.Message;
        //        return "Other";
        //    }
        //    finally
        //    { }
        //}
    }
}
