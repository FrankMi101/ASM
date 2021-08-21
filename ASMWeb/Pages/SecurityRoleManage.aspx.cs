//using BLL;
//using SIC.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class SecurityRoleManage : System.Web.UI.Page
    {
        readonly string pageID = "UserRoleManagement";
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
                SetPageAttribution();
                AssemblePage();
                //    string pID = Page.Request.QueryString["Scope"].ToString();
                BindGridViewListData();
            }
        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfAppID.Value = "SIC";
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
        }
        private void AssemblePage()
        {
            string BoardRole = WebConfig.getValuebyKey("BoardAccessRole");

            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = "All"
            };
            
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value); 
 
        }
 
        protected void DDLApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            WorkingProfile.ApplicationID = ddlApps.SelectedValue;
            hfAppID.Value = ddlApps.SelectedValue;
            BindGridViewListData();
        }
        protected void DDLRoleType_SelectedIndexChanged(object sender, EventArgs e)
        {
          
            BindGridViewListData();
        }
      
   
        private void BindGridViewListData() { 
            GridView1.DataSource = GetDataSource();
            GridView1.DataBind();
        }

        private List<AppRoleList> GetDataSource()
        {
            var parameter = new
            {
                Operate = "GetList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = hfSchoolYear.Value,   
                SchoolCode =  "0000",
                AppID   = ddlApps.SelectedValue,
                RoleID = "" , // GroupID match Role Type
                RoleType = ddlRoleType.SelectedValue,
            };  
            
                var myList = ListData.GeneralList<AppRoleList>("SecurityManage", pageID, parameter);
            return myList;
        }
 
 
    }
}