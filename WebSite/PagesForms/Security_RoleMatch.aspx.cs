//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesForms
{
    public partial class Security_RoleMatch : System.Web.UI.Page
    {
        readonly string pageID = "UserRoleMatchManagement";
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
                SetPageAttribution();
                AssemblePage();
                BindFormData();
            }
        }

        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfUserID.Value  = WorkingProfile.UserId  ;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();

            hfMatchRole.Value = Page.Request.QueryString["xID"].ToString();
            hfMatchScope.Value = Page.Request.QueryString["ModelID"].ToString();
            LabelMatchType.Text = Page.Request.QueryString["xType"].ToString();
            LabelMatchDesc.Text = Page.Request.QueryString["xName"].ToString();


        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlMatchScope, "AccessScope", parameters, hfMatchScope.Value);
            AppsPage.BuildingList(ddlMatchRole, "MatchRole", parameters, hfMatchRole.Value);

        }
        private void BindFormData()
        {
            var matchData = GetDataSource<AppRoleMatchList>()[0];
           // LabelMatchType.Text = matchData.RoleType;
           // LabelMatchDesc.Text = matchData.MatchDesc;
            AppsPage.SetListValue(ddlMatchRole, matchData.MatchRole);
            AppsPage.SetListValue(ddlMatchScope, matchData.MatchScope);
        }

        private List<T> GetDataSource<T>()
        {
            var parameter = new
            {
                Operate = "Get", //"RoleInformation",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                RoleID = hfMatchRole.Value,
                RoleType = LabelMatchType.Text,
                MatchDesc = LabelMatchDesc.Text
            };

            //  var myList = ListData.GeneralList<AppRoleMatchList>("SecurityManage", pageID, parameter);
            var myList = ManagePageList<T, AppRoleMatch>.GetList("SQL", "ClassCall", parameter);
            return myList;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            // SaveData("GrantPermission");

        }

    }
}