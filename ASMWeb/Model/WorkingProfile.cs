using System.Web;
using System.Web.Security;
using System.Web.UI;
/// <summary>
/// Summary description for WorkingProfile
/// </summary>
/// 
using BLL;
namespace ASM
{
    public class WorkingProfile : System.Web.UI.Page
    {
        public WorkingProfile()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static string ApplicationID
        {
            get
            {
                return HttpContext.Current.Session["applicationID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["applicationID"] = value;
            }
        }
        public static string UserId
        { get
           
            {
                return HttpContext.Current.User.Identity.Name;
            }
  
        }
        public static string UserEmployeeId
        {
            get

            {
                return UserProfile.LoginUserEmployeeID;
            }

        }
        public static string UserName
        {
            get

            {
                return UserProfile.LoginUserName;
            }

        }

       
        public static string UserRole
        {
            get
            {
                if (HttpContext.Current.Session["userrole"] == null)
                {
                    HttpContext.Current.Session["userrole"] = UserProfile.Role; ;
                }
                return HttpContext.Current.Session["userrole"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userrole"] = value;
            }
        }
        public static string UserRoleLogin
        {
            get
            {
                if (HttpContext.Current.Session["userrolelogin"] == null)
                {
                    HttpContext.Current.Session["userrolelogin"] = UserProfile.Role;
                }
                return HttpContext.Current.Session["userrolelogin"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userrolelogin"] = value;
            }
        }
       public static string UserAppraisalRole
        {
            get
            {
                if (HttpContext.Current.Session["userappraisalrole"] == null)
                {
                    HttpContext.Current.Session["userappraisalrole"] = UserProfile.Role;
                }
                return HttpContext.Current.Session["userappraisalrole"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userappraisalrole"] = value;
            }
        }
        public static string ClientUserScreen
        {
            get
            {
                if (HttpContext.Current.Session["clientuserscreen"] == null)
                {
                    HttpContext.Current.Session["clientuserscreen"] = UserLastWorking.ClientScreen;
                }

                return HttpContext.Current.Session["clientuserscreen"].ToString();
            }
            set
            {
                HttpContext.Current.Session["clientuserscreen"] = value;

            }
        }
         public static string ImageFileId 
        {
            get 
            {
                 return HttpContext.Current.Session["imagefileID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["imagefileID"] = value;
             }
        }
         public static string Model 
        {
            get 
            {
                 return WebConfig.getValuebyKey("ApplicationModel");
            }
  
        }
        public static string PageCategory
        {
            get
            {

                return HttpContext.Current.Session["pagecategoryID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["pagecategoryID"] = value;
            }
        }
        public static string PageArea
        {
            get
            {

                return HttpContext.Current.Session["pageareaID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["pageareaID"] = value;
            }
        }
        public static string PageItem
        {
            get
            {
                return HttpContext.Current.Session["pageItemID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["pageItemID"] = value;
            }
        }
        public static string SchoolYear
        {
            get
            {
                if (HttpContext.Current.Session["schoolyear"] == null)
                {
                    HttpContext.Current.Session["schoolyear"] = UserLastWorking.SchoolYear;
                }
                return HttpContext.Current.Session["schoolyear"].ToString();
            }
            set
            {
                HttpContext.Current.Session["schoolyear"] = value;
            }
        }
       public static string SchoolCode
        {
            get
            {
                if (HttpContext.Current.Session["schoolcode"] == null)
                {
                    HttpContext.Current.Session["schoolcode"] = UserLastWorking.SchoolCode;
                }
                return HttpContext.Current.Session["schoolcode"].ToString();
            }
            set
            {
                HttpContext.Current.Session["schoolcode"] = value;
            }
        }
        public static string SchoolArea
        {
            get
            {
                if (HttpContext.Current.Session["schoolarea"] == null)
                {
                    HttpContext.Current.Session["schoolarea"] = UserLastWorking.SchoolArea;
                }
                return HttpContext.Current.Session["schoolarea"].ToString();
            }
            set
            {
                HttpContext.Current.Session["schoolarea"] = value;
            }
        }
        public static string OpenSchoolYear
        {
            get
            {
                if (HttpContext.Current.Session["openschoolyear"] == null)
                {
                    HttpContext.Current.Session["openschoolyear"] = UserLastWorking.OpenSchoolYear;
                }
                return HttpContext.Current.Session["openschoolyear"].ToString();
            }
            set
            {
                HttpContext.Current.Session["openschoolyear"] = value;
            }
        }

    }
}