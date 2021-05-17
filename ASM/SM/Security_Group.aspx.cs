//using BLL;
//using ASM.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM
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
        private void InitialPage()
        {

            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            WorkingProfile.SchoolCode = hfSchoolCode.Value;

            AppsPage.SetListValue(ddlSchoolCode, hfSchoolCode.Value);
            AppsPage.SetListValue(ddlSchool, hfSchoolCode.Value);



        }
        private void BindViewData()
        {
            var GroupID = Page.Request.QueryString["GroupID"].ToString();
            if (GroupID != "0")
            {
                var GroupInfo = GetDataSource()[0];
                AppsPage.SetListValue(ddlApps, GroupInfo.AppID);
                AppsPage.SetListValue(ddlGroupType, GroupInfo.GroupType);
                AppsPage.SetListValue(ddlSchoolCode, GroupInfo.SchoolCode);
                AppsPage.SetListValue(ddlSchool, GroupInfo.SchoolCode);

                TextBoxGroupID.Text = GroupInfo.GroupID;
                TextBoxGroupName.Text = GroupInfo.GroupName;
                AppsPage.SetListValue(rblPermission, GroupInfo.Permission);
                dateStart.Value = GroupInfo.StartDate;
                dateEnd.Value = GroupInfo.EndDate;
                TextComments.Text = GroupInfo.Comments;
                lblIDs.Text = GroupInfo.IDs;
                chbTeachers.Checked = GroupInfo.HasMemberT;
                LabelActive.Text = GroupInfo.IsActive;
                BuildStudentMemberDDL(GroupInfo.GroupType, GroupInfo.StudentMember);
                if (hfAction.Value == "Delete")
                {
                    btnSubmit.Value = "Delete Group";
                    if (GroupInfo.StudentMember.ToString() != "" || chbTeachers.Checked)
                    {
                        btnSubmit.Disabled = true;
                    }
                }

            }
            CheckPageOpenAction();
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

        private List<Group> GetDataSource()
        { 
            var parameter = new
            {
                Operate = "Get" , //"GroupInformation",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = hfSchoolYear.Value,
                SchoolCode = hfSchoolCode.Value,
                AppID = hfAppID.Value,
                GroupID = TextBoxGroupID.Text  
            };

            var myList = ListData.GeneralList<Group>("SecurityManage", "ManageGroupContent", parameter);
            return myList;
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
            { }
        }

        protected void DdlGroupType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BuildStudentMemberDDL(ddlGroupType.SelectedValue, "");
        }
    }
}