//using BLL;
//using SIC.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class SecurityManageGroupSub : System.Web.UI.Page
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
                AssemblePage();
                BindGridViewListData();
            }
        }
        private void GetQueryInfo()
        {
            TextBoxCPNum.Text = Page.Request.QueryString["CPNum"].ToString();
            TextBoxUnit.Text = Page.Request.QueryString["sCode"].ToString();
            //  string SchoolYear = Page.Request.QueryString["yCode"].ToString();
            TextBoxUserRole.Text = Page.Request.QueryString["uRole"].ToString();
            TextBoxStaffName.Text = Page.Request.QueryString["sName"].ToString();
            TextBoxUserID.Text = Page.Request.QueryString["nwuID"].ToString();
            WorkingProfile.SchoolCode = Page.Request.QueryString["sCode"].ToString();

        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "Home";
            hfPageID.Value = pageID;
            hfCode.Value = "Search";
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfSelectedTab.Value = "SAP";
            var parameter = new Base2Parameter()
            {
                Operate = "SchoolYearDate",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = WorkingProfile.SchoolCode,
            };
            var myDate = ListData.SearchGeneralList<SchoolDateStr>("SchoolDateList", parameter);

            hfSchoolyearStartDate.Value = myDate[0].StartDate.ToString();
            hfSchoolyearEndDate.Value = myDate[0].EndDate.ToString();
            dateStart.Value = myDate[0].TodayDate.ToString();
            dateEnd.Value = myDate[0].EndDate.ToString();

        }
        private void AssemblePage()
        {

            string scope = "School";
            if (hfUserRole.Value == "Admin") scope = "All";
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = scope
            };
            AppsPage.BuildingList(ddlSchoolYear, "SchoolYear", parameters, WorkingProfile.SchoolYear);
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
            AppsPage.BuildingList(ddlApps, "AppsName", parameters, "SIC");
            AppsPage.BuildingList(ddlAppRole, "AppRolee", parameters, "Teacher");
            SetAppsGroup();
            Assembing_Tab();
        }
        private void InitialPage()
        {

            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            WorkingProfile.SchoolCode = ddlSchool.SelectedValue;

            AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);



        }
        protected void BtnGradeTab_Click(object sender, EventArgs e)
        {
            string Grade = hfSelectedTab.Value;
            if (Grade != "")
            {
                BindGridViewListData();
                Assembing_Tab();
            }

        }

        private void BindGridViewListData()
        {
            string Grade = hfSelectedTab.Value;
            GridView_SAP.Visible = false;
            GridView_SIS.Visible = false;
            GridView_APP.Visible = false;

            switch (Grade)
            {
                case "SAP":
                    GridView_SAP.DataSource = GetDataSource<StaffList>(); //GetDataSource_SAP();
                    GridView_SAP.DataBind();
                    GridView_SAP.Visible = true;
                    break;
                case "SIS":
                    GridView_SIS.DataSource = GetDataSource<ClassesList>(); // GetDataSource_SIS();
                    GridView_SIS.DataBind();
                    GridView_SIS.Visible = true;
                    break;
                case "APP":

                    GridView_APP.DataSource = GetDataSource<GroupList>(); // GetDataSource_APP();
                    GridView_APP.DataBind();
                    GridView_APP.Visible = true;
                    break;
                default:
                    break;
            }
        }
        private List<T> GetDataSource<T>()
        {
            var para = new
            {
                Operate = hfSelectedTab.Value,
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                CPNum = Page.Request.QueryString["CPNum"].ToString()
            };

            var myList = ManagePageList<T, StaffMemberOf>.GetListbyT2(para.Operate, para);


           // var myList = ListData.GeneralList<T>("SecurityManage", pageID, parameter);
            return myList;
        }
/*
        private List<StaffList> GetDataSource_SAP()
        {
            var parameter = new
            {
                Operate = "SecurityContentSAP",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                CPNum = Page.Request.QueryString["CPNum"].ToString()
            };

            var myList = ListData.GeneralList<StaffList>("SecurityManage", pageID, parameter);
            return myList;
        }
        private List<ClassesList> GetDataSource_SIS()
        {
            var parameter = new
            {
                Operate = "SecurityContentSIS",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                CPNum = Page.Request.QueryString["CPNum"].ToString()

            };

            var myList = ListData.GeneralList<ClassesList>("SecurityManage", pageID, parameter);
            return myList;
        }
        private List<GroupList> GetDataSource_APP()
        {
            var parameter = new
            {
                Operate = "SecurityContentAPP",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = Page.Request.QueryString["sCode"].ToString(),
                CPNum = Page.Request.QueryString["CPNum"].ToString()
            };

            var myList = ListData.GeneralList<GroupList>("SecurityManage", pageID, parameter);
            return myList;
        }
*/
        private void Assembing_Tab()
        {
            var parameters = new
            {
                Operate = "SecurityContentTab",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode = WorkingProfile.SchoolCode
            };
            var Grade = hfSelectedTab.Value; ;
            AppsPage.BuildingTab(GradeTab, parameters, Grade);


            //    await BindGridViewListData();


        }

        protected void DDLApps_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetAppsGroup();
        }

        protected void DDLSchool_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            SetAppsGroup();
        }

        protected void DDLSchoolCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchool, ddlSchoolCode.SelectedValue);
            SetAppsGroup();
        }
        private void SetAppsGroup()
        { var parameters = new CommonListParameter()
        {
            Operate = "AppsGroupID",
            UserID = User.Identity.Name,
            Para1 = hfUserRole.Value,
            Para2 = ddlApps.SelectedValue,
            Para3 = ddlSchoolCode.SelectedValue,
        };
            AppsPage.BuildingList(ddlGroupID, "AppsGroupID", parameters);
            WorkingProfile.SchoolCode = ddlSchoolCode.SelectedValue;
        }

        protected void BtnAddToSchool_Click(object sender, EventArgs e)
        {
            SaveData("AddUserToSchool");
        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
            SaveData("GrantPermission");

        }
        private void SaveData(string action)
        {
            var parameter = new
            {
                Operate = action,
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlSchoolCode.SelectedValue,
                CPNum = Page.Request.QueryString["CPNum"].ToString(),
                AppID = ddlApps.SelectedValue,
                GroupID = ddlGroupID.SelectedValue,
                Permission = rblPermission.SelectedValue,
                StartDate = dateStart.Value ,
                EndDate =  dateEnd.Value,
                Comments = TextComments.Text
            };

            //var Result = AppsBase.GeneralValue<string>("dbo.SIC_sys_UserGroupMember_Teachers", parameter, btnSubmit);
            //Assembing_Tab();
            //CreateClientMessage(Result, action);

        }
        private void CreateClientMessage(string result, string action) {
            try { 
                string strScript = "ShowSaveMessage('" +  action +"','" + result + "');";

                Page.ClientScript.RegisterStartupScript(GetType(), "actionMessage", strScript, true);
 
            }
            catch (Exception ex)
            { string em = ex.StackTrace; }
        }
    }
}