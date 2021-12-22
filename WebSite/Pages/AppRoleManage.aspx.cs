//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class AppRoleManage : System.Web.UI.Page
    {
        readonly string pageID = "AppRoleManagement";
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
            hfAppID.Value = WorkingProfile.DefaultAppID;
            hfUserID.Value  = WorkingProfile.UserId  ;
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
                UserID  = WorkingProfile.UserId  ,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = "All"
            };

            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);

        }

        protected void DDLApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            WorkingProfile.AppID = ddlApps.SelectedValue;
            hfAppID.Value = ddlApps.SelectedValue;
            BindGridViewListData();
        }
        protected void DDLRoleType_SelectedIndexChanged(object sender, EventArgs e)
        {

            BindGridViewListData();
        }


        private void BindGridViewListData()
        {
            GridView1.DataSource = GetDataSource<AppRoleList>();
            GridView1.DataBind();
        }

        private List<T> GetDataSource<T>()
        {
            var parameter = new
            {
                Operate = "GetListbyType",
                UserID  = WorkingProfile.UserId  ,
                IDs = "0",
                UserRole = hfUserRole.Value,
                RoleType = ddlRoleType.SelectedValue,
                RoleID = "", // GroupID match Role Type
                AppID = ddlApps.SelectedValue,
            };

            //   var myList = ListData.GeneralList<T>("SecurityManage", pageID, parameter);
            var myList = ManagePageList<T, AppRole>.GetList("SQL", "ClassCall", parameter, ImgNewRole);
            return myList;
        }


    }
}