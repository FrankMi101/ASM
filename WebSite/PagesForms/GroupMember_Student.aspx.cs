
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
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
                BindViewData();
            }
        }

        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
          
            hfUserID.Value  = WorkingProfile.UserId  ;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;

            hfAction.Value = Page.Request.QueryString["Action"].ToString();
            if (hfAction.Value == "Add") btnSubmit.Value = "Add to Group";
            if (hfAction.Value == "Delete") btnSubmit.Value = "Remove Group Member";

            hfIDs.Value = Page.Request.QueryString["IDs"].ToString();
            hfSchoolCode.Value = Page.Request.QueryString["SchoolCode"].ToString();
            hfAppID.Value = Page.Request.QueryString["AppID"].ToString();
            hfGroupID.Value = Page.Request.QueryString["xID"].ToString();
            LabelGroupType.Text = Page.Request.QueryString["xType"].ToString();
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
                UserID  = WorkingProfile.UserId  ,
                Para1 = GroupType,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = hfSchoolCode.Value,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlStudentMemberID, "StudentMember", parameters, memberID);
        }

        private void BindViewData()
        {
            try
            {
                if (hfIDs.Value != "0")
                {
                    var member = GetDataSource<UserGroupMemberStudent>()[0];
                    AppsPage.SetListValue(ddlStudentMemberID, member.MemberID);
                    TextComments.Text = member.Comments;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }      
        }

        private List<T> GetDataSource<T>()
        {
            List<T> myList;
            if (WebConfig.DataSource() == "API")
            {
                string uri = "UserGroupStudent/";
                string qStr = "/" + hfIDs.Value;
                myList = ManageFormContent<T>.GetListbyID("API", uri, qStr);
            }
            else
            {
                int id = int.Parse(hfIDs.Value);
                myList = ManageFormContent<T>.GetListbyID("UserGroupStudent", id);
            }
            return myList;

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