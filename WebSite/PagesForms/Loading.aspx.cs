using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesForms
{
    public partial class Loading : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string pID = Page.Request.QueryString["pID"].ToString();
                //string ids = Page.Request.QueryString["IDs"].ToString();
                //string sCode = Page.Request.QueryString["SchoolCode"].ToString();
                //string sYear = Page.Request.QueryString["SchoolYear"].ToString();
                //string appID = Page.Request.QueryString["AppID"].ToString();
                //string modelID = Page.Request.QueryString["ModelID"].ToString();
                //string xID = Page.Request.QueryString["xID"].ToString();
                //string xName = Page.Request.QueryString["xName"].ToString();
                //string xType = Page.Request.QueryString["xType"].ToString();
                //string action = Page.Request.QueryString["Action"].ToString();
                //string Para = "?Action=" + action + "&IDs=" + ids + "&SchoolYear=" + sYear + "&SchoolCode=" + sCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
 
                string queryStr = AppsPage.GetQueryString(Page);  
 
                PageURL.HRef = GetGoPage(pID, queryStr);
            }
        }
        private string GetGoPage(string page, string queryStr)
        {
            if (!File.Exists(Server.MapPath(page)))
            { page = "../ComeSoon.aspx?pID=" + page; }
            else
            { page += "?" + queryStr; }
            return page;
        }
    }
}