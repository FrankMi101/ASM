//using BLL;
//using SIC.Generic.LIB;
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
              //  BindViewData();
            }
        }

        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
             hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString(); 

            hfMatchRole.Value = Page.Request.QueryString["AppID"].ToString();
            hfMatchScope.Value = Page.Request.QueryString["ModelID"].ToString();
            LabelMatchType.Text = Page.Request.QueryString["xType"].ToString();
            LabelMatchDesc.Text = Page.Request.QueryString["xID"].ToString();
       

        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlMatchScope, "AccessScope", parameters, hfMatchScope.Value);
            AppsPage.BuildingList(ddlMatchRole, "MatchRole", parameters, hfMatchRole.Value);

        }
  

        private List<AppRoleMatchList> GetDataSource()
        { 
            var parameter = new
            {
                Operate = "Get" , //"RoleInformation",
                UserID = User.Identity.Name,
                UserRole =  hfUserRole.Value,  
                RoleID ="",
                MatchType = LabelMatchType.Text,
                MatchDesc = LabelMatchDesc.Text
            };

            var myList = ListData.GeneralList<AppRoleMatchList>("SecurityManage", pageID, parameter);
            return myList;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           // SaveData("GrantPermission");

        }
  
    }
}