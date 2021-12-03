//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class AppRoleManageSub : System.Web.UI.Page
    {
        readonly string pageID = "AppRoleManagementSub";
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
            hfUserID.Value  = WorkingProfile.UserId  ;
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
                UserID  = WorkingProfile.UserId  ,
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
            try
            {
                GridView_SAP.DataSource = GetDataSource<AppRoleMatchList, AppRoleMatch>("GetList");
                GridView_SAP.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            try
            {
                GridView_Permission.DataSource = GetDataSource<AppRolePermissionList, AppRolePermission>("GetListbyRoleID");
                GridView_Permission.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private List<T> GetDataSource<T, T2>(string operate)
        {
            var parameter = new
            {
                Operate = operate,
                UserID = hfUserID.Value,
                UserRole = hfUserRole.Value,
                RoleID = LabelPositionRole.Text,
                RoleType = hfSelectedTab.Value
            };


            //  var myList = ListData.GeneralList<AppRoleMatchList>("SecurityManage", pageID, parameter);
            var myList = ManagePageList<T, T2>.GetList("SQL", "ClassCall", parameter,ImgSAP);
            return myList;
        }

        private void Assembing_Tab()
        {
            var parameters = new
            {
                Operate = "PositionRoleMatchTab",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolYear = "",
                SchoolCode = ""
            };

            AppsPage.BuildingTab(GradeTab, parameters, hfSelectedTab.Value);

        }


    }
}