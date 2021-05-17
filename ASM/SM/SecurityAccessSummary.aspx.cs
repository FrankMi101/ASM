using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM
{
    public partial class SecurityAccessSummary : System.Web.UI.Page
    {
        readonly string pageID = "SecurityGroupManage";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
 
            }
        }
        private void SetPageAttribution()
        {
            hfPageID.Value = pageID;
            hfAppID.Value = "ASM";
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();

        }
  
    }
}