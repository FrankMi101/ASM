//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class GroupManageSub : System.Web.UI.Page
    {
        readonly string pageID = "SecurityGroupManageSub";
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
                GetQueryInfo();
                SetPageAttribution();
                AssemblePage();
                BindGridViewListData();
            }
        }
        private void GetQueryInfo()
        {
            hfAppID.Value = Page.Request.QueryString["appID"].ToString();
            TextBoxGroupID.Text = Page.Request.QueryString["xID"].ToString();
            TextBoxGroupType.Text = Page.Request.QueryString["xType"].ToString();
            hfSchoolCode.Value = Page.Request.QueryString["SchoolCode"].ToString();

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfUserID.Value = WorkingProfile.UserId;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
        }
        private void AssemblePage()
        {
        }
        private void InitialPage()
        {
        }
        private void BindGridViewListData()
        {
            try
            {
                GridView_Students_Group.DataSource = GetDataSource<GroupList, UserGroupMemberStudent>("GroupListStudent");
                GridView_Students_Group.DataBind();

                GridView_Teachers_Group.DataSource = GetDataSource<GroupList, UserGroupMemberTeacher>("GroupListTeacher");
                GridView_Teachers_Group.DataBind();

                GridView_Permission.DataSource = GetDataSource<UserGroupPermissionList, UserGroupPermission>("GetListbyGroup");
                GridView_Permission.DataBind();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private List<T> GetDataSource<T, T2>(string listType)
        {
            var parameter = new
            {
                Operate = listType, // "GroupListStudent",//"SecurityGroupListStudents",
                UserID = WorkingProfile.UserId,
                UserRole = hfUserRole.Value,
                SchoolCode = hfSchoolCode.Value,
                AppID = hfAppID.Value,
                GroupID = TextBoxGroupID.Text
            };

            return ManagePageList<T, T2>.GetList("SQL", "ClassCall", parameter, ImageUGP);

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