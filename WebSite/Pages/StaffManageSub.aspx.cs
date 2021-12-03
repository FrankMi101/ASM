//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ASM.Pages
{
    public partial class StaffManageSub : System.Web.UI.Page
    {
        readonly string pageID = "SecurityContentList";
        protected void Page_Error(object sender, EventArgs e)
        {
            //Exception Ex = Server.GetLastError();
            //Server.ClearError();
            //Response.Redirect("../Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                GetQueryInfo();
                SetPageAttribution(); 
                BindGridViewListData();
            }
        }
        private void GetQueryInfo()
        {
            TextBoxUnit.Text = Page.Request.QueryString["SchoolCode"].ToString(); 
            TextBoxStaffRole.Text = Page.Request.QueryString["xType"].ToString();
            TextBoxCPNum.Text = Page.Request.QueryString["ModelID"].ToString();  
            TextBoxStaffName.Text = Page.Request.QueryString["xName"].ToString();
            TextBoxUserID.Text = Page.Request.QueryString["xID"].ToString();
           
        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfCode.Value = "Search";
            hfUserID.Value  = WorkingProfile.UserId  ;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
          // hfSelectedTab.Value = "SAP";
            var parameter = new Base2Parameter()
            {
                Operate = "SchoolYearDate",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = WorkingProfile.SchoolCode,
            };
            var myDate = ListData.SearchGeneralList<SchoolDateStr>("SchoolDateList", parameter);

            hfSchoolyearStartDate.Value = myDate[0].StartDate.ToString();
            hfSchoolyearEndDate.Value = myDate[0].EndDate.ToString();
           
        }
    
        private void BindGridViewListData()
        {
           // string Grade = hfSelectedTab.Value;
   
                    GridView_SAP.DataSource = GetDataSource<StaffList>("SAP", ImgSAP); //GetDataSource_SAP();
                    GridView_SAP.DataBind(); 
  
                    GridView_SIS.DataSource = GetDataSource<ClassesList>("SIS", ImgSIS); // GetDataSource_SIS();
                    GridView_SIS.DataBind(); 
 
                    GridView_APP.DataSource = GetDataSource<GroupList>("APP", ImgAPP); // GetDataSource_APP();
                    GridView_APP.DataBind(); 
   
        } 
        private List<T> GetDataSource<T>(string grade, WebControl imgButton)
        {
            var para = new
            {
                Operate = grade,
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolCode = TextBoxUnit.Text,
                SchoolYear = WorkingProfile.SchoolYear,
                CPNum = TextBoxCPNum.Text
            };

            List<T> myList;
            if (WebConfig.DataSource() == "API")
            {
                string uri = "staff/" + grade; // SAP";
                string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;
                myList = ManagePageList<T, UserGroup>.GetList("API", uri, qStr);
            }
            else
            {
                // var myList = ListData.GeneralList<T>("SecurityManage", pageID, parameter);
                myList = ManagePageList<T, StaffMemberOf>.GetList("SQL", "ClassCall", para, imgButton);
            }
            return myList;
        }
 
    }
}