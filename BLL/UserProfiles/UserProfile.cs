using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace BLL 
{
    public  class UserProfile
    {
        public UserProfile()
        { }

        public static string Role
        {
            get
            {
                return GetProfile("Role");
            }
        }
        public static string Position
        {
            get
            {
                return GetProfile("Position");
            }
        }
        public static string LoginUserName
        {
            get
            {
                return GetProfile("LoginUserName");
            }
        }
        public static string LoginUserRole
        {
            get
            {
                return GetProfile("LoginUserRole");
            }
        }
        public static string CurrentSchoolYear
        {
            get
            {
                return GetProfile("CurrentSchoolYear");
            }
        }

        public static string LoginUserEmployeeID
        {
            get
            {
                return GetProfile("LoginUserEmployeeID");
            }
        }
  
        private static string GetProfile(string pType)
        {
            try
            {
                var parameter = new
                {
                    Operate = pType,
                    UserID = HttpContext.Current.User.Identity.Name
                };
                return CommonExecute<string>.ValueOfT("dbo.EPA_sys_LoginUserProfile @Operate, @UserID", parameter);

            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            } 
        }

     
        public static string UserLoginRole(string userId)
        {
            return CommonExecute<string>.ValueOfT("dbo.EPA_sys_LoginUserProfile @Operate, @UserID", new { Operate = "Role",UserID = userId});
        }
    }
   
}
