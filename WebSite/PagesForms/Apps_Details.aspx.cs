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
    public partial class Apps_Details : System.Web.UI.Page
    {
        readonly string pageID = "GroupMembersList";
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
            hfUserID.Value = WorkingProfile.UserId;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;

            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            if (hfAction.Value == "Add") btnSubmit.Value = "Add New Apps";
        }
        private void AssemblePage()
        {
            string scope;
        }
        private void BindViewData()
        {
            CheckPageOpenAction();
            if (hfAction.Value == "View") return;

            if (hfAction.Value == "Add") btnSubmit.Value = "Add New apps";
            if (hfAction.Value == "Edit") btnSubmit.Value = "Save Change";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Delete apps";

            var IDs = hfIDs.Value.ToString();
            if (IDs != "0")
            {
                var appsInfo = GetDataSource()[0];

                TextBoxAppsID.Text = appsInfo.AppID;
                TextBoxAppsName.Text = appsInfo.AppName;
                TextBoxOwner.Text = appsInfo.Owners;
                TextBoxDeveloper.Text = appsInfo.Developer;
                TextBoxAppsUrl.Text = appsInfo.AppUrl;
                TextBoxAppsUrlTest.Text = appsInfo.AppUrlTest;
                TextBoxAppsUrlTrain.Text = appsInfo.AppUrlTrain;

                dateStart.Value = appsInfo.StartDate;
                dateEnd.Value = appsInfo.EndDate;
                TextComments.Text = appsInfo.Comments;
                lblIDs.Text = appsInfo.IDs;
            }
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
                    CheckAllControlOnPage(true);
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
                TextBoxAppsID.Enabled = mybool;
                TextBoxAppsName.Enabled = mybool;
                TextBoxOwner.Enabled = mybool;
                TextBoxDeveloper.Enabled = mybool;
                TextBoxAppsUrl.Enabled = mybool;
                TextBoxAppsUrlTest.Enabled = mybool;
                TextBoxAppsUrlTrain.Enabled = mybool;
                dateEnd.Disabled = !mybool;
                dateStart.Disabled = !mybool;

            }
            catch (Exception ex)
            {
                var ms = ex.Message;
                throw ex;
            }
        }

        private List<Apps> GetDataSource()
        {
            var parameter = new
            {
                Operate = "Get", //"GroupInformation",
                UserID = WorkingProfile.UserId,
                IDs = hfIDs.Value,
                UserRole = WorkingProfile.UserRole,

            };

            int IDs = int.Parse(hfIDs.Value);
            // var myList = ListData.GeneralList<Group>("SecurityManage", "ManageGroupContent", parameter);
            // var myList = ManageFormContent<UserGroup>.GetListbyID("UserGroup",IDs);  need MapClass support
            //  var actionClass = new ActionGet<UserGroup>(new ActionAppUserGroup());
            //  var myList = ManageFormContent<UserGroup>.GetListbyID(actionClass, IDs);
            var myList = ManageFormContent<Apps>.GetListbyID("Apps", IDs, btnSubmit);
            return myList;
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            // SaveData("GrantPermission");

        }

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