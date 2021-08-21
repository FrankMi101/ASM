using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClassLibrary;

namespace ASM.PagesForms
{
    public partial class Group_Teachers : System.Web.UI.Page
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

      
        private List<GroupList> GetDataSource()
        {
            var parameter = new
            {
                Operate = "GroupTeachers",
                UserID = User.Identity.Name,
                UserRole = Page.Request.QueryString["UserRole"].ToString(),
                SchoolYear = Page.Request.QueryString["SchoolYear"].ToString(),
                SchoolCode = Page.Request.QueryString["SchoolCode"].ToString(),
                AppID = Page.Request.QueryString["AppID"].ToString(),
                GroupID = Page.Request.QueryString["GroupID"].ToString(),
                MemberID= Page.Request.QueryString["MemberID"].ToString(),
            };
            

            var myList = ListData.SearchGeneralList<GroupList>(pageID, parameter);
            return myList;
        }


    }
}