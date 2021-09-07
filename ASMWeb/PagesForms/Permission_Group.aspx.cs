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
    public partial class Permission_Group : System.Web.UI.Page
    {
        readonly string pageID = "UserGroupPermission";
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
                BindViewData();
            }
        }

        private void SetPageAttribution()
        {
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
            hfGroupID.Value = Page.Request.QueryString["xID"].ToString();
            //            TextBoxModelID.Text = Page.Request.QueryString["ModelID"].ToString();
            hfRoleType.Value = Page.Request.QueryString["xType"].ToString();
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            lblIDs.Text = Page.Request.QueryString["IDS"].ToString();

            if (hfAction.Value == "Add") btnSubmit.Value = "Add Group";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Delete Group";
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
            AppsPage.BuildingList(ddlScope, "AccessScope", parameters, "School");
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);
            parameters.Para2 = hfAppID.Value;
            AppsPage.BuildingList(ddlModelID, "AppsModel", parameters, "Pages");

        }
        protected void ddlApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = ddlApps.SelectedValue,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = "Board"
            };
            AppsPage.BuildingList(ddlModelID, "AppsModel", parameters, "Pages");
        }
        private void BindViewData()
        {
            var IDs = lblIDs.Text;
            if (IDs != "0")
            {
                var RoleInfo = GetDataSource<UserGroupPermission>()[0];
                AppsPage.SetListValue(ddlApps, RoleInfo.AppID);
                AppsPage.SetListValue(ddlScope, RoleInfo.AccessScope);

               

                TextBoxGroupName.Text = RoleInfo.GroupName;
                AppsPage.SetListValue(ddlModelID, RoleInfo.ModelID);
                AppsPage.SetListValue(rblPermission, RoleInfo.Permission);

                TextComments.Text = RoleInfo.Comments;
                lblIDs.Text = RoleInfo.IDs;

            }
            CheckPageOpenAction();
        }

        private List<T> GetDataSource<T>()
        {
            int IDs = int.Parse(lblIDs.Text);
            var myList = ManageFormContent<T>.GetListbyID("UserGroupPermission", IDs);

            return myList;
        }

        private void CheckPageOpenAction()
        {
            var action = hfAction.Value;
            CheckAllControlOnPage(false);


        }
        private void CheckAllControlOnPage(bool mybool)
        {
            try
            {
                TextBoxGroupName.Enabled = mybool;
                //TextComments.Enabled = mybool;
                //ddlModelID.Enabled = mybool;
                //rblPermission.Enabled = mybool;
                //ddlScope.Enabled = mybool;
                //ddlApps.Enabled = mybool;
            }
            catch (Exception ex)
            {
                var ms = ex.Message;
            }
        }


    }
}