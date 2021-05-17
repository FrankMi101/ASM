//using BLL;
//using ASM.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM
{
    public partial class ListPage_Student : System.Web.UI.Page
    {
        readonly string pageID = "StudentListPage";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
                AssemblePage();
                BindStudentListGridViewData();
            }
        }
        private void SetPageAttribution()
        {
            hfCategory.Value = "StudentInfo";
            hfArea.Value = pageID;
            hfPageID.Value = pageID;
            hfItemCode.Value = "Search";
            hfUserID.Value = User.Identity.Name;
            hfUserLoginRole.Value = WorkingProfile.UserRoleLogin;
            hfUserRole.Value = WorkingProfile.UserRole;
            hfRunningModel.Value = WebConfig.RunningModel();
            Session["HomePage"] = "Loading.aspx?pID=" + pageID ;
            hfSelectedTab.Value = "01";
            Session["Semester"] = "1";
            Session["Term"] = "1";
        }
        private void AssemblePage()
        {
            hfSearchTextFields.Value = WebConfig.getValuebyKey("TextSearchFields");
            string schoolYear = WorkingProfile.SchoolYear;
            string schoolCode = WorkingProfile.SchoolCode;
            try
            {

                if (schoolCode.Substring(0, 2) == "05")
                {
                    hfSelectedTab.Value = "09";

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
                if (ddlSchool.SelectedValue != "") Assembing_GradeTab();
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
            hfSearchby.Value = "LastName";
            hfSearchValue.Value = "";
             //ddlSearchby.SelectedIndex = 0;
            //TextSearch.Visible = true;
           // ddlSearchValue.Visible = false;
        }
        protected void DDLSchoolYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            UserLastWorking.SchoolYear = ddlSchoolYear.SelectedValue;
            WorkingProfile.SchoolYear = ddlSchoolYear.SelectedValue;
            //  await BindGridViewData();
        }

        protected void DDLPanel_SelectedIndexChanged(object sender, EventArgs e)
        {
            var parameters = new CommonListParameter()
            {   Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = DDLPanel.SelectedValue
            }; 
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters);
            WorkingProfile.SchoolCode = ddlSchool.SelectedValue;
            if (DDLPanel.SelectedValue == "E")
                hfSelectedTab.Value = "01";
            else
                hfSelectedTab.Value = "09";

            SchoolChange();
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
            Assembing_GradeTab();
            BindStudentListGridViewData();
            //ddlSearchby.SelectedIndex = 0;
            //TextSearch.Visible = true;
            //ddlSearchValue.Visible = false;
            hfSearchby.Value = "LastName";
            hfSearchValue.Value = "";

        }
        //protected void DDLSearchBy_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    Assembing_GradeTab();
        //    TextSearch.Visible = false;
        //    ddlSearchValue.Visible = false;
        //    var serachText = WebConfig.getValuebyKey("TextSearchFields");
        //    if (serachText.Contains(ddlSearchby.SelectedValue))  // .IndexOf(ddlSearchby.SelectedValue) != -1)
        //    {
        //        TextSearch.Visible = true;
        //    }
        //    else
        //    {
        //        ddlSearchValue.Visible = true;
        //        AppsPage.BuildingList(ddlSearchValue, ddlSearchby.SelectedValue, User.Identity.Name, ddlSchoolYear.SelectedValue, ddlSchool.SelectedValue, ddlSemester.SelectedValue);
        //        ddlSearchValue.SelectedIndex = 0;
        //    }

        //}
        protected void BtnGradeTab_Click(object sender, EventArgs e)
        {
            string Grade = hfSelectedTab.Value;
            if (Grade != "")
            {
                BindStudentListGridViewData(); 
           }

        }
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
 
           BindStudentListGridViewData();
        }
        protected void BtnSearchGo_Click(object sender, EventArgs e)
        { 
            BindStudentListGridViewData();
        }
        // private async Task BindStudentListGridViewData()
        private void BindStudentListGridViewData()
        {
            try
            {
                Assembing_GradeTab();
                // GridView1.DataSource = await Task.Run(() => GetDataSource());// GetDataSource(true);
                GridView1.DataSource = GetDataSource(); 
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                var em = ex.Message;
            }

        }

        private List<StudentList> GetDataSource()
        {
            Session["Semester"] = ddlSemester.SelectedValue;
            Session["Term"] = ddlTerm.SelectedValue;

            var parameter = new
            {
                Operate = "StudentList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlSchool.SelectedValue,
                Grade = hfSelectedTab.Value,
                SearchBy =  hfSearchby.Value, // ddlSearchby.SelectedValue,
                Searchvalue = hfSearchValue.Value,  //  GetSearchValue(),
                Scope =  ddlScope.SelectedValue,
                Program = ddlProgram.SelectedValue,
                Term = ddlTerm.SelectedValue,
                Semester = ddlSemester.SelectedValue
            };
            initialSearchBox();
            var mystduentList = ListData.SearchGeneralList<StudentList>(pageID,parameter, btnSearchGo);
            return mystduentList;
        }
        //private string GetSearchValue()
        //{
        //    string searchby = ddlSearchby.SelectedValue;
        //    string searchValue = ddlSearchValue.SelectedValue;
        //    var serachText = WebConfig.getValuebyKey("TextSearchFields");
        //    if (serachText.Contains(searchby)) searchValue = TextSearch.Text;
        //    return searchValue;
        //}
       private void initialSearchBox()
        {
            //TextBoxAge.Text = "";
            //TextBoxClass.Text = "";
            //TextBoxFirstName.Text = "";
            //TextBoxLastName.Text = "";
            //TextBoxOEN.Text = "";
            //TextBoxStudentNo.Text = "";
           // hfSearchValue.Value = "";



        }
        private void Assembing_GradeTab()
        {
            var parameters = new
            {
                Operate = "GradeTab",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlSchool.SelectedValue
            };
           // var Grade = hfSelectedTab.Value; ;
            AppsPage.BuildGradeTab(GradeTab, parameters, hfSelectedTab.Value);


            //    await BindStudentListGridViewData();


        }
    }
}