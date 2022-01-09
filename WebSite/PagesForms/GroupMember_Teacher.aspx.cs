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
                Para2 = hfSchoolYear.Value,
                Para3 = hfSchoolCode.Value,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlStaff, "SchoolStaff", parameters);

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
            try
            {
                if (hfIDs.Value != "0")
                {
                    var member = GetDataSource<UserGroupMemberTeacher>()[0];
                    AppsPage.SetListValue(ddlStaff, member.MemberID);
                    dateStart.Value = member.StartDate;
                    dateEnd.Value = member.EndDate;
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
                string uri = "UserGroupTeacher/";
                string qStr = "/" + hfIDs.Value;
                myList = ManageFormContent<T>.GetListbyID("API", uri, qStr);
            }
            else
            {
                int id = int.Parse(hfIDs.Value);
                myList = ManageFormContent<T>.GetListbyID("UserGroupTeacher", id, btnSubmit);
            }
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
        //        UserID  = WorkingProfile.UserId  ,
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