//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.PagesForms
{
    public partial class StaffRoleManage : System.Web.UI.Page
    {
        readonly string DataSource = WebConfig.DataSource();
        readonly string pageID = "StaffRoleManage";
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
                BindFormData();
            }
        }
        private void GetQueryInfo()
        {
            hfStaffUserID.Value = Page.Request.QueryString["xID"].ToString();
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();
            hfStaffRole.Value = Page.Request.QueryString["xType"].ToString();

            labelSatffCPnum.Text = Page.Request.QueryString["ModelID"].ToString();
            labelStaffUserID.Text = Page.Request.QueryString["xID"].ToString();
            labelStaffName.Text = Page.Request.QueryString["xName"].ToString();
            labelSAPRole.Text = Page.Request.QueryString["xType"].ToString();

            if (hfAction.Value == "Add") btnSubmit.Value = "Add User To Select Role";
            if (hfAction.Value == "Edit") btnSubmit.Value = "Save & Submit";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Remove User From the Role";
        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfUserID.Value = WorkingProfile.UserId;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();

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
            var parameters = new CommonListParameter()
            {
                Operate = "AppRole",
                UserID = WorkingProfile.UserId,
                UserRole = hfUserRole.Value,
                Para1 = hfStaffRole.Value,
                Para2 = hfStaffUserID.Value
            };
            AppsPage.BuildingList(ddlGrentRole, "AppRoleAvailable", parameters, WorkingProfile.SchoolYear);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, WorkingProfile.DefaultAppID);
            AppsPage.BuildingList(ddlScopeby, "AccessScope", parameters, "School");
            AssiblingScopeValueDDL( WorkingProfile.SchoolCode );
        }
        private void BindFormData()
        {
            if (hfIDs.Value != "0")
            {
                var RoleInfo = GetDataSource<StaffWorkingRoles>()[0];
                labelStaffName.Text = RoleInfo.StaffName;
                labelSatffCPnum.Text = RoleInfo.CPNum;
                labelSAPRole.Text = RoleInfo.SAPRole;
                dateStart.Value = RoleInfo.StartDate;
                dateEnd.Value = RoleInfo.EndDate;
                TextComments.Text = RoleInfo.Comments;
                chbActive.Checked = RoleInfo.ActiveFlag.ToLower() == "x" ? true : false;
                AppsPage.SetListValue(ddlGrentRole, RoleInfo.WorkingRole);
                AppsPage.SetListValue(ddlApps, RoleInfo.AppID);
                AppsPage.SetListValue(ddlScopeby, RoleInfo.ScopeBy);
                AssiblingScopeValueDDL(RoleInfo.ScopeByValue);
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
                string uri = "WorkingRole/";
                string qStr = "/" + para.IDs;
                myList = ManageFormContent<T>.GetListbyID("DataSource", uri, qStr);
            }
            else
            {
                int ids = int.Parse(para.IDs);
                myList = ManageFormContent<T>.GetListbyID("StaffWorkingRoles", ids, btnSubmit);
            }
            return myList;
        }

        protected void DDLScopeby_SelectedIndexChanged(object sender, EventArgs e)
        {
            string initialValue = "";

            if (ddlScopeby.SelectedValue == "School") initialValue = WorkingProfile.SchoolCode;

            AssiblingScopeValueDDL(initialValue);
        }
        private void AssiblingScopeValueDDL(string initialValue)
        {
            var parameters = new CommonListParameter()
            {
                Operate = "AccessScopeValue",
                UserID = WorkingProfile.UserId,
                UserRole = hfUserRole.Value,
                Para1 = ddlScopeby.SelectedValue,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = ddlApps.SelectedValue
            };
            //     AppsPage.BuildingList(ddlScopeByValue, "AccessScopeValue", parameters);
            AppsPage.BuildingList(ddlScopeByValue, ddlScopeby.SelectedValue, parameters, initialValue);
        }
    }
}