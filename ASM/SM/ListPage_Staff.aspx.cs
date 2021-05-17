//using BLL;
//using ASM.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM
{ 
    public partial class ListPage_Staff : System.Web.UI.Page
    {
         readonly string pageID = "StaffListPage";
       protected void Page_Error(object sender, EventArgs e)
        {
            Exception Ex = Server.GetLastError();
            Server.ClearError();
            Response.Redirect("Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
                AssemblePage();
            //    string pID = Page.Request.QueryString["Scope"].ToString();
                BindGridViewListData();
            }
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
            Session["HomePage"] = "Loading.aspx?pID=" + pageID ;
            hfSelectedTab.Value = "Teacher";
        }
        private void AssemblePage()
        {
            if (WorkingProfile.UserRole == "Admin")
                ddlType.Enabled = true;
            else
                ddlType.Enabled = false;
            string schoolYear = WorkingProfile.SchoolYear;
            string schoolCode = WorkingProfile.SchoolCode;
            try
            {

                if (schoolCode.Substring(0, 2) == "05")
                { 
                    DDLPanel.SelectedIndex = 1;
                }
                var parameters = new CommonListParameter()
                {
                    Operate = "",
                    UserID = User.Identity.Name,
                    Para1 = hfUserRole.Value,
                    Para2 = WorkingProfile.SchoolYear,
                    Para3 = WorkingProfile.SchoolCode,
                };
                AppsPage.BuildingList(ddlSchoolYear, "SchoolYear", parameters, schoolYear);



                string BoardRole = WebConfig.getValuebyKey("BoardAccessRole");

                if (BoardRole.IndexOf(WorkingProfile.UserRole) != -1)
                    DDLPanel.Enabled = true;
                else
                    DDLPanel.Enabled = false;

                parameters.Para4 = DDLPanel.SelectedValue;
                AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, schoolCode);
                InitialPage();
                if (ddlSchool.SelectedValue != "") Assembing_Tab();
            }
            catch (Exception ex)
            { var em = ex.Message; }
        }
        private void InitialPage()
        {
            if (WorkingProfile.SchoolCode == "")
            {
                ddlSchool.SelectedIndex = 0;
                AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
                WorkingProfile.SchoolCode = ddlSchool.SelectedValue;
            }
            else
            {
                AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
                AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);

            }
            ddlSearchby.SelectedIndex = 0;
            TextSearch.Visible = true;
            ddlSearchValue.Visible = false;


        }
        protected void DDLSchoolYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            UserLastWorking.SchoolYear = ddlSchoolYear.SelectedValue;
            WorkingProfile.SchoolYear = ddlSchoolYear.SelectedValue;
            //  await BindGridViewData();
        }


        protected void DDLSchool_SelectedIndexChanged(object sender, EventArgs e)
        {

            AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            SchoolChange();
        }
        protected void DDLSchoolCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            AppsPage.SetListValue(ddlSchool, ddlSchoolCode.SelectedValue);
            SchoolChange();
        }
        private void SchoolChange()
        {
            UserLastWorking.SchoolCode = ddlSchoolCode.SelectedValue;
            WorkingProfile.SchoolCode = ddlSchoolCode.SelectedValue;
            Assembing_Tab();
        }


        protected void DDLSearchBy_SelectedIndexChanged(object sender, EventArgs e)
        {
             var serachText = WebConfig.getValuebyKey("TextSearchFields");
            if (serachText.Contains(ddlSearchby.SelectedValue)) // if (serachText.IndexOf(ddlSearchby.SelectedValue)  != -1 )
            {
                TextSearch.Visible = true;
                ddlSearchValue.Visible = false;
            }
            else
            {
                TextSearch.Visible = false;
                ddlSearchValue.Visible = true;
                AppsPage.BuildingList(ddlSearchValue, ddlSearchby.SelectedValue, User.Identity.Name, ddlSchoolYear.SelectedValue, ddlSchool.SelectedValue, "");
                ddlSearchValue.SelectedIndex = 0;
            }

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
        protected void BtnSearch_Click(object sender, EventArgs e)
        {

            BindGridViewListData();
            Assembing_Tab();
        }
        // private async Task BindGridViewListData()
        private void BindGridViewListData()
        {
            try
            {
                // GridView1.DataSource = await Task.Run(() => GetDataSource());// GetDataSource(true);
                GridView1.DataSource = GetDataSource();// GetDataSource(true);
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                var em = ex.Message;
            }

        }

        private List<StaffList> GetDataSource()
        {        
             var parameter = new
            {
                Operate = "StaffList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlSchool.SelectedValue,
                Grade = hfSelectedTab.Value,
                SearchBy = ddlSearchby.SelectedValue,
                Searchvalue = GetSearchValue(), //ddlSearchby.SelectedValue == "SurName"? TextSearch.Text : ddlSearchValue.SelectedValue,
                Scope = ddlType.SelectedValue 
            };

            var myList = ListData.SearchGeneralList<StaffList> ( pageID,parameter,btnSearchGo); 
            return myList;
        }
        private string GetSearchValue()
        {
            string searchby = ddlSearchby.SelectedValue;
            string searchValue = ddlSearchValue.SelectedValue;
            var serachText = WebConfig.getValuebyKey("TextSearchFields");
            if (serachText.Contains(searchby)) searchValue = TextSearch.Text;
            return searchValue;
        }

        protected void DDLPanel_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = ddlSchoolYear.SelectedValue,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = DDLPanel.SelectedValue,
            };
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters);

            if (ddlSchool.Items.Count > 0)
            {
                ddlSchool.SelectedIndex = 0;
                AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
                WorkingProfile.SchoolCode = ddlSchool.SelectedValue;
                 
              //      hfSelectedTab.Value = "01";
 
                //Assembing_GradeTab();
                //BindGridViewListData();
            }


        }


        private void Assembing_Tab()
        {
            var parameters = new
            {
                Operate = "StaffTab",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlSchool.SelectedValue
            };
            var Grade = hfSelectedTab.Value; ;
            AppsPage.BuildingTab(GradeTab, parameters, Grade);


            //    await BindGridViewListData();


        }
    }
}