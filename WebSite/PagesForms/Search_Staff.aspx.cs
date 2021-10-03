using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using ClassLibrary;

namespace ASM.PagesForms
{
    public partial class Search_Staff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Page.Response.Expires = 0;
                txtSearch.Text = Page.Request.QueryString ["SearchVal"];
                InitialPage();
                LoadTeacherList();

            }
        }
        private void InitialPage()
        {
            Tab1.Visible = false;
            Tab2.Visible = false;
            Tab3.Visible = false;
            Tab4.Visible = false;
            Tab1.InnerHtml = "My School";
            Tab2.InnerHtml = "TCDSB";
            Tab3.InnerHtml = "";

            Tab1.Visible = true;
            SetTabBehaviour(Tab1, "myDIVList_1");
             Tab2.Visible = true;
            SetTabBehaviour(Tab2, "myDIVList_2");
        }
        private void SetTabBehaviour( HtmlTableCell myControl, string _page)
        {
            myControl.Attributes.Add("onmouseenter", "javascript:setTabMouseEnter(" + myControl.ID + ",'TDFrame2','TDFrame4','" + _page + "')");
        }
        private void LoadTeacherList()
        {
            List<StaffList> staffList = GetDataSource();

            int mySchoolTecherCount = 0;
            foreach (Staff staff in staffList)
            {           
                switch (staff.Category)
                    {
                    case "mySchool":
                        AddDIVElement( myDIVList_1, staff.UserID, staff.CPNum, staff.StaffName);
                        mySchoolTecherCount = +1;
                        break;
                    case "TCDSB":
                        AddDIVElement( myDIVList_2, staff.UserID, staff.CPNum, staff.StaffName);
                        break;
                    case "Other":
                        break;
                    case "Type D":
                        break;
                    default:
                        break;

                }

            }

            hfMySchoolTeacherCount.Value = mySchoolTecherCount.ToString();
            if (mySchoolTecherCount == 0)
            {
                hfcurrentDiv.Value = "myDIVList_2";
                hfcurrentTab.Value = "Tab2";
            }
            else
            {
                hfcurrentDiv.Value = "myDIVList_1";
                hfcurrentTab.Value = "Tab1";
            }

        }
        private List<StaffList> GetDataSource()
        {
            var parameter = new
            {
                Operate = "SecurityStaffList",
                UserID  = WorkingProfile.UserId  ,
                UserRole = "" , // hfUserRole.Value,
                SchoolYear = WorkingProfile.SchoolYear.ToString(),  // ddlSchoolYear.SelectedValue,
                SchoolCode = WorkingProfile.SchoolCode.ToString(),
                Grade = "All", //hfSelectedTab.Value,
                SearchBy =  "SurName", // ddlSearchby.SelectedValue,
                SearchValue = txtSearch.Text,   //  GetSearchValue(),
                Scope = "Board" // ddlType.SelectedValue
            };

            var myList = ListData.GeneralList<StaffList>("SecurityManage", "pageID", parameter);
            return myList;
        }

        private void AddDIVElement( HtmlGenericControl myContainDIV, string myID, string myValue, string myText)
        {

            HtmlGenericControl myItemDIV = new HtmlGenericControl();
            myItemDIV.ID = myValue;
            myItemDIV.Attributes.Add("runat", "server");
            myItemDIV.Attributes.Add("class", "DivOut");
            myItemDIV.Attributes.Add("onclick", "javascript:Subject_ClickHandler()");
            myItemDIV.Attributes.Add("onmouseover", "javascript:setDIV()");
            myItemDIV.Attributes.Add("onmouseout", "javascript:setDIV()");

            myItemDIV.InnerHtml = myText;
            myContainDIV.Controls.Add(myItemDIV);

            HtmlGenericControl myBR = new HtmlGenericControl();
            myBR.InnerHtml = "<br />";
            myContainDIV.Controls.Add(myBR);
        }

        protected void ImageButton1_Click(object sender, EventArgs e)
        {
            hftxtSearch.Value =  txtSearch.Text;
            LoadTeacherList();
            SetSearchFocus();
        }
        private void SetSearchFocus()
        {
            string strScript = " setSearchFocus();";

            ClientScript.RegisterStartupScript(GetType(), "_focusscript", strScript, true);
        }
    }
}

