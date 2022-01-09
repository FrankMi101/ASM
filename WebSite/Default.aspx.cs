using ASMBLL;
using BLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace ASM
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                Session["myTheme"] = "Theme1";

                CheckUserRunningAppsPermission();
              
            }
        }
        private void CheckUserRunningAppsPermission()
        {
            var userAppRole = WorkingProfile.AppUserRole;
            var para = new { 
                Operate = "Permission", 
                UserID = UserProfile.LoginUserId, 
                AppID = WorkingProfile.AppID, 
                ModelID = WorkingProfile.ModelID, 
                UserRole = WorkingProfile.AppUserRole
            };
            var runingPermission = WorkingProfile.GetWorkingProfile(para)[0].Permission;
            WorkingProfile.Permission = runingPermission;

            if (runingPermission == "Deny")
            {
                 GoList.Attributes.Add("src", "~/PagesOther/AccessDeny.aspx");
            }
            else
            {   SaveUserWorkingEnvironment();
                DefaultLoad();         
            }
        }
        private void DefaultLoad()
        {
            WorkingProfile.PageCategory = "Home";
            WorkingProfile.PageArea = "General";
            WorkingProfile.PageItem = "EPA00";
            hfPageID.Value = "Default";
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserID.Value = WorkingProfile.UserId;
            hfRunningModel.Value = WebConfig.RunningModel();



            if (DBConnection.CurrentDB != "Live")
            {
                LabelTrain.Text = DBConnection.CurrentDB;
                LabelTrain.Visible = true;
            }
            try
            {
                var parameter = new CommonListParameter()
                {
                    Operate = "UserRole",
                    UserID = WorkingProfile.UserId,
                    UserRole = "",
                    Para1 = "",
                    Para2 = "",
                    Para3 = "",
                    Para4 = ""
                };

                AppsPage.BuildingList(rblLoginAS, "UserRole", parameter, WorkingProfile.UserRole);

                LoginUserRole.InnerText = WorkingProfile.UserId + " as " + rblLoginAS.SelectedItem.Text;

                hfCurrentUserRole.Value = WorkingProfile.UserRole;

                GetUserLastWorkingValue();
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
            }
            string pId = Page.Request.QueryString["pID"];

            pId = GetDefaultListbyRole();  // "Loading.aspx?pID=Summary";

            GoList.Attributes.Add("src", pId);


        }

        private string GetDefaultListbyRole()
        {
            string workingArea = "Current Working Area";
            string goPage = "HomePage.aspx";
            switch (WorkingProfile.UserRole)
            {
                case "Principal":
                    workingArea = "Board Info Center >> User Access Control Management >> Apps Access Control Summary";
                    goPage = "Pages/AccessSummary.aspx";
                    hfTopMenuArea.Value = "TopItem_2";
                    hfLevel1MenuArea.Value = "TopItem_21";
                    break;
                case "Security":
                    goPage = "SICSchool/SchoolListPage.aspx";
                    break;
                case "Admin":
                    workingArea = "Board Info Center >> User Access Control Management >> Apps Access Control Summary";
                    goPage = "Pages/AccessSummary.aspx";
                    hfTopMenuArea.Value = "TopItem_7";
                    hfLevel1MenuArea.Value = "TopItem_71";
                    break;
                default:
                    goPage = "Pages/AccessSummary.aspx";
                    break;
            }
            LabelPageTitle.Text = workingArea;

            return "Loading.aspx?pID=" + goPage;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("Account/Login.aspx");
        }


        protected void RblLoginAS_SelectedIndexChanged(object sender, EventArgs e)
        {
            WorkingProfile.UserRole = rblLoginAS.SelectedValue;
            hfCurrentUserRole.Value = WorkingProfile.UserRole;
            Page.Response.Redirect("Default.aspx");
        }
        private void GetUserLastWorkingValue()
        {

            List<LastWorkInfo> lastInfo = GetLastWorkInfo();
            var myInfo = lastInfo[0];
            LabelSchoolYear.Text = UserProfile.CurrentSchoolYear;
            LabelSchoolCode.Text = myInfo.SchoolCode; // UserLastWorking.SchoolCode;
            LabelSchool.Text = myInfo.SchoolName; //  UserLastWorking.SchoolName;
            hfSchoolArea.Value = myInfo.SchoolArea;// UserLastWorking.SchoolArea;

            hfApprYear.Value = myInfo.SchoolYear;//  WorkingProfile.SchoolYear;
            hfApprSchool.Value = myInfo.SchoolCode;//   WorkingProfile.SchoolCode;
            hfApprEmployeeID.Value = myInfo.ContentPage;
            hfTeacherName.Value = myInfo.UserName;//   WorkingProfile.UserName;

            WorkingProfile.SchoolArea = hfSchoolArea.Value;
            LabelUserIdentified.Text = HttpContext.Current.User.Identity.IsAuthenticated ? "Identified: Yes" : "No";
            LabelUserIdentified.Text += HttpContext.Current.User.Identity.AuthenticationType;
        }
        private void SaveUserWorkingEnvironment()
        {
            string screenSize = WorkingProfile.ClientUserScreen;
            string machineName = Server.MachineName;
            string browserType = HttpContext.Current.Request.Browser.Type;
            string browserVersion = HttpContext.Current.Request.Browser.Version;

            string lastValue = UserLastWorking.LastValue(User.Identity.Name, "LastValue", WorkingProfile.UserRole, machineName, screenSize, browserType, browserVersion);

        }
        private List<LastWorkInfo> GetLastWorkInfo()
        {


            var parameter = new
            {
                Operate = "GetAll",
                UserID = WorkingProfile.UserId
            };

            var myList = AppsBase.GeneralList<LastWorkInfo>("dbo.SIC_sys_UserWorkingTrack", parameter);
            return myList;
        }
    }
}