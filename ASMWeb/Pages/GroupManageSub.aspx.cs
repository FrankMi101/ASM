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
            WorkingProfile.SchoolCode = Page.Request.QueryString["sCode"].ToString();
            hfSchoolCode.Value = WorkingProfile.SchoolCode;

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfSchoolCode.Value = WorkingProfile.SchoolCode;
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
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

        private List<T> GetDataSource<T,T2>(string gType)
        {
            var parameter = new
            {
                Operate = gType, // "GroupListStudent",//"SecurityGroupListStudents",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                AppID = Page.Request.QueryString["appID"].ToString(),
                GroupID = Page.Request.QueryString["xID"].ToString()
            };

            //  var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);
            // var gList = PageListManage<T, UserGroupMember>.GetList(gType, parameter);
            // return gList;

            return ManagePageList<T, T2>.GetList("SQL", "ClassCall", parameter);


            //if (gType == "GroupListStudent")
            //{
            //    // var actionClass = new ActionGet<UserGroupMemberStudent>(new ActionAppUserGroupMemberS());
            //    // return ManagePageList<T, UserGroupMemberStudent>.GetList(actionClass, parameter);
            //    return ManagePageList<T, T2>.GetList("SQL", "ClassCall", parameter);
            //}

            //if (gType == "GroupListTeacher")
            //{
            //    //  var actionClass = new ActionGet<UserGroupMemberTeacher>(new ActionAppUserGroupMemberT());
            //    //   return ManagePageList<T, UserGroupMemberTeacher>.GetList(actionClass, parameter);
            //    return ManagePageList<T, T2>.GetList("SQL", "ClassCall", parameter);
            //}

            //return null;
        }


        //private List<T> GetDataSource_StudentGroupList<T>()
        //{
        //    var parameter = new
        //    {
        //        Operate = "GroupListStudent",//"SecurityGroupListStudents",
        //        UserID = User.Identity.Name,
        //        UserRole = hfUserRole.Value,
        //        SchoolCode = Page.Request.QueryString["sCode"].ToString(),
        //        AppID = Page.Request.QueryString["appID"].ToString(),
        //        GroupID = Page.Request.QueryString["gID"].ToString()
        //    };

        //    //  var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);

        //    var gList = PageListManage<T, UserGroupMember>.GetList("GroupListStudent", parameter);
        //    return gList;
        //}
        //private List<T> GetDataSource_TeacherGroupList<T>()
        //{
        //    var parameter = new
        //    {
        //        Operate = "GroupListTeacher",//"SecurityGroupListTeachers",
        //        UserID = User.Identity.Name,
        //        UserRole = hfUserRole.Value,
        //        SchoolCode = Page.Request.QueryString["sCode"].ToString(),
        //        AppID = Page.Request.QueryString["appID"].ToString(),
        //        GroupID = Page.Request.QueryString["gID"].ToString()
        //    };
        //    var gList = PageListManage<T, UserGroupMember>.GetList("GroupListTeacher", parameter);
        //    return gList;
        //    //   var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);
        //    //   return myList;
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