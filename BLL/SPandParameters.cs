using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class SPandParameters
    {

        public SPandParameters()
        {

        }
        public static string GetValue<T>()
        {
           
            var typeName = (typeof(T)).Name;
            string pForComments = " @Operate,@UserID,@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@Category, @Area, @ItemCode";
            string pForDomain = pForComments + ",@DomainID, @CompetencyID";
            switch (typeName)
            {
                case "AppraisalComment":
                   return  "dbo.EPA_Appr_AppraisalData_Text" + pForComments + ", @Value";
                case "AppraisalCompetency":
                    return "dbo.EPA_Appr_AppraisalData_TextCompetency" + pForDomain + ", @Rate, @Value";
                case "AppraisalDate":
                    return "dbo.EPA_Appr_AppraisalData_ObservationDate2" + pForComments + ", @Date, @Value";
                case "ObservationList":
                    return "dbo.EPA_Appr_AppraisalData_ObservationList" + pForDomain + ", @Check, @Value";
                default:
                    return "";
            }

        }
        public static string GetValue<T>(string action)
        {
            var typeName = (typeof(T)).Name;
             switch (typeName)
            {
                case "GeneralList":
                    return  GeneralList.GetSP(action);
                
                default:
                    return "";
            }

        }
        public static string GetList<T>()
        {
            var typeName = (typeof(T)).Name;
            string pForList = " @Operate, @UserID, @SchoolYear, @SchoolCode, @SearchBy, @SearchValue";
            string pCompetencyComments = " @Operate,@UserID,@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@Category, @Area, @ItemCode, @DomainID, @CompetencyID";
            // string pSystemSetup = " @Operate, @UserID, @Category, @Area, @IDs, @Code, @Name, @Comments, @Active";

            switch (typeName)
            {
                case "AppraisalList":
                    return "dbo.EPA_Appr_AppraisalStaffList" + pForList;
                case "AppraisalStaffList":
                    return "dbo.EPA_ORG_StaffList" + pForList;
                case "AppraisalHistory":
                    return "dbo.EPA_Appr_AppraisalStaffHistory" + pForList;
                case "AppraisalNotice":
                    return "dbo.EPA_Appr_AppraisalStaffListNotice" + pForList + ", @NoticeType, @NoticeArea";
                case "CommonList":
                    return "dbo.EPA_sys_getListsValuePara" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "CommonListSchool":
                    return "dbo.EPA_sys_getSchoolList" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "ObservationList":
                    return "dbo.EPA_Appr_AppraisalData_ObservationList" + pCompetencyComments;
            
                default:
                    return "";
            }
        }
        public static string GetList<T>(string action)
        {
            var typeName = (typeof(T)).Name;
            string pForList = " @Operate, @UserID, @SchoolYear, @SchoolCode, @SearchBy, @SearchValue";
            string pCompetencyComments = " @Operate,@UserID,@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@Category, @Area, @ItemCode, @DomainID, @CompetencyID";
      
            switch (typeName)
            {
                case "AppraisalList":
                    return "dbo.EPA_Appr_AppraisalStaffList" + pForList;
                case "AppraisalStaffList":
                    return "dbo.EPA_ORG_StaffList" + pForList;
                case "AppraisalHistory":
                    return "dbo.EPA_Appr_AppraisalStaffHistory" + pForList;
                case "AppraisalNotice":
                    return "dbo.EPA_Appr_AppraisalStaffListNotice" + pForList + ", @NoticeType, @NoticeArea";
                case "CommonList":
                    return "dbo.EPA_sys_getListsValuePara" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "CommonListSchool":
                    return "dbo.EPA_sys_getSchoolList" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "ObservationList":
                    return "dbo.EPA_Appr_AppraisalData_ObservationList" + pCompetencyComments;
                case "AppraisalCompetency":
                    return "dbo.EPA_Appr_AppraisalData_TextCompetency" + pCompetencyComments  ;
             
                default:
                    return "";
            }
        }
        public static string GetSPNameAndParameters(string page, string action)
        {
            switch (page)
            {
                case "AppList":
                    return GetSP_AppraisalList(action);
                case "AppContent":
                    return GetSP_AppraisalContent(action);
              
                case "General":
                    return GetSP_GenderalList(action);
                default:
                    return page; // direct stored and parameters
            }


        }
        private static string GetSP_GenderalList(string action)
        {
            string parameter = " @Operate,@UserID,@Para1,@Para2,@Para3";

            switch (action)
            {

                case "DDList":
                    return "dbo.EPA_sys_getListsValuePara" + parameter;
                case "Schools":
                    return "dbo.EPA_sys_getSchoolList" + parameter;
                default:
                    return "";

            }

        }

        private static string GetSP_AppraisalList(string action)
        {
            string pForList = " @Operate, @UserID, @SchoolYear, @SchoolCode, @SearchBy, @SearchValue";
            string pCompetencyComments = " @Operate,@UserID,@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@Category, @Area, @ItemCode, @DomainID, @CompetencyID";
 
            switch (action)
            {
                case "AppraisalList":
                    return "dbo.EPA_Appr_AppraisalStaffList" + pForList;
                case "AppraisalStaffList":
                    return "dbo.EPA_ORG_StaffList" + pForList;
                case "AppraisalHistory":
                    return "dbo.EPA_Appr_AppraisalStaffHistory" + pForList;
                case "AppraisalNotice":
                    return "dbo.EPA_Appr_AppraisalStaffListNotice" + pForList + ", @NoticeType, @NoticeArea";
                case "CommonList":
                    return "dbo.EPA_sys_getListsValuePara" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "CommonListSchool":
                    return "dbo.EPA_sys_getSchoolList" + " @Operate, @UserID, @Para1, @Para2, @Para3";
                case "ObservationList":
                    return "dbo.EPA_Appr_AppraisalData_ObservationList" + pCompetencyComments;
                case "AppraisalCompetency":
                    return "dbo.EPA_Appr_AppraisalData_TextCompetency" + pCompetencyComments;
              
                default:
                    return "";
            }
        }

        private static string GetSP_AppraisalContent(string action)
        {
            string parameter = " @Operate, @UserID, @SchoolYear, @SchoolCode, @PositionID";
            string parameters = parameter + ", @PositionType";
            string pForComments = " @Operate,@UserID,@SchoolYear,@SchoolCode,@EmployeeID,@SessionID,@Category, @Area, @ItemCode";
            string pForDomain = pForComments + ",@DomainID, @CompetencyID";
            switch (action)
            {
                case "AppraisalComment":
                    return "dbo.EPA_Appr_AppraisalData_Text" + pForComments + ", @Value";
                case "AppraisalCompetency":
                    return "dbo.EPA_Appr_AppraisalData_TextCompetency" + pForDomain + ", @Rate, @Value";
                case "AppraisalDate":
                    return "dbo.EPA_Appr_AppraisalData_ObservationDate2" + pForComments + ", @Date, @Value";
                case "ObservationList":
                    return "dbo.EPA_Appr_AppraisalData_ObservationList" + pForDomain + ", @Check, @Value";
                default:
                    return "";
            }

        }




        public string GetSP(string pageName, string action)
        {
            switch (pageName)
            {
                case "Publish":
                    return GetSP_Publish(action);
                case "Interview":
                    return GetSP_Interview(action);
                case "General":
                    return GetSP_General(action);
                default:
                    return GetSP_General(action);

            }
        }

        private string GetSP_Publish(string action)
        {
            string pForSingle = " @SchoolYear,@PositionID";
            string pForList = " @Operate,@UserID,@SchoolYear,@PositionType,@Panel,@Status,@SearchBy, @SearchValue1, @SearchValue2";
            switch (action)
            {
                case "Position":
                    return "dbo.tcdsb_LTO_PagePublish_Position" + pForSingle;
                case "Positions":
                    return "dbo.tcdsb_LTO_PagePublish_Positions" + pForList;
                default:
                    return "dbo.tcdsb_LTO_PagePublish_Position" + pForSingle;

            }
        }
        private string GetSP_General(string action)
        {
            string pForSingle = " @Operate,@Para1,@Para2,@Para3,@Para4";
            switch (action)
            {
                case "DDList":
                    return "dbo.EPA_sys_getListsValuePara" + pForSingle;
                case "Schools":
                    return "dbo.EPA_sys_getSchoolList" + pForSingle;
                default:
                    return "";


            }
        }
        private string GetSP_Interview(string action)
        {
            string pForSingle = " @Operate,@Para1,@Para2,@Para3,@Para4";
            switch (action)
            {
                case "DDList":
                    return "dbo.tcdsb_LTO_PageGeneral_List" + pForSingle;
                case "Positions":
                    return "dbo.tcdsb_LTO_PageGeneral_Schools" + pForSingle;
                default:
                    return "dbo.tcdsb_LTO_PageGeneral_List" + pForSingle;

            }
        }
    }
}
