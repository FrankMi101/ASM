
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesForms
{
    public partial class RequestClassMatchForm : System.Web.UI.Page
    {
        readonly string pageID = "RequestPermission";
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Session["myTheme"] != null) this.Theme = Session["myTheme"].ToString();

        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
                AssiblingPage();
                BindViewData();
            }

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
            hfModelID.Value = Page.Request.QueryString["ModelID"].ToString();
            hfUserID.Value = WorkingProfile.UserId;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = Page.Request.QueryString["SchoolYear"].ToString();
            hfSchoolCode.Value = Page.Request.QueryString["SchoolCode"].ToString();
            hfUserRole.Value = WorkingProfile.UserRole; 
            hfRunningModel.Value = WebConfig.RunningModel();
             hfAction.Value = Page.Request.QueryString["Action"].ToString();

            TextUserID.Text = Page.Request.QueryString["xID"].ToString();
            TextUserName.Text = Page.Request.QueryString["xName"].ToString();
            TextUserRole.Text = Page.Request.QueryString["xType"].ToString();

 
        }
        private void AssiblingPage()
        {
           
              var parameters = new CommonListParameter()
              {
                  Operate = "",
                  UserID = WorkingProfile.UserId,
                  Para1 = WorkingProfile.UserRoleLogin,
                  Para2 = WorkingProfile.SchoolYear,
                  Para3 = WorkingProfile.SchoolCode,
                  Para4 = WorkingProfile.AppID,
               };

            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);
            parameters.Para1 = WorkingProfile.DefaultAppID;
            AppsPage.BuildingList(ddlModel, "AppsModel", parameters, hfModelID.Value);
            AppsPage.BuildingList(ddlMatchType, "ClassMatchType", parameters);
            parameters.Para1 = ddlMatchType.SelectedValue;
            AppsPage.BuildingList(ddlMatchValue, "ClassMatchValue", parameters);

            var yearDate = new Model.SchoolYearDate();
            hfSchoolyearStartDate.Value = yearDate.StartDate();
            hfSchoolyearEndDate.Value = yearDate.EndDate();

            dateStart.Value = yearDate.TodayDate();
            dateEnd.Value = yearDate.EndDate();
        }
 
        protected void ddlApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = WorkingProfile.UserId,
                Para1 = ddlApps.SelectedValue,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = ddlApps.SelectedValue,
            };

            AppsPage.BuildingList(ddlModel, "AppsModel", parameters, "Pages");

        }

        protected void ddlMatchType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuldDDLMatchValue();

        }
        private void BuldDDLMatchValue()
        {
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = WorkingProfile.UserId,
                Para1 = ddlMatchType.SelectedValue,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
            };

            AppsPage.BuildingList(ddlMatchValue, "ClassMatchValue", parameters);
        }
        protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
        }

        protected void ddlSchoolCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchool, ddlSchoolCode.SelectedValue);
        }

        private void BindViewData()
        {
            CheckPageControlOpenStatus();
 
            var IDs = hfIDs.Value.ToString();
            if (IDs != "0")
            {
                var formInfo = GetDataSource()[0];
                AppsPage.SetListValue(ddlApps, formInfo.AppID);
                AppsPage.SetListValue(ddlModel, formInfo.ModelID);
                AppsPage.SetListValue(ddlSchoolCode, formInfo.SchoolCode);
                AppsPage.SetListValue(ddlSchool, formInfo.SchoolCode);

                AppsPage.SetListValue(ddlMatchType,  formInfo.MatchType);
                BuldDDLMatchValue();
                AppsPage.SetListValue(ddlMatchValue, formInfo.MatchValue); 


                TextUserID.Text = formInfo.StaffUserID;
                TextUserName.Text = formInfo.UserName;
                TextUserRole.Text = formInfo.UserRole;
                dateStart.Value = formInfo.StartDate;
                dateEnd.Value = formInfo.EndDate;
                TextComments.Text = formInfo.Comments;
                 

            }

        }
        private List<RequestClassMatch> GetDataSource()
        {
            var parameter = new
            {
                Operate = "Get", //"formInformation",
                UserID = WorkingProfile.UserId,
                IDs = hfIDs.Value

            };

            int IDs = int.Parse(hfIDs.Value);
            var myList = ManageFormContent<RequestClassMatch>.GetListbyID("RequestPermission", IDs);
            return myList;
        }
        private void CheckPageControlOpenStatus()
        {
            if (WorkingProfile.UserRoleLogin != "Admin")
            {
                 ddlApps.Enabled = false;
                ddlModel.Enabled = false;
                ddlSchool.Enabled = false;
                ddlSchoolCode.Enabled = false;

            }
            if (hfIDs.Value.ToString() != "0")
            {
                checkButton(true);
            }
            else
            {
                checkButton(false);
            }

            
        }
        private void checkButton(bool visible)
        {
            btnGrant.Visible = visible; 
            btnRequest.Visible = !visible;
        }
        protected void btnRequest_Click(object sender, EventArgs e)
        {
            var parameter = new RequestClassMatch()
            {
                Operate = "Add", //"formInformation",
                UserID = WorkingProfile.UserId,
                IDs = hfIDs.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = ddlSchool.SelectedValue,
                AppID = ddlApps.SelectedValue,
                ModelID = ddlModel.SelectedValue,
                StaffUserID = TextUserID.Text,
                UserRole = TextUserRole.Text,
                Semester = ddlSemester.SelectedValue,
                Term = ddlTerm.SelectedValue ,
                MatchType = ddlMatchType.SelectedValue,
                MatchValue = ddlMatchValue.SelectedValue, 
                StartDate = dateStart.Value ,
                EndDate =  dateEnd.Value ,
                Comments = TextComments.Text
            };
            var result = ManageFormSave<RequestClassMatch>.SaveFormContent("Add", "RequestClassMatch", parameter);
        }

        protected void btnGrant_Click(object sender, EventArgs e)
        {

        }

        protected void btnPending_Click(object sender, EventArgs e)
        {

        }
    }
}