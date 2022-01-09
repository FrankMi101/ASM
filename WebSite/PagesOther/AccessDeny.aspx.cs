using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.PagesOther
{
    public partial class AccessDeny : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelUserRole.Text = WorkingProfile.AppUserRole;
            LabelUserID.Text = UserProfile.LoginUserId;
            LabeluserName.Text = UserProfile.LoginUserName;

            var action = "Add";
            var ids = "0";
            var schoolYear = WorkingProfile.SchoolYear;
            var schoolCode = WorkingProfile.SchoolCode;
            var appID = WorkingProfile.AppID;
            var modelID = "Pages";
            var xID = UserProfile.LoginUserId;
            var xName = UserProfile.LoginUserName;
            var xType = WorkingProfile.UserRole;
            var type = "Request";

            var para = new { Operate = "Permission", UserID = UserProfile.LoginUserId, AppID = appID, ModelID = modelID, UserRole = WorkingProfile.AppUserRole };
             LabelGetPermission.Text = GetWorkingProfile(para)[0].Permission;

            //string pID = "../PagesForms/RequestAccessPermission.aspx";
            //string arg = "Action=" + action + "&IDs=" + ids + "&SchoolYear=" + schoolYear + "&SchoolCode=" + schoolCode + "&AppID=" + appID + "&ModelID=" + modelID + "&xID=" + xID + "&xName=" + xName + "&xType=" + xType;
            // string arg3 = $"javascript:OpenFeedBackForm('{action}','{type}','{ids}','{schoolYear}','{schoolCode}','{appID}','{modelID}','{xID}','{xName}','{xType}')";

            string arg = $"'{action}','{type}','{ids}','{schoolYear}','{schoolCode}','{appID}','{modelID}','{xID}','{xName}','{xType}')";
 
            RequestLink.HRef = "javascript:OpenForm('Permission'," + arg;
            RequestClassMatchLink.HRef = "javascript:OpenForm('ClassMatch'," + arg;
            FeedbackLinK.HRef = "javascript:OpenForm('Feedback'," + arg;
        }
        private static List<AppWorkingProfile> GetWorkingProfile(object parameter)
        {
            try
            {
                List<AppWorkingProfile> myList;

                if (WebConfig.DataSource() == "API")
                {
                    string uri = "WorkingProfile/list";
                    string qStr = ""; // "/" + UserID + "/" + AppID + "/" + ModelID;
                    myList = ManagePageList<AppWorkingProfile, AppWorkingProfile>.GetList("API", uri, qStr);
                }
                else
                {
                    myList = ManagePageList<AppWorkingProfile, AppWorkingProfile>.GetList("SQL", "ClassCall", parameter);
                }
                return myList;

            }
            catch (System.Exception ex)
            {
                var em = ex.Message;
                return null;
            }
        }
    }
}