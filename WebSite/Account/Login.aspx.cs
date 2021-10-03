using ASMBLL;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                txtDomain.Text = WebConfig.DomainName();
                LabelAppName.Text = WebConfig.AppName();
                HostName.InnerText = System.Net.Dns.GetHostName();

                var iName = @"CEC\userid";// WorkingProfile.UserId; // @"CEC\mif";
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                    iName = HttpContext.Current.User.Identity.Name;
                txtDomain.Text = Authentication.GetDomain(iName);
                txtUserName.Text = Authentication.GetUserName(iName);


                txtUserName.Focus();
                if (DBConnection.CurrentDB != "Live")
                {
                    LabelTrain.Text = DBConnection.CurrentDB;
                    LabelTrain.Visible = true;
                }
 
                if (Authentication.AuthenticateMethod() == "NameOnly")
                {
                    rfPassword.Enabled = false;
                }
            }
        }
        protected void Login_Click(object sender, EventArgs e)
        {
            string auth = "true";
            try
            {
                if (Authentication.AuthenticateMethod() != "NameOnly")
                {
                    auth = Authentication.AuthenticateResult(txtDomain.Text, txtUserName.Text, txtPassword.Text);
                }
            }
            catch (Exception ex)
            {
                auth = ex.Message;
            }

            CheckAppRole(auth);
        }
        private void CheckAppRole(string authResult)
        {
            errorlabel.Visible = true;
            errorlabel.ForeColor = System.Drawing.Color.Red;
            if (authResult == "true")
            {
                try
                {
                    string loginRole = UserProfile.UserLoginRole(txtUserName.Text);//  Authentication.UserRole(txtUserName.Text);
                    if (loginRole == "SAP Profile")
                    {
                        errorlabel.Text = WebConfig.getValuebyKey("NotAuthorize");
                    }
                    else if (loginRole == "Other" || loginRole == "OtherDB")
                    {
                        errorlabel.Text = WebConfig.getValuebyKey("SorryNoP");
                    }
                    else
                    {
                        CreateAuthenticationTicket(loginRole);
                    }
                }
                catch (Exception ex)
                {
                    errorlabel.Text = "Database Operation Failed - " + ex.Message;
                }
            }
            else
            {
                errorlabel.Text = authResult;
                txtPassword.Focus();
            }
        }
        private void CreateAuthenticationTicket(string loginRole)
        {
            try
            {
                errorlabel.Visible = false;
                WorkingProfile.UserRole = loginRole;
                WorkingProfile.UserRoleLogin = loginRole;

                WorkingProfile.ClientUserScreen = txtResolution.Value;

                Boolean iscookiepersistent = chkPersist.Checked;
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, txtUserName.Text.ToLower(), DateTime.Now, DateTime.Now.AddMinutes(60), iscookiepersistent, "");
             
                string encryptedTitcket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTitcket);

                if (iscookiepersistent) authCookie.Expires = authTicket.Expiration;
               
                Response.Cookies.Add(authCookie);

                System.Security.Principal.GenericIdentity id = new System.Security.Principal.GenericIdentity(authTicket.Name, "LdapAuthentication");
                System.Security.Principal.GenericPrincipal principal = new System.Security.Principal.GenericPrincipal(id, null);

                FormsAuthentication.RedirectFromLoginPage(txtUserName.Text.ToLower(), chkPersist.Checked);

 

            }
            catch (Exception ex)
            {
                string exm = ex.Message;
                errorlabel.Text = "Application Running in Error at this moment. try again late! ";
                errorlabel.Visible = true;
                txtPassword.Focus();
            }

        }
    }
}