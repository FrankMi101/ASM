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
    public partial class Security_Group : System.Web.UI.Page
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
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = Page.Request.QueryString["SchoolYear"].ToString();
            hfSchoolCode.Value = Page.Request.QueryString["SchoolCode"].ToString();
            hfUserRole.Value = Page.Request.QueryString["UserRole"].ToString();
            TextBoxGroupID.Text = Page.Request.QueryString["GroupID"].ToString();
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            if (hfAction.Value == "Add") btnSubmit.Value = "Add Group";
              
               
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
            AppsPage.BuildingList(ddlGroupType, "GroupType", parameters,"School");
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, hfSchoolCode.Value);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, hfAppID.Value);
            AppsPage.BuildingList(ddlAppsTo, "AppsName", parameters);
            ddlGroupType.SelectedIndex = 0;
            BuildStudentMemberDDL(ddlGroupType.SelectedValue, "");

        }
        private void BindViewData()
        {
            CheckPageOpenAction();
            if (hfAction.Value == "View") return;

            var IDs = hfIDs.Value.ToString();
            if (IDs != "0")
            {
                var GroupInfo = GetDataSource()[0];
                AppsPage.SetListValue(ddlApps, GroupInfo.AppID);
                AppsPage.SetListValue(ddlGroupType, GroupInfo.GroupType);
                AppsPage.SetListValue(ddlSchoolCode, GroupInfo.SchoolCode);
                AppsPage.SetListValue(ddlSchool, GroupInfo.SchoolCode);

                TextBoxGroupID.Text = GroupInfo.GroupID;
                TextBoxGroupName.Text = GroupInfo.GroupName;
                AppsPage.SetListValue(rblPermission, GroupInfo.Permission);
              //  dateStart.Value = GroupInfo.StartDate;
              //  dateEnd.Value = GroupInfo.EndDate;
                TextComments.Text = GroupInfo.Comments;
                lblIDs.Text = GroupInfo.IDs;
                chbTeachers.Checked = GroupInfo.HasMemberT=="Yes" ? true: false;
                LabelActive.Text = GroupInfo.IsActive;
                BuildStudentMemberDDL(GroupInfo.GroupType, GroupInfo.MemberID);
                if (hfAction.Value == "Add") btnSubmit.Value = "Add New Group";
                if (hfAction.Value == "Edit") btnSubmit.Value = "Save Change";
                if (hfAction.Value == "Delete") btnSubmit.Value = "Delete Group"; 

                if (hfAction.Value == "Delete")
                {                  
                    if (GroupInfo.MemberID.ToString() != "" || chbTeachers.Checked)
                    {
                        btnSubmit.Disabled = true;
                    }
                }

            }
       
        }
        private void BuildStudentMemberDDL(string GroupType, string memberID)
        {
            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "StudentMember",
                UserID = User.Identity.Name,
                Para1 = GroupType,
                Para2 = hfSchoolYear.Value,
                Para3 = ddlSchool.SelectedValue,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlStudentMemberID, "StudentMember", parameters, memberID);
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
                    TextBoxGroupName.Enabled = true;
                    rblPermission.Enabled = true;
                    dateEnd.Disabled = false;
                    dateStart.Disabled = false;
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
                TextBoxGroupID.Enabled = mybool;
                TextBoxGroupName.Enabled = mybool;
                rblPermission.Enabled = mybool;
                dateEnd.Disabled = !mybool;
                dateStart.Disabled = !mybool;
                ddlGroupType.Enabled = mybool;
                ddlSchool.Enabled = mybool;
                ddlSchoolCode.Enabled = mybool;
                ddlApps.Enabled = mybool;
                ddlStudentMemberID.Enabled = mybool;
               
                //foreach (Control pControl in Page.Controls)
                //{
                //    var cType = pControl.GetType();
                //    if (pControl is TextBox)
                //  }

            }
            catch (Exception ex)
            {
                var ms = ex.Message;
            }
        }

        private List<UserGroup> GetDataSource()
        { 
            var parameter = new
            {
                Operate = "Get" , //"GroupInformation",
                UserID = User.Identity.Name,
                IDs = hfIDs.Value
 
            };

            int IDs = int.Parse(hfIDs.Value);   
           // var myList = ListData.GeneralList<Group>("SecurityManage", "ManageGroupContent", parameter);
           // var myList = ManageFormContent<UserGroup>.GetListbyID("UserGroup",IDs);  need MapClass support
          //  var actionClass = new ActionGet<UserGroup>(new ActionAppUserGroup());
          //  var myList = ManageFormContent<UserGroup>.GetListbyID(actionClass, IDs);
            var myList = ManageFormContent<UserGroup>.GetListbyID("UserGroup", IDs);
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

        protected void DdlGroupType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuildStudentMemberDDL(ddlGroupType.SelectedValue, "");
        }
    }
}