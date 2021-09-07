using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.Pages
{
    public partial class Loading2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string pID = Page.Request.QueryString["pID"].ToString();
                string appID = Page.Request.QueryString["appID"].ToString();
                string xID = Page.Request.QueryString["xID"].ToString();
                string xType = Page.Request.QueryString["xType"].ToString();
                string SchoolCode = WorkingProfile.SchoolCode; 
                string SchoolYear = WorkingProfile.SchoolYear;

                if (Page.Request.QueryString["sCode"] != null) SchoolCode = Page.Request.QueryString["sCode"].ToString();
 
                if (Page.Request.QueryString["sYear"] != null) SchoolYear = Page.Request.QueryString["sYear"].ToString();
 
                string Para = "?sYear=" + SchoolYear  + "&sCode=" + SchoolCode  + "&appID=" + appID + "&xID=" + xID + "&xType=" + xType;
  
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