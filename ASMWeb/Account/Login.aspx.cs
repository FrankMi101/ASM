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

                var iName = User.Identity.Name; // @"CEC\mif"; 
                txtDomain.Text = Authentication.GetDomain(iName);  
                txtUserName.Text = Authentication.GetUserName(iName);  
             

                txtUserName.Focus();
                if (DBConnection.CurrentDB != "Live")
                {
                    LabelTrain.Text = DBConnection.CurrentDB;
                    LabelTrain.Visible = true;
                }
                string authenticationMethod = Authentication.AuthenticateMethod();
                if (authenticationMethod == "NameOnly")
                {
                     rfPassword.Enabled = false;
                }
            }
        }
        protected void Login_Click(object sender, EventArgs e)
        {
            try
            {
                txtUserName.Text = txtUserName.Text.ToLower();
                if (RunningAppPermissionBasedOnUserRole() == "Deny")
                {
                    errorlabel.Text = WebConfig.MessageNotAllow(); // "You are not allow to run this application ! ";
                    errorlabel.Visible = true;
                    txtUserName.Focus();
                }
                else
                {
                    if ( Authentication.AuthenticateMethod(txtUserName.Text)   == "NameOnly")
                    {
                        CreateAuthenticationTicket();
                    }
                    else
                    {
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
                }
            }
            catch (Exception ex)
            {
                string exM = ex.Message;

            }

        }
        private string AppAuthenticationMethod()
        {
            string authenticationMethod = WebConfig.getValuebyKey("AuthenticateMethod");
            if (authenticationMethod == "NameOnly")
            {
                string appServer = WebConfig.getValuebyKey("AppServers");
                string hostServer = System.Net.Dns.GetHostName();
                if (appServer.Contains(hostServer)) authenticationMethod = "NameOnlyFalse";
            }
            return authenticationMethod;
        }
        private string RunningAppPermissionBasedOnUserRole()
        {
            try
            {
                string loginRole = UserProfile.UserLoginRole(txtUserName.Text);//  Authentication.UserRole(txtUserName.Text);
                if (loginRole == "Other" || loginRole == "OtherDB") return "Deny";
                WorkingProfile.UserRole = loginRole;
                WorkingProfile.UserRoleLogin = loginRole;
                return "Allow";
            }
            catch (Exception ex)
            {
                string exm = ex.Message;
                return "Deny";
            }
        }
        private void CreateAuthenticationTicket()
        {
            try
            {
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
                errorlabel.Text = "Application Running in Error at this moment. try again late! ";
                errorlabel.Visible = true;
                txtPassword.Focus();
            }

        }
    }
}