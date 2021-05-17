using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace ASM
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            // Code to set up a database connection str when the application start
           // string currentDb = DBConnection.CurrentDB;
          //  string connectStr = DBConnection.ConnectionSTR(currentDb);
          // DataAccess.SetSQLParameter.myDBConStr = connectStr;

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs  
            //Exception Ex = Server.GetLastError();
            //Server.ClearError();
            //Server.Transfer("Error.aspx");
        }
        private void SetSpSource()
        {

            // ************************Setup Data source SP and parameters source*************************************************
            //    <add key="SPFile" value="Content\DataAccess.json"/>
            string spfile = WebConfig.getValuebyKey("SPFile");
            if (spfile != "")
            {
                spfile = Server.MapPath(spfile);
            }

            SPSource.SPFile = spfile;
     
        }
    }
}