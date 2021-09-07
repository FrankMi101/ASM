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
    public partial class Security_Role : System.Web.UI.Page
    {
        readonly string pageID = "UserRoleManagement";
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
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
            TextBoxRoleID.Text = Page.Request.QueryString["xID"].ToString();
            hfRoleType.Value = Page.Request.QueryString["xType"].ToString();
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
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
            AppsPage.BuildingList(ddlScope, "AccessScope", parameters,"School");
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);

        }
  
        private void BindViewData()
        {
            var RoleID = Page.Request.QueryString["xID"].ToString();
            if (RoleID != "0")
            {
                var RoleInfo = GetDataSource<AppRoleList>()[0];
                AppsPage.SetListValue(ddlApps, RoleInfo.AppID);
                AppsPage.SetListValue(ddlScope, RoleInfo.AccessScope); 

                TextBoxRoleID.Text = RoleInfo.RoleID;
                TextBoxRoleName.Text = RoleInfo.RoleName;
                TextBoxRolePriority.Text = RoleInfo.RolePriority;
                AppsPage.SetListValue(rblPermission, RoleInfo.Permission);
               
                TextComments.Text = RoleInfo.Comments;
                lblIDs.Text = RoleInfo.IDs;

            }
            CheckPageOpenAction();
        }
       
        private void CheckPageOpenAction()
        {
            var action = hfAction.Value;
            CheckAllControlOnPage(false);
            switch (action)
            {
                case "View":
                    btnSubmit.Visible = false;
                    break;
                case "Edit":
                    TextComments.Enabled = true;
                    TextBoxRoleName.Enabled = true;
                    TextBoxRolePriority.Enabled = true;
                    rblPermission.Enabled = true;
                    ddlScope.Enabled = true;
                     break;
                case "Add":
                    CheckAllControlOnPage(true);
                    break;
                default:
                    break;

            }

        }
        private void CheckAllControlOnPage(bool mybool)
        {
            try
            {
                TextComments.Enabled = mybool;
                TextBoxRoleID.Enabled = mybool;
                TextBoxRoleName.Enabled = mybool;
                TextBoxRolePriority.Enabled = mybool;
                rblPermission.Enabled = mybool; 
                ddlScope.Enabled = mybool; 
                ddlApps.Enabled = mybool; 
            }
            catch (Exception ex)
            {
                var ms = ex.Message;
            }
        }

        private List<T> GetDataSource<T>()
        { 
            var parameter = new
            {
                Operate = "GetListbyRoleID", //"RoleInformation",
                UserID = User.Identity.Name,
                IDs ="0",
                UserRole =  hfUserRole.Value,
                RoleType = hfRoleType.Value,
                RoleID = TextBoxRoleID.Text,
                AppID = hfAppID.Value
           };

           // var myList = ListData.GeneralList<AppRoleList>("SecurityManage", pageID, parameter);
            var myList = ManagePageList<T, AppRole>.GetList("SQL", "ClassCall", parameter);
            return myList;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           // SaveData("GrantPermission");

        }
        

        //}
        private void CreateClientMessage(string result, string action)
        {
            try
            {
                string strScript = "ShowSaveMessage('" + action + "','" + result + "');";

                Page.ClientScript.RegisterStartupScript(GetType(), "actionMessage", strScript, true);

            }
            catch (Exception ex)
            { string em = ex.StackTrace; }
        }

       
    }
}