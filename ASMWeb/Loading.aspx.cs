using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM
{
    public partial class Loading : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string goPage = Page.Request.QueryString["pID"].ToString();

                switch (goPage)
                {
                    case "StudentList":
                        goPage = "SICStudent/StudentListPage.aspx";
                        break;
                    case "StudentGroupList":
                        goPage = "SICStudent/StudentGroupPage.aspx";
                        break;
                    case "ClassList":
                        goPage = "SICClass/ClassListPage.aspx";
                        break;
                    case "SchoolList":
                        goPage = "SICSchool/SchoolListPage.aspx";
                        break;
                    case "StaffListTCDSB":
                        goPage = "StaffListPage.aspx?Scope=All";
                        break;
                    case "StaffListSchool":
                        goPage = "SICStaff/StaffListPage.aspx?Scope=School";
                        break;
                    case "TPAStaffList":
                        goPage = "SICStaff/StaffListPageTPA.aspx?Scope=School";
                        break;
                    default:
                      //  goPage = "Home.aspx";
                        break;
                }

                PageURL.HRef = GetGoPage(goPage);
            }
        }

        private string GetGoPage(string page)
        {
            if (!File.Exists(Server.MapPath(page)))
              { page = "ComeSoon.aspx?pID="  + page; }

            return page;
        }

    }
}