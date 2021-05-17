//using BLL;
//using ASM.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM
{
    public partial class SecurityManageSub : System.Web.UI.Page
    {
        readonly string pageID = "SecurityGroupManageSub";
        protected void Page_Error(object sender, EventArgs e)
        {
            //Exception Ex = Server.GetLastError();
            //Server.ClearError();
            //Response.Redirect("../Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                GetQueryInfo();
                SetPageAttribution();
                AssemblePage();
                BindGridViewListData();
            }
        }
        private void GetQueryInfo()
        {
            hfAppID.Value = Page.Request.QueryString["appID"].ToString();
            TextBoxGroupID.Text = Page.Request.QueryString["gID"].ToString();
            TextBoxGroupType.Text = Page.Request.QueryString["gType"].ToString();
             WorkingProfile.SchoolCode   = Page.Request.QueryString["sCode"].ToString();
            hfSchoolCode.Value = WorkingProfile.SchoolCode;

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfSchoolCode.Value = WorkingProfile.SchoolCode;
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
           
        }
        private void InitialPage()
        {

            //AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            //WorkingProfile.SchoolCode = ddlSchool.SelectedValue;

            //AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            //AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);



        }
   

        private void BindGridViewListData()
        {
            GridView_Students_Group.DataSource = GetDataSource_StudentGroupList();
            GridView_Students_Group.DataBind();

            GridView_Teachers_Group.DataSource = GetDataSource_TeacherGroupList();
            GridView_Teachers_Group.DataBind();
 
        }

   
    
        private List<GroupList> GetDataSource_StudentGroupList()
        {
            var parameter = new
            {
                Operate = "SecurityGroupListStudents",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                AppID = Page.Request.QueryString["appID"].ToString(),
                GroupID = Page.Request.QueryString["gID"].ToString()
            };

            var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);
            return myList;
        }
        private List<GroupList> GetDataSource_TeacherGroupList()
        {
            var parameter = new
            {
                Operate = "SecurityGroupListTeachers",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                AppID = Page.Request.QueryString["appID"].ToString(),
                GroupID = Page.Request.QueryString["gID"].ToString()
            };

            var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);
            return myList;
        }
  
        private void CreateClientMessage(string result, string action) {
            try { 
                string strScript = "ShowSaveMessage('" +  action +"','" + result + "');";

                Page.ClientScript.RegisterStartupScript(GetType(), "actionMessage", strScript, true);
 
            }
            catch (Exception ex)
            { }
        }
    }
}