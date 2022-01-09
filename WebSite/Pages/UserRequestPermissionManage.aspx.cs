//using BLL;
//using SIC.Generic.LIB;
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace ASM.Pages
{
    public partial class UserRequestPermissionManage : System.Web.UI.Page
    {
        readonly string pageID = "UserRequestPermission";
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
                BindGridViewListData();
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
                Operate = "GrantAction",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                Para1 = hfUserRole.Value,
                Para2 = WorkingProfile.SchoolYear,
                Para3 = WorkingProfile.SchoolCode,
                Para4 = "All"
            };
            
            AppsPage.BuildingList(ddlGrantAction, "GrantAction", parameters,"All");
       
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


      
        protected void BtnSearchGo_Click(object sender, EventArgs e)
        {
            BindGridViewListData();
        }

        private void BindGridViewListData() { 
            GridView1.DataSource = GetDataSource<RequestPermissionList>();
            GridView1.DataBind();
        }

        private List<T> GetDataSource<T>()
        {
            string scope = CheckBoxBoard.Checked ? "Board" : "School";
            var parameter = new
            {
                Operate = "List",
                UserID  = WorkingProfile.UserId  ,
                UserRole = hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear,
                SchoolCode =  WorkingProfile.SchoolCode,
                GrantAction = ddlGrantAction.SelectedValue,
                Scope = scope

            };

            List<T> myList;
            
            if (WebConfig.DataSource() == "API")
            {
                string uri = "RequestPermission/list";
                string qStr = "/" + parameter.SchoolYear + "/" + parameter.SchoolCode + "/" + parameter.GrantAction + "/" + parameter.Scope;
                 myList = ManagePageList<T, StaffList>.GetList("API",uri, qStr, btnSearchGo);
            }
            else
            {
              myList = ManagePageList<T, RequestPermission>.GetList("SQL","ClassCall", parameter, btnSearchGo);
            }
             return myList;
        }
 
 
    }
}