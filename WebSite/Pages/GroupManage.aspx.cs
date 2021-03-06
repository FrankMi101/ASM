//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class GroupManage : System.Web.UI.Page
    {
        readonly string pageID = "GroupManage";
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
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            Session["Semester"] = "1";
            Session["Term"] = "1";
        }
        private void AssemblePage()
        {

            string BoardRole = WebConfig.getValuebyKey("BoardAccessRole");
            string schoolScope = WorkingProfile.SchoolCode;
            if (hfUserRole.Value == "Admin") schoolScope = "0000";
   
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", schoolScope,WorkingProfile.SchoolYear,WorkingProfile.AppID, WorkingProfile.SchoolCode);
            AppsPage.BuildingList(ddlApps, "AppsName", "","","", hfAppID.Value);

            if (hfUserRole.Value == "Principal")
            {
                ddlSchoolCode.Enabled = false;
                ddlSchool.Enabled = false;
            }
        }

        protected void BtnSearchGo_Click(object sender, EventArgs e)
        {
            WorkingProfile.AppID = ddlApps.SelectedValue;
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
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolCode = ddlSchool.SelectedValue,
                AppID = ddlApps.SelectedValue
            };
            List<T> myList;
            if (WebConfig.DataSource() == "API")
            {
                string uri = "common/grouplist";
                string qStr = "/" + parameter.SchoolCode + "/" + parameter.AppID;
                 myList = ManagePageList<T, UserGroup>.GetList("API",uri, qStr, btnSearchGo);
            }
            else
            {
                // var gList =   ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter, btnSearchGo);
                // var spClass = new ActionGet<UserGroup>(new ActionAppUserGroup())             
                myList = ManagePageList<T,UserGroup>.GetList("SQL","ClassCall", parameter, btnSearchGo);
            }
            return myList;

        }


    }
}