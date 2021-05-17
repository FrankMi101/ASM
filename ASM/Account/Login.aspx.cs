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
                if (User.Identity.Name == "")
                {
                    txtUserName.Text = "mif";
                }
                else
                { txtUserName.Text = User.Identity.Name; }
                txtUserName.Focus();
                if (DBConnection.CurrentDB != "Live")
                {
                    LabelTrain.Text = DBConnection.CurrentDB;
                    LabelTrain.Visible = true;
                }
                string authenticationMethod = WebConfig.getValuebyKey("AuthenticateMethod");
                if (authenticationMethod == "NameOnly")
                {
                    //   rfPassword.Enabled = false;
                }
            }
        }
        protected void Login_Click(object sender, EventArgs e)
        {
            try
            {
                txtUserName.Text = txtUserName.Text.ToLower();
                if (Authentication.IsAuthenticated(txtDomain.Text, txtUserName.Text, txtPassword.Text))
                {
                    CreateAuthenticationTicket();
                }
                else
                {
                    errorlabel.Text = "Error Login User ID or Passward !";
                    errorlabel.Visible = true;
                    txtPassword.Focus();
                }
            }
            catch (Exception ex)
            {
                string exM = ex.Message;

            }

        }

        private void CreateAuthenticationTicket()
        {
            try
            {
                string loginRole = UserProfile.UserLoginRole(txtUserName.Text);//  Authentication.UserRole(txtUserName.Text);
                if (loginRole == "Other")
                {
                    errorlabel.Text = WebConfig.MessageNotAllow(); // "You are not allow to run this application ! ";
                    errorlabel.Visible = true;
                    txtUserName.Focus();
                }
                else
                {
                    CreateauTicket(loginRole);
                }
            }
            catch (Exception ex)
            {
                string exm = ex.Message;
            }

        }
        private void CreateauTicket(string loginRole)
        {
            try
            {
                WorkingProfile.UserRole = loginRole;
                WorkingProfile.UserRoleLogin = loginRole;
                WorkingProfile.ClientUserScreen = txtResolution.Value;

                Boolean iscookiepersistent = chkPersist.Checked;
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(1, txtUserName.Text.ToLower(), DateTime.Now, DateTime.Now.AddMinutes(60), iscookiepersistent, "");
                string encryptedTitcket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTitcket);
                if (iscookiepersistent)
                {
                    authCookie.Expires = authTicket.Expiration;
                }
                Response.Cookies.Add(authCookie);
                System.Security.Principal.GenericIdentity id = new System.Security.Principal.GenericIdentity(authTicket.Name, "LdapAuthentication");
                System.Security.Principal.GenericPrincipal principal = new System.Security.Principal.GenericPrincipal(id, null);
                FormsAuthentication.RedirectFromLoginPage(txtUserName.Text.ToLower(), chkPersist.Checked);
            }
            catch (Exception ex)
            {
                string exm = ex.Message;
            }


        }
    }
}