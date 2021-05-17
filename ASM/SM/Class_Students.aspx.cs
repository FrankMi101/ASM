using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary;

namespace ASM
{
    public partial class Class_Students : System.Web.UI.Page
    {
        readonly string pageID = "GroupMembersList";
        protected void Page_Error(object sender, EventArgs e)
        {
            Exception Ex = Server.GetLastError();
            Server.ClearError();
            Response.Redirect("../Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                BindGridViewListData();
            }
        }
        private void BindGridViewListData()
        {
           
                    GridView1.DataSource = GetDataSource();
                    GridView1.DataBind();    
         
        }

      
        private List<StudentList> GetDataSource()
        {
            var UserRole = Page.Request.QueryString["UserRole"].ToString();
            var SchoolYear = Page.Request.QueryString["SchoolYear"].ToString();
            var SchoolCode = Page.Request.QueryString["SchoolCode"].ToString();
            var AppID = Page.Request.QueryString["AppID"].ToString();
            var GroupID = Page.Request.QueryString["ObjID"].ToString();

            var parameter = new
            {
                Operate = "ClassStudents",
                UserID = User.Identity.Name,
                UserRole = Page.Request.QueryString["UserRole"].ToString(),
                SchoolYear = Page.Request.QueryString["SchoolYear"].ToString(),
                SchoolCode = Page.Request.QueryString["SchoolCode"].ToString(),
                AppID = Page.Request.QueryString["AppID"].ToString(),
                GroupID = Page.Request.QueryString["ObjID"].ToString(),
            };

            var myList = ListData.SearchGeneralList<StudentList>(pageID, parameter);
            return myList;
        }


    }
}