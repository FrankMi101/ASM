//using BLL;
//using SIC.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM
{
    public partial class ListPage_School : System.Web.UI.Page
    {
        readonly string pageID = "SchoolListPage";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
                AssemblePage();
                BindGridViewData();
            }
            Assembing_GradeTab();

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
            hfSelectedTab.Value = "Elementary"; 
        }
        private void AssemblePage()
        {
            hfSearchTextFields.Value = WebConfig.getValuebyKey("TextSearchFields");
            string schoolYear = WorkingProfile.SchoolYear;
            string schoolCode = WorkingProfile.SchoolCode;
            try
            {
 
                var parameters = new CommonListParameter()
                {
                    Operate = "",
                    UserID = User.Identity.Name,
                    Para1 = hfUserRole.Value,
                    Para2 = WorkingProfile.SchoolYear,
                    Para3 = WorkingProfile.SchoolCode,
                };
                AppsPage.BuildingList(ddlSchoolYear, "SchoolYear", parameters, schoolYear);
                AppsPage.BuildingList(ddlArea, "SchoolArea", parameters, schoolYear);


                string BoardRole = WebConfig.getValuebyKey("BoardAccessRole");

               
                InitialPage();
             
            }
            catch (Exception ex)
            { var em = ex.Message; }
        }
        private void InitialPage()
        {
            
            hfSearchby.Value = "SchoolName";
            hfSearchValue.Value = ""; 
        }
        protected void DDLSchoolYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            UserLastWorking.SchoolYear = ddlSchoolYear.SelectedValue;
            WorkingProfile.SchoolYear = ddlSchoolYear.SelectedValue;
            //  await BindGridViewData();
        }

        protected void DDLArea_SelectedIndexChanged(object sender, EventArgs e)
        {
           
        }
       
        protected void BtnGradeTab_Click(object sender, EventArgs e)
        {
            string Grade = hfSelectedTab.Value;
            if (Grade != "")
            {
                BindGridViewData();
            }

        }
        protected void BtnSearch_Click(object sender, EventArgs e)
        {

            BindGridViewData();
        }
        protected void BtnSearchGo_Click(object sender, EventArgs e)
        {
            BindGridViewData();
        }
        // private async Task BindGridViewData()
        private void BindGridViewData()
        {
            try
            {
                // GridView1.DataSource = await Task.Run(() => GetDataSource());// GetDataSource(true);
                GridView1.DataSource = GetDataSource();
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                var em = ex.Message;
            }

        }

        private List<SchoolList> GetDataSource()
        {
     
            var parameter = new
            {
                Operate = pageID,
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlArea.SelectedValue,
                Grade = hfSelectedTab.Value,
                SearchBy = hfSearchby.Value,  
                Searchvalue = hfSearchValue.Value,  
            };
          //  initialSearchBox();
            var myList = ListData.SearchGeneralList<SchoolList>(pageID, parameter, btnSearchGo);
            return myList;
        }
   
        private void Assembing_GradeTab()
        {
            var parameters = new
            {
                Operate = "PanelTab",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = ddlSchoolYear.SelectedValue,
                SchoolCode = ddlArea.SelectedValue
            };
            AppsPage.BuildingTab(GradeTab, parameters, hfSelectedTab.Value);


            //    await BindGridViewData();


        }
    }
}