
using ClassLibrary;
using System;
using System.Web.UI;

namespace ASM.PagesForms
{
    public partial class GroupMember_Student : System.Web.UI.Page
    {
        readonly string pageID = "AddGroupMemberStudents";
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
            LabelGroupType.Text = Page.Request.QueryString["groupType"].ToString();
        }
        private void AssemblePage()
        {
            BuildStudentMemberDDL(LabelGroupType.Text, "");
        }
        private void InitialPage()
        {
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
                Para2 = WorkingProfile.SchoolYear,
                Para3 = hfSchoolCode.Value,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlStudentMemberID, "StudentMember", parameters, memberID);
        }
  
   
        //private List<GroupList> GetDataSource()
        //{ 
        //    var parameter = new
        //    {
        //        Operate = "Get" , //"GroupInformation",
        //        UserID = User.Identity.Name,
        //        UserRole = Page.Request.QueryString["UserRole"].ToString(),
        //        SchoolYear = Page.Request.QueryString["SchoolYear"].ToString(),
        //        SchoolCode = Page.Request.QueryString["SchoolCode"].ToString(),
        //        AppID = Page.Request.QueryString["AppID"].ToString(),
        //        GroupID = Page.Request.QueryString["ObjID"].ToString(),
        //    };

        //    var myList = ListData.GeneralList<GroupList>("GeneralValue","ManageGroupList", parameter);
        //    return myList;
        //}

        //protected void BtnSubmit_Click(object sender, EventArgs e)
        //{
        //   // SaveData("GrantPermission");

        //}
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