﻿using System;
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
                 string queryStr = AppsPage.GetQueryString(Page);

                PageURL.HRef = GetGoPage(pID, queryStr);
            }
        }
        private string GetGoPage(string page, string queryStr)
        {
            var runingPermission = WorkingProfile.Permission;
            if (runingPermission == "Deny")
            { page = "~/PagesOther/AccessDeny.aspx"; }
            else
            {
                if (!File.Exists(Server.MapPath(page)))
                { page = "../PagesOther/ComeSoon.aspx?pID=" + page; }
                else
                { page += "?" + queryStr; }

            }
            return page;
        }

    }
}