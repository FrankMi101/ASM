using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using ASMBLL;
/// <summary>
/// Summary description for WorkingProfile
/// </summary>
/// 
using BLL;
using ClassLibrary;

namespace ASM
{
    public class WorkingProfile :Page
    {
        public WorkingProfile()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public static string DefaultAppID
        {
            get
            {
                return  WebConfig.getValuebyKey("DefaultAppID");
            }
        }
        public static string DefaultModelID
        {
            get
            {
                return WebConfig.getValuebyKey("DefaultPage");
            }
        }
        public static string AppID
        {        
            get
            {
                if (HttpContext.Current.Session["applicaionID"] == null)
                {
                    HttpContext.Current.Session["applicaionID"] = WebConfig.getValuebyKey("Application");
                }
                return HttpContext.Current.Session["applicaionID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["applicaionID"] = value;
            }

        }
        public static string ModelID
        {
   
            get
            {
                if (HttpContext.Current.Session["applicaionModelID"] == null)
                {
                    HttpContext.Current.Session["applicaionModelID"] = WebConfig.getValuebyKey("DefaultPage");
                }
                return HttpContext.Current.Session["applicaionModelID"].ToString();
            }
            set
            {
                HttpContext.Current.Session["applicaionModelID"] = value;
            }


        }
        public static string UserId
        {
            get
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
                    HttpContext.Current.Session["userrole"] = UserProfile.Role; 
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
        public static string AppUserRole
        {
            get
            {
                if (HttpContext.Current.Session["userapprole"] == null)
                {
                    var para = new { Operate = "AppRole", UserID = UserId, AppID};
                    HttpContext.Current.Session["userapprole"] = GetWorkingProfile(para)[0].UserRole;
                }
                return HttpContext.Current.Session["userapprole"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userapprole"] = value;
            }
        }
        public static string Permission
        {
            get
            {
                if (HttpContext.Current.Session["userappPermission"] == null)
                {
                    var para = new { Operate = "Permission", UserID = UserId, AppID, ModelID, UserRole = AppUserRole};
                    HttpContext.Current.Session["userappPermission"] = GetWorkingProfile(para)[0].Permission;
                }
                return HttpContext.Current.Session["userappPermission"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userappPermission"] = value;
            }
        }
        public static string AccessScope
        {
            get
            {
                if (HttpContext.Current.Session["userappAccessScope"] == null)
                {
                    var para = new { Operate = "Scope", UserID = UserId, AppID, ModelID, UserRole = AppUserRole };
                    HttpContext.Current.Session["userappAccessScope"] = GetWorkingProfile(para)[0].AccessScope;
                }
                return HttpContext.Current.Session["userappAccessScope"].ToString();
            }
            set
            {
                HttpContext.Current.Session["userappAccessScope"] = value;
            }
        }
        public static List<AppWorkingProfile> GetWorkingProfile(object parameter)
        {
            try
            {              
                //var parameter = new
                //{
                //    Operate ,
                //    UserID , 
                //    AppID,
                //    ModelID,
                //    UserRole
                //};

                 List<AppWorkingProfile> myList;

                if (WebConfig.DataSource() == "API")
                {
                    string uri = "WorkingProfile/list";
                    string qStr = ""; // "/" + UserID + "/" + AppID + "/" + ModelID;
                    myList = ManagePageList<AppWorkingProfile, AppWorkingProfile>.GetList("API", uri, qStr );
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