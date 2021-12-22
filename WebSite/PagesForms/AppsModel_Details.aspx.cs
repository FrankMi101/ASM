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
    public partial class AppsModel_Details : System.Web.UI.Page
    {
        readonly string pageID = "GroupMembersList";
        protected void Page_Error(object sender, EventArgs e)
        {
            //Exception Ex = Server.GetLastError();
            //Server.ClearError();
            //Response.Redirect("../Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
        }
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
            TextBoxAppID.Text = Page.Request.QueryString["AppID"].ToString();
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            if (hfAction.Value == "Add") btnSubmit.Value = "Add New Apps";
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
                var modelInfo = GetDataSource()[0];

                lblIDs.Text = modelInfo.IDs;
                TextBoxAppID.Text = modelInfo.AppID;
                TextBoxModelID.Text = modelInfo.ModelID;
                TextBoxModelName.Text = modelInfo.ModelName;
                TextBoxOwner.Text = modelInfo.Owners;
                TextBoxDeveloper.Text = modelInfo.Developer;


                dateStart.Value = modelInfo.StartDate;
                dateEnd.Value = modelInfo.EndDate;
                TextComments.Text = modelInfo.Comments;
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
                TextBoxModelID.Enabled = mybool;
                TextBoxModelName.Enabled = mybool;
                TextBoxOwner.Enabled = mybool;
                TextBoxDeveloper.Enabled = mybool;
                dateEnd.Disabled = !mybool;
                dateStart.Disabled = !mybool;

            }
            catch (Exception ex)
            {
                var ms = ex.Message;
                throw ex;
            }
        }

        private List<AppsModel> GetDataSource()
        {
            var parameter = new
            {
                Operate = "Get", //"GroupInformation",
                UserID = WorkingProfile.UserId,
                IDs = hfIDs.Value,
                UserRole = WorkingProfile.UserRole,

            };

            int IDs = int.Parse(hfIDs.Value);
            var myList = ManageFormContent<AppsModel>.GetListbyID("AppsModel", IDs, btnSubmit);
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