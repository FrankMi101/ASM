using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ASMBLL;
using ClassLibrary;

namespace WebAPI.Controllers.Tests
{
    [TestClass()]
    public class StaffControllerTests
    {
        private readonly string _url = WebConfig.APISite();

        [TestMethod()]
        public void Get_bySearchStaffListbySurName_ReturnStaffListMatccSearchcondition_Test()
        {
            // Arrange 
            string uri = "staff/list";
            var para = new { SchoolCode = "0354", SearchBy = "SurName", SearchValue = "Pa", Scope = "Board" };
            string qStr = "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;

            string expect = "Pa";

            //Act 

            var iAction = new ActionAppList<StaffList, StaffList>("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.LastName.Substring(0, 2) == expect
                         select s.LastName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }

        [TestMethod()]
        public void GetSAP_SearchbyParameter_returnSAPInformation_Test()
        {
            string uri = "staff/SAP";
            var para = new { SchoolCode = "0354", SchoolYear = "20202021", CPNum = "00050347" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "bonavoj";

            //Act 
            var iAction = new ActionAppList<StaffList, StaffMemberOf>("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.UserID == expect
                         select s.UserID;
            //Assert
        }

        [TestMethod()]
        public void GetSIS_byParameter_ReturnUserClassList_Test()
        {
            // Arrange 
            string uri = "staff/SIS";
            var para = new { SchoolCode = "0354", SchoolYear = "20212022", CPNum = "00051449" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "W04-05/1";

            //Act 
            var iAction = new ActionAppList<ClassesList, StaffMemberOf>("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);


            //    var list = ManagePageList<ClassesList, StaffMemberOf>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.ClassCode == expect
                         select s.ClassCode;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");

        }

        [TestMethod()]
        public void GetAPP_SearchbyParameter_ReturnUserAppGroupInformation_Test()
        {
            // Arrange 
            string uri = "staff/App";
            var para = new { SchoolCode = "0354", SchoolYear = "20202021", CPNum = "00050347" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "Grade 05 Students";

            //Act 
            var iAction = new ActionAppList<GroupList, StaffMemberOf>("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);


            var result = from s in list
                         where s.MemberID == "05"
                         select s.GroupName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");

        }

        [TestMethod()]
        public void GetGroup_SearchbyParameter_ReturnAllGroupListbySchoolandAppID_Test()
        {
            // Arrange 
            string uri = "staff/Group";
              var para = new { SchoolCode = "0354", AppID ="SIC" };
           // var para = new { Operate = "GroupList", UserID = "asm", UserRole = "admin", SchoolCode = "0354", AppID = "SIC" };
            string qStr = "/" + para.SchoolCode + "/" + para.AppID;

            string expect = "Grade 05 Students";

            //Act

          //  var _action = new ActionAppList<GroupList, UserGroup>("SQL");
          //   var list = _action.GetObjList(para);


            var iAction = new ActionAppList<GroupList, UserGroup>("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);


            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }
    }
}