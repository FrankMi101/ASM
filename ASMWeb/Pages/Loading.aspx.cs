using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.Pages
{
    public partial class Loading : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string pID = Page.Request.QueryString["pID"].ToString();
                string CPNum = Page.Request.QueryString["CPNum"].ToString();
                string SchoolCode = Page.Request.QueryString["sCode"].ToString();
                string SchoolYear = Page.Request.QueryString["sYear"].ToString();
                string uRole = Page.Request.QueryString["uRole"].ToString();
                string sName = Page.Request.QueryString["sName"].ToString();
                string nwuID = Page.Request.QueryString["nwuID"].ToString();
                string appID = Page.Request.QueryString["appID"].ToString();
                string gID = Page.Request.QueryString["gID"].ToString();
                string gType = Page.Request.QueryString["gType"].ToString();
                string Para = "?CPNum=" + CPNum + "&nwuID=" + nwuID + "&sName=" + sName + "&sCode=" + SchoolCode + "&uRole=" + uRole + "&appID=" + appID + "&gID=" + gID + "&gType=" + gType;
  
                PageURL.HRef = GetGoPage(pID , Para); 
            }
        }
        private string GetGoPage(string page , string para)
        {
            if (!File.Exists(Server.MapPath(page)))
            { page = "ComeSoon.aspx?pID=" + page; }
            else
            {   page +=  para; }
            return page;
        }
    }
}