using ASMBLL;
using ClassLibrary;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;

namespace ASM.Tests
{
    [TestClass()]
    public class ManagePageListAPITests
    {
      //  private readonly string _dataSource = "SQL";
      //  private readonly string _callMethod = "ClassCall";
        [TestInitialize]
        public void Setup()
        {

        }


        [TestMethod()]
        public void GetList_GetUserGroupListfromUserGroupListAPI_ReturnUserGroupList()
        {
            // Arrange 
            //  string uri = "common/grouplist";
            string uri = "usergroup/list";
            string qStr = "/0354/SIC";

            string expect = "Grade 05 Work Group";
            //  var expect = "Grade 05 Work Group";

            //Act 


            var list = ManagePageList<GroupList, UserGroup>.GetList("API", uri, qStr);


            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Geoup Member Student type  . ");
        }

        [TestMethod()]
        public void GetList_GetUserGroupListfromCommonGroupListAPI_ReturnUserGroupList()
        {
            // Arrange 
            string uri = "common/grouplist";
            // string uri = "usergroup/list";
            string qStr = "/0354/SIC";

            string expect = "Grade 05 Work Group";
            //  var expect = "Grade 05 Work Group";

            //Act 

            var list = ManagePageList<GroupList, UserGroup>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Geoup Member Student type  . ");
        }

        [TestMethod()]
        public void GetList_GetStaffListfromStaffListAPI_ReturnUserGroupList()
        {
            // Arrange 
            string uri = "staff/list";
            var parameter = new { SchoolCode = "0354", SearchBy = "SurName", SearchValue = "Pa", Scope = "Board" };
            string qStr = "/" + parameter.SchoolCode + "/" + parameter.SearchBy + "/" + parameter.SearchValue + "/" + parameter.Scope;

            string expect = "Pa";

            //Act 

            var list = ManagePageList<StaffList, StaffList>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.LastName.Substring(0, 2) == expect
                         select s.LastName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }

        [TestMethod()]
        public void GetList_GetStaffSAPInfoStaffSAPAPI_ReturnUserGroupList()
        {
            // Arrange 
            string uri = "staff/SAP";
            var para = new { SchoolCode = "0354", SchoolYear = "20202021", CPNum = "00050347" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "bonavoj";

            //Act 

            var list = ManagePageList<StaffList, StaffMemberOf>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.UserID == expect
                         select s.UserID;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }

        [TestMethod()]
        public void GetList_GetStaffSISInfoStaffSISAPI_ReturnUserGroupList()
        {
            // Arrange 
            string uri = "staff/SIS";
            var para = new { SchoolCode = "0354", SchoolYear = "20212022", CPNum = "00051449" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "W04-05/1";

            //Act 

            var list = ManagePageList<ClassesList, StaffMemberOf>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.ClassCode == expect
                         select s.ClassCode;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }
        [TestMethod()]
        public void GetList_GetStaffAppInfoStaffAPPAPI_ReturnUserGroupList()
        {
            // Arrange 
            string uri = "staff/App";
            var para = new { SchoolCode = "0354", SchoolYear = "20202021", CPNum = "00050347" };
            string qStr = "/" + para.SchoolCode + "/" + para.SchoolYear + "/" + para.CPNum;

            string expect = "Grade 05 Students";

            //Act 
            var list = ManagePageList<GroupList, StaffMemberOf>.GetList("API", uri, qStr);

            var result = from s in list
                         where s.MemberID == "05"
                         select s.GroupName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" staff Member contain {result} ");
        }
    }
}