//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class StaffManageSub2 : System.Web.UI.Page
    {
        readonly string pageID = "MultipleSchoolList";
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
                AssemblePage();
                
                BindGridViewListData(hfSelectedTab.Value);
            }
        }
        private void GetQueryInfo()
        {
            TextBoxUnit.Text = Page.Request.QueryString["SchoolCode"].ToString();
            TextBoxStaffRole.Text = Page.Request.QueryString["xType"].ToString();
            TextBoxCPNum.Text = Page.Request.QueryString["ModelID"].ToString();
            TextBoxStaffName.Text = Page.Request.QueryString["xName"].ToString();
            TextBoxUserID.Text = Page.Request.QueryString["xID"].ToString();
            hfSelectedTab.Value = "North";

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfCode.Value = "Search";
            hfUserID.Value  = WorkingProfile.UserId  ;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfSchoolYear.Value = WorkingProfile.SchoolYear;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
          //  hfSelectedTab.Value = "North";
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
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };
            //AppsPage.BuildingList(ddlSchoolYear, "SchoolYear", parameters, WorkingProfile.SchoolYear);
            //AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, WorkingProfile.DefaultAppID);
            AppsPage.BuildingList(ddlAppRole, "AppRole", parameters, TextBoxStaffRole.Text);
          //  SetAppsGroup();
           Assembing_Tab();
        }
        private void InitialPage()
        {

            //AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            //WorkingProfile.SchoolCode = ddlSchool.SelectedValue;

            //AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            //AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);



        }
        private void Assembing_Tab()
        {
            var parameters = new
            {
                Operate = "RangerTab",
                UserID = WorkingProfile.UserId,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = TextBoxUnit.Text
            };
            var Grade = hfSelectedTab.Value;
            AppsPage.BuildingTab(GradeTab, parameters, Grade);


            //    await BindGridViewListData();


        }
        protected void BtnGradeTab_Click(object sender, EventArgs e)
        {
            string Grade = hfSelectedTab.Value;
            if (Grade != "")
            {
                BindGridViewListData(Grade);
                Assembing_Tab();
            }

        }

        private void BindGridViewListData(string grade)
        { 
                    GridView1.DataSource = GetDataSource<SchoolSelectedList>(grade); // GetDataSource_APP();
                    GridView1.DataBind();
                    GridView1.Visible = true;        
        }
        private List<T> GetDataSource<T>(string grade)
        {
            var para = new
            {
                Operate = "SchoolList",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = grade,
                StaffUserID = TextBoxUserID.Text
            };

            List<T> myList;
            if (WebConfig.DataSource() == "API")
            {
                string uri = "staff/" + grade; // SAP";
                string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.StaffUserID;
                myList = ManagePageList<T, UserGroup>.GetList("API", uri, qStr);
            }
            else
            {
                // var myList = ListData.GeneralList<T>("SecurityManage", pageID, parameter);
                myList = ManagePageList<T, StaffWorkingSchools>.GetList("SQL", "ClassCall", para);
            }
            return myList;
        }

      
        private void CreateClientMessage(string result, string action)
        {
            try
            {
                string strScript = "ShowSaveMessage('" + action + "','" + result + "');";

                Page.ClientScript.RegisterStartupScript(GetType(), "actionMessage", strScript, true);

            }
            catch (Exception ex)
            { string em = ex.StackTrace; }
        }
    }
}