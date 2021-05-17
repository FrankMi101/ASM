using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace BLL 
{
    public class UserLastWorking
    {
        public UserLastWorking()
        { }
        public static string EmployeeID
        {
            get
            {
                return LastValue("WorkingUser");
            }
            set
            {
                LastValue("WorkingUser", value);
            }
        }
        public static string SchoolYear
        {
            get
            {
                return LastValue("WorkYear");
            }
            set
            {
                LastValue("WorkYear", value);
            }
        }
        public static string OpenSchoolYear
        {
            get
            {
                return LastValue("OpenSchoolYear");
            }
            set
            {
                LastValue("OpenSchoolYear", value);
            }
        }
        public static string SchoolCode
        {
            get
            {
                return LastValue("WorkUnit");
            }
            set
            {
                LastValue("WorkUnit", value);
            }
        }
        public static string SchoolArea
        {
            get
            {
                return LastValue("WorkArea");
            }
            set
            {
                LastValue("WorkArea", value);
            }
        }
        public static string SchoolName
        {
            get
            {
                return LastValue("SchoolName");
            }

        }
        public static string AppraisalSession
        {
            get
            {
                return LastValue("WorkSession");
            }
            set
            {
                LastValue("WorkSession", value);
            }
        }
        public static string AppraisalType
        {
            get
            {
                return LastValue("AppraisalCategory");
            }
            set
            {
                LastValue("AppraisalCategory", value);
            }
        }
        public static string AppraisalArea
        {
            get
            {
                return LastValue("AppraisalArea");
            }
            set
            {
                LastValue("AppraisalArea", value);
            }
        }
        public static string AppraisalItem
        {
            get
            {
                return LastValue("AppraisalItem");
            }
            set
            {
                LastValue("AppraisalItem", value);
            }
        }
        public static string AppraisalItemName
        {
            get
            {
                return LastValue("AppraisalItemName");
            }

        }
        public static string EmployeeName
        {
            get
            {
                return LastValue("EmployeeName");
            }

        }
        public static string WorkingListName
        {
            get
            {
                return LastValue("WorkingListName");
            }
        }
        public static string WorkingListAreaName
        {
            get
            {
                return LastValue("WorkingListAreaName");
            }

        }
        public static string ClientScreen
        {
            get
            {
                return LastValue("ClientScreen");
            }

        }
        static readonly string SP = "dbo.EPA_sys_UserWorkingTrack";

        private static string LastValue(string operate)
        {
            try
            {
                 
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name
                };

                return CommonExecute<string>.ValueOfT(SP + " @Operate, @UserID", parameter);
 
            }
            catch (Exception ex)
            {
                var em = ex.Message;
                return "";
            }
            finally
            { }
        }
        private static void LastValue(string operate, string value)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Value = value
                };

                string result =  CommonExecute<string>.ValueOfT(SP + " @Operate, @UserID,@Value", parameter); 
            }
            catch (Exception ex)
            { var em = ex.Message; }
            finally
            { }
        }
        public static string LastValue(string userId, string operate, string value, string machin_name, string screen_size, string browser_type, string browser_version)
        {
            try
            {
                var parameter = new
                {
                    Operate = operate,
                    UserID = HttpContext.Current.User.Identity.Name,
                    Value = value,
                    MachinName = machin_name,
                    ScreenSize = screen_size,
                    BrowserType = browser_type,
                    BrowserVersion = browser_version
                };

                return CommonExecute<string>.ValueOfT(SP + " @Operate, @UserID,@Value,@MachinName,@ScreenSize,@BrowserType,@BrowserVersion", parameter);

                 
            }
            catch (Exception ex)
            {
                string myEx = ex.Message;
                return null;
            }
            finally
            { }
        }
     
    }
}
