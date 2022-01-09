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
    public partial class Security_RoleP : System.Web.UI.Page
    {
        readonly string pageID = "UserRolePermission";
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
            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
           // TextBoxRoleID.Text = Page.Request.QueryString["xID"].ToString();
            TextBoxModelID.Text = Page.Request.QueryString["ModelID"].ToString();
            hfRoleType.Value = Page.Request.QueryString["xType"].ToString();
            hfUserID.Value  = WorkingProfile.UserId  ;
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
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlScope, "AccessScope", parameters,"School");
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);
            AppsPage.BuildingList(ddlRoleID, "AppRole", parameters );

        }

        private void BindViewData()
        {
            var IDs = Page.Request.QueryString["IDs"].ToString();
            if (IDs != "0")
            {
                var RoleInfo = GetDataSource<AppRolePermission>()[0];
                AppsPage.SetListValue(ddlApps, RoleInfo.AppID);
                AppsPage.SetListValue(ddlScope, RoleInfo.AccessScope);
                AppsPage.SetListValue(ddlRoleID,   RoleInfo.RoleID);               
                TextBoxRoleName.Text = RoleInfo.RoleName;
                TextBoxModelID.Text = RoleInfo.ModelID;
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
                case "EditPermission":
                    TextComments.Enabled = true;
                    TextBoxRoleName.Enabled = true;
                    TextBoxModelID.Enabled = true;
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
                ddlRoleID.Enabled = mybool;
                TextBoxRoleName.Enabled = mybool;
                TextBoxModelID.Enabled = mybool;
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
            var para = new
            {
                Operate = "Get",
                UserID = "",
                IDs = hfIDs.Value
            };
        
            int ids = int.Parse(hfIDs.Value);
            var  myList = ManageFormContent<T>.GetListbyID("AppRolePermission", ids);

         //   var myList = ManagePageList<T, AppRolePermission>.GetList("SQL", "ClassCall", parameter);
         //   var myList = ManagePageList<T, AppRole>.GetList("SQL", "ClassCall", para);
           // var myList = ListData.GeneralList<AppRoleList>("SecurityManage", pageID, parameter);
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
            {
                string em = ex.StackTrace;
            }
        }

       
    }
}