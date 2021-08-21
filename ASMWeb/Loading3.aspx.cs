using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace ASM
{
    public partial class Loading3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {



                var parameter = new MenuListParameter
                {
                    Operate = Page.Request.QueryString["area"],
                    UserID = User.Identity.Name,
                    UserRole = Page.Request.QueryString["uRole"],
                    SchoolYear = Page.Request.QueryString["sYear"],
                    SchoolCode = Page.Request.QueryString["sCode"],
                    Grade = Page.Request.QueryString["grade"],
                    StudentID = Page.Request.QueryString["sID"],
                    PageID = Page.Request.QueryString["pageID"],
                    Term = Session["Term"].ToString(),
                    Category = Page.Request.QueryString["category"],
                    AppID = Page.Request.QueryString["appID"],
                    GroupID = Page.Request.QueryString["groupID"],
                    MemberID = Page.Request.QueryString["memberID"],
                };
                var myGoPageItem = AppsPage.GoPageItemsList<GoPageItems>(parameter)[0];
                string PageSite = myGoPageItem.PageSite;
                string PagePath = myGoPageItem.PagePath;
                string PageFile = myGoPageItem.PageFile;
                string PagePara = myGoPageItem.PagePara;
                string CheckPage = PageSite + PagePath + PageFile;
                string goPage = PageSite + PagePath + PageFile + PagePara;
                if (parameter.PageID == "IEPPDF2")
                {
                    var para1 = ReportRenderADO.reportFormat("PDF");

                    goPage = PageSite + PagePath + PageFile + PagePara + para1;
                }
                var source = Page.Request.QueryString["source"];
                PageURL.HRef = GetGoPage(CheckPage,goPage, source);

            }
        }

        private string GetGoPage(string cPage, string goPage, string source)
        {
            if (source == "InApp")
            {
                if (!File.Exists(Server.MapPath(cPage)))
                { goPage = "ComeSoon.aspx?pID=" + cPage; }

            }

            return goPage;
        }
    }
}