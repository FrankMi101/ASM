//using BLL;
//using SIC.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class SecurityRoleManageSub : System.Web.UI.Page
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
                GetQueryInfo();
                SetPageAttribution();
                AssemblePage();
                BindGridViewListData();
            }
        }
        private void GetQueryInfo()
        {
            LabelPositionRole.Text = Page.Request.QueryString["xID"].ToString(); 

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfCode.Value = "Search";
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfSelectedTab.Value = "PositionDesc";

        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };

            Assembing_Tab();
        }
        private void InitialPage()
        {


        }
        protected void BtnGradeTab_Click(object sender, EventArgs e)
        {
            string Grade = hfSelectedTab.Value;
            if (Grade != "")
            {
                BindGridViewListData();
                Assembing_Tab();
            }

        }

        private void BindGridViewListData()
        {
            string Grade = hfSelectedTab.Value;

            GridView_SAP.DataSource = GetDataSource();
            GridView_SAP.DataBind();
        }

        private List<AppRoleMatchList> GetDataSource()
        {
            var parameter = new
            {
                Operate = "GetList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                AppID  = "",
                RoleID = LabelPositionRole.Text,
                RoleType = hfSelectedTab.Value
            };

        
            var myList = ListData.GeneralList<AppRoleMatchList>("SecurityManage", pageID, parameter);
            return myList;
        }

        private void Assembing_Tab()
        {
            var parameters = new
            {
                Operate = "PositionRoleMatchTab",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear ="",
                SchoolCode = ""
            };
    
            AppsPage.BuildingTab(GradeTab, parameters, hfSelectedTab.Value);
 
        }


    }
}