//using BLL;
//using SIC.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesForms
{
    public partial class GroupMember_Teacher : System.Web.UI.Page
    {
        readonly string pageID = "AddGroupMemberTeacher";
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

            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            if (hfAction.Value == "Add") btnSubmit.Value = "Add to Group";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Remove Group Member";

            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();
            hfSchoolCode.Value = Page.Request.QueryString["sCode"].ToString();
            hfAppID.Value = Page.Request.QueryString["appID"].ToString();
            hfGroupID.Value = Page.Request.QueryString["groupID"].ToString(); 


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
                Para2 = hfSchoolYear.Value,
                Para3 = hfSchoolCode.Value,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlStaff, "SchoolStaff", parameters );
         
        }
        private void InitialPage()
        {
            //AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            //WorkingProfile.SchoolCode = ddlSchool.SelectedValue;

            //AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            //AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);
        }
        private void BindViewData()
        {
           
        }
     

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           // SaveData("GrantPermission");

        }
        //private void SaveData(string action)
        //{
        //    var parameter = new
        //    {
        //        Operate = action,
        //        UserID = User.Identity.Name,
        //        UserRole = hfUserRole.Value
        //        SchoolCode = ddlSchoolCode.SelectedValue,
        //        CPNum = "",
        //        AppID = ddlApps.SelectedValue,
        //        GroupID = TextBoxGroupID.Text,
        //        GroupName = TextBoxGroupName.Text,
        //        Permission = rblPermission.SelectedValue,
        //        StartDate = dateStart.Value,
        //        EndDate = dateEnd.Value,
        //        Comments = TextComments.Text
        //    };


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