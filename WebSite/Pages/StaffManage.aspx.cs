//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class StaffManage : System.Web.UI.Page
    {
        readonly string pageID = "SecurityStaffList";
        protected void Page_Error(object sender, EventArgs e)
        {
            Exception Ex = Server.GetLastError();
            Server.ClearError();
            Response.Redirect("../Error.aspx?pageID=" + pageID + "&ex=" + Ex.Message);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                SetPageAttribution();
                AssemblePage();
                //    string pID = Page.Request.QueryString["Scope"].ToString();
              //  BindGridViewListData();
            }
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
                UserID  = WorkingProfile.UserId  ,
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
            GridView1.DataSource = GetDataSource<StaffList>();
            GridView1.DataBind();
        }

        private List<T> GetDataSource<T>()
        {
            string scope = CheckBoxBoard.Checked ? "Board" : "School";
            var parameter = new
            {
                Operate = "SecurityStaffList",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolCode =  ddlSchool.SelectedValue,
                SearchBy = hfSearchby.Value,  
                SearchValue = hfSearchValue.Value,  
                Scope = scope

            };

            List<T> myList;
            
            if (WebConfig.DataSource() == "API")
            {
                string uri = "staff/list";
                string qStr = "/" + parameter.SchoolCode + "/" + parameter.SearchBy + "/" + parameter.SearchValue + "/" + parameter.Scope;
                 myList = ManagePageList<T, StaffList>.GetList("API",uri, qStr, btnSearchGoFirstName);
            }
            else
            {
              myList = ManagePageList<T, StaffList>.GetList("SQL","ClassCall", parameter, btnSearchGoFirstName);
            }
            // var myList = ListData.GeneralList<StaffList>("SecurityManage", pageID, parameter, btnSearchGoCPNum);
            return myList;
        }
 
 
    }
}