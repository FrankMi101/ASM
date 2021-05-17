//using BLL;
//using ASM.Generic.LIB;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM
{
    public partial class SecurityManageGroup : System.Web.UI.Page
    {
        readonly string pageID = "SecurityStaffList";
        protected void Page_Error(object sender, EventArgs e)
        {
            Exception Ex = Server.GetLastError();
            Server.ClearError();
            Response.Redirect("../Error.aspx?pID=" + pageID + "&ex=" + Ex.Message);
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
            Session["HomePage"] = "Loading.aspx?pID=" + pageID;
            hfSelectedTab.Value = "All";
            hfSearchby.Value = "CPNum";
            Session["Semester"] = "1";
            Session["Term"] = "1";
        }
        private void AssemblePage()
        {
            string BoardRole = WebConfig.getValuebyKey("BoardAccessRole");

            var parameters = new CommonListParameter()
            {
                Operate = "",
                UserID = User.Identity.Name,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = "All"
            };
            
            AppsPage.BuildingList(ddlSchoolCode, ddlSchool, "DDLListSchool", parameters, WorkingProfile.SchoolCode);
       
        }
        private void InitialPage()
        {
            //if (WorkingProfile.SchoolCode == "")
            //{
            //    ddlSchool.SelectedIndex = 0;
            //    AppsPage.SetListValue(ddlSchoolCode, ddlSchool.SelectedValue);
            //    WorkingProfile.SchoolCode = ddlSchool.SelectedValue;
            //}
            //else
            //{
            //    AppsPage.SetListValue(ddlSchoolCode, WorkingProfile.SchoolCode);
            //    AppsPage.SetListValue(ddlSchool, WorkingProfile.SchoolCode);

            //}
            //ddlSearchby.SelectedIndex = 0;
            //TextSearch.Visible = true;
            //ddlSearchValue.Visible = false;


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

        }
        protected void BtnSearchGo_Click(object sender, EventArgs e)
        {
            BindGridViewListData();
        }

        private void BindGridViewListData() { 
            GridView1.DataSource = GetDataSource();
            GridView1.DataBind();
        }

        private List<StaffList> GetDataSource()
        {
            var parameter = new
            {
                Operate = "SecurityStaffList",
                UserID = User.Identity.Name,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear.ToString(),  // ddlSchoolYear.SelectedValue,
                SchoolCode =  ddlSchool.SelectedValue,
                Grade = "All", //hfSelectedTab.Value,
                SearchBy = hfSearchby.Value, // ddlSearchby.SelectedValue,
                SearchValue = hfSearchValue.Value,  //  GetSearchValue(),
                Scope = "Board" // ddlType.SelectedValue
            };

            var myList = ListData.GeneralList<StaffList>("SecurityManage", pageID, parameter, btnSearchGoCPNum);
            return myList;
        }
 
 
    }
}