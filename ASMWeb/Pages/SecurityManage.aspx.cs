//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class SecurityManage : System.Web.UI.Page
    {
        readonly string pageID = "SecurityGroupManage";
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
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            Session["Semester"] = "1";
            Session["Term"] = "1";
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
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
            if (hfUserRole.Value == "Principal")
            {
                ddlSchoolCode.Enabled = false;
                ddlSchool.Enabled = false;
            }
        }

        protected void BtnSearchGo_Click(object sender, EventArgs e)
        {
            WorkingProfile.ApplicationID = ddlApps.SelectedValue;
            hfAppID.Value = ddlApps.SelectedValue;
            BindGridViewListData();
        }
        protected void DDLSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            UserLastWorking.SchoolCode = ddlSchoolCode.SelectedValue;
        }

        protected void DDLSchoolCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchool, ddlSchoolCode.SelectedValue);
            UserLastWorking.SchoolCode = ddlSchoolCode.SelectedValue;
        }

        private void BindGridViewListData()
        {
            GridView1.DataSource = GetDataSource<GroupList>();
            GridView1.DataBind();

        }

        private List<T> GetDataSource<T>()
        {
            var parameter = new
            {
                Operate = "GroupList", // "SecurityGroupList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolCode = ddlSchool.SelectedValue,
                AppID = ddlApps.SelectedValue
            };

            // var gList =   ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter, btnSearchGo);
           // var spClass = new ActionGet<UserGroup>(new ActionAppUserGroup());
           // var gList = ManagePageList<T,UserGroup>.GetList(spClass,  parameter, btnSearchGo);
            var gList = ManagePageList<T, UserGroup>.GetList("UserGroup", parameter, btnSearchGo);
            return gList;

        }


    }
}