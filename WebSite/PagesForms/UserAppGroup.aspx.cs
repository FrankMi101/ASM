//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.PagesForms
{
    public partial class UserAppGroup : System.Web.UI.Page
    {
        readonly string DataSource = WebConfig.DataSource();
        readonly string pageID = "UserAppGroup";
        protected void Page_Error(object sender, EventArgs e)
        {
            Exception Ex = Server.GetLastError();
            Server.ClearError();
            Response.Redirect("../Error.aspx?pageID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                GetQueryInfo();
                SetPageAttribution();
                AssemblePage();
                BindFormData();
            }
        }
        private void GetQueryInfo()
        {
            labelStaffUserID.Text = Page.Request.QueryString["xID"].ToString();
            hfStaffUserID.Value = Page.Request.QueryString["xID"].ToString();
            hfStaffRole.Value = Page.Request.QueryString["xType"].ToString();
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();




            if (hfAction.Value == "Add") btnSubmit.Value = "Add User To Select Group";
            if (hfAction.Value == "Edit") btnSubmit.Value = "Save & Submit";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Remove User From the Group";

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfUserID.Value = WorkingProfile.UserId;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;

            var para = new
            {
                Operate = "SchoolYearDate",
                UserID = WorkingProfile.UserId,
                SchoolCode = WorkingProfile.SchoolCode,
                SchoolYear = WorkingProfile.SchoolYear,
            };
            var myDate = ManagePageList<SchoolDateStr, SchoolDateStr>.GetList(DataSource, "ClassCall", para);

            hfSchoolyearStartDate.Value = myDate[0].StartDate.ToString();
            hfSchoolyearEndDate.Value = myDate[0].EndDate.ToString();
            dateStart.Value = myDate[0].TodayDate.ToString();
            dateEnd.Value = myDate[0].EndDate.ToString();
        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = WorkingProfile.UserId,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = scope,
                Para4 = WorkingProfile.AppID,
            };
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, WorkingProfile.DefaultAppID);

            SetAppsGroup();

        }
        private void InitialPage()
        {

            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            WorkingProfile.SchoolCode = ddlSchool.SelectedValue;

            AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);



        }
        private void BindFormData()
        {
            if (hfIDs.Value != "0")
            {
                var groupInfo = GetDataSource<StaffWorkingGroups>()[0];
                AppsPage.SetListValue(ddlSchool, groupInfo.SchoolCode);
                AppsPage.SetListValue(ddlSchoolCode, groupInfo.SchoolCode);
                AppsPage.SetListValue(ddlApps, groupInfo.AppID);
                AppsPage.SetListValue(ddlGroupID, groupInfo.GroupID);
                labelStaffUserID.Text = groupInfo.MemberID;
                //  AppsPage.SetListValue(rblPermission, groupInfo.Permission);
                dateStart.Value = groupInfo.StartDate;
                dateEnd.Value = groupInfo.EndDate;
                TextComments.Text = groupInfo.Comments;

            }
        }

        private List<T> GetDataSource<T>()
        {
            var para = new
            {
                Operate = "Get",
                UserID = WorkingProfile.UserId,
                IDs = hfIDs.Value,
            };

            List<T> myList;
            if (DataSource == "API")
            {
                string uri = "WorkingGroup";
                string qStr = "/" + para.IDs;
                myList = ManageFormContent<T>.GetListbyID(DataSource, uri, qStr);
            }
            else
            {
                int ids = int.Parse(para.IDs);
                myList = ManageFormContent<T>.GetListbyID("StaffWorkingGroups", ids, btnSubmit);
            }
            return myList;
        }



        protected void DDLApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetAppsGroup();
        }

        protected void DDLSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            SetAppsGroup();
        }

        protected void DDLSchoolCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchool, ddlSchoolCode.SelectedValue);
            SetAppsGroup();
        }
        private void SetAppsGroup()
        {
            var parameters = new CommonListParameter()
            {
                Operate = "AppsGroupID",
                UserID = WorkingProfile.UserId,
                Para1 = hfUserRole.Value,
                Para2 = ddlApps.SelectedValue,
                Para3 = ddlSchoolCode.SelectedValue,
            };
            AppsPage.BuildingList(ddlGroupID, "AppsGroupID", parameters);
            WorkingProfile.SchoolCode = ddlSchoolCode.SelectedValue;
        }
    }
}