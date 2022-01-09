//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class AppsManageSub : System.Web.UI.Page
    {
        readonly string pageID = "AppsManageSub";
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
            TextBoxAppsID.Text = Page.Request.QueryString["xID"].ToString();
            TextBoxAppsName.Text = Page.Request.QueryString["xName"].ToString();

        }
 
        private void BindGridViewListData()
        {
            GridView1.DataSource = GetDataSource<AppsModelList>();
            GridView1.DataBind();
        }

        private List<T> GetDataSource<T>()
        {
            var parameter = new
            {
                Operate = "GetListbyAppID",
                UserID  = WorkingProfile.UserId  ,
                IDs = "0",
                UserRole = hfUserRole.Value,
                AppID = TextBoxAppsID.Text
            };

            //   var myList = ListData.GeneralList<T>("SecurityManage", pageID, parameter);
            var myList = ManagePageList<T, AppsModel>.GetList("SQL", "ClassCall", parameter);
            return myList;
        }


    }
}