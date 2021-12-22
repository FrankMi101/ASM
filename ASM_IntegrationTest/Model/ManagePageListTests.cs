using ASMBLL;
using ClassLibrary;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;

namespace ASM.Tests
{
    [TestClass()]
    public class ManagePageListTests
    {
        private readonly string _dataSource = "SQL";
        private readonly string _callMethod = "ClassCall";
        [TestInitialize]
        public void Setup()
        {

        }

        [TestMethod()]
        public void GetList_GetUserGroupListAppIDandSchoolCode_returnAllGroupList()
        {
            //Arrange
            var expect = "All School Students Group";
            var para = new { Operate = "GroupList", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC" };
            //Act 
            var list = ManagePageList<GroupList, UserGroup>.GetList(_dataSource, _callMethod, para);


            var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group   . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupListbyNewAppID_returnZeroRecord()
        {
            //Arrange
            int expect = 0;
            var para = new { Operate = "GroupList", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "ZZZ" };
            //Act 
            var list = ManagePageList<GroupList, UserGroup>.GetList(_dataSource, _callMethod, para);


            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupListAppIDandSchoolCodebyMapCalss_returnAllGroupList()
        {
            //Arrange


            //Arrange
            var expect = "All School Students Group";
            var para = new { Operate = "GroupList", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC" };
            //Act 
            // var mapClass = new ActionApp<UserGroup>(new ActionAppUserGroup());
            var list = ManagePageList<GroupList, UserGroup>.GetList(_dataSource, _callMethod, para);

            var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group   . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupMemberStudentbyPara_returnMemberofStudent()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListStudent", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var list = ManagePageList<GroupList, UserGroupMemberStudent>.GetList(_dataSource, _callMethod, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupMemberStudentbyIDPassMapClass_returnMemberofStudent()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListStudent", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            //  var mapClass = new ActionApp<UserGroupMemberStudent>(new ActionAppUserGroupMemberS());
            var list = ManagePageList<GroupList, UserGroupMemberStudent>.GetList(_dataSource, _callMethod, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupMemberTeacherbyID_returnMemberofTeacher()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListTeacher", UserID = "tester", UserRole = "Admin", SchoolCode = "0354", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var list = ManagePageList<GroupList, UserGroupMemberTeacher>.GetList(_dataSource, _callMethod, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetList_GetUserGroupMemberTeacherbyIDPassMapClass_returnMemberofTeacher()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListTeacher", UserID = "tester", UserRole = "Admin", SchoolCode = "0354", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            //  var actionClass = new ActionApp<UserGroupMemberTeacher>(new ActionAppUserGroupMemberT());
            var list = ManagePageList<GroupList, UserGroupMemberTeacher>.GetList(_dataSource, _callMethod, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }

        [TestMethod()]
        public void GetList_StaffListbySurName_ReturnStaffListStartwithP()
        {
            // Arrange
            var para = new
            {
                Operate = "SecurityStaffList",
                UserID = "tester",
                UserRole = "admin",
                SchoolCode = "0000",
                SearchBy = "SurName",
                SearchValue = "Pas",
                Scope = "Board" // ddlType.SelectedValue
            };

            string expect = "Pas";

            //Act 
            var list = ManagePageList<StaffList, StaffList>.GetList(_dataSource, _callMethod, para);

            var result = from s in list
                         where s.LastName.Substring(0, 3) == para.SearchValue
                         select s.LastName;


            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault().Substring(0, 3), $" Geoup Member Student type  . ");

        }

        [TestMethod()]
        public void GetList_GetStaffDefaultSAPProfile_ReturnStaffSAPProfile()
        {
            // Arrange 
            var para = new
            {
                Operate = "SAP",
                UserID = "Tester",
                UserRole = "Test",
                SchoolCode = "0354",
                SchoolYear = "20212022",
                CPNum = "00051449"
            };

            string expect = "rodrigs03";

            //Act 

            var list = ManagePageList<StaffList, StaffMemberOf>.GetList(_dataSource, _callMethod, para);

            var result = from s in list
                         where s.CPNum == para.CPNum
                         select s.UserID;
            //Assert

            //    string checkResult  = list.FirstOrDefault(a => a.CPNum == para.CPNum)?.UserID;

            var checkResult = result.FirstOrDefault();
            Assert.AreEqual(expect, checkResult, $" Geoup Member Student type  . ");
        }
        [TestMethod()]
        public void GetList_GetStaffSISInformation_ReturnStaffSISClassInfo()
        {
            // Arrange 
            var para = new
            {
                Operate = "SIS",
                UserID = "Tester",
                UserRole = "Test",
                SchoolCode = "0354",
                SchoolYear = "20212022",
                CPNum = "00051449"
            };

            string expect = "04-05/1";

            //Act 

            var list = ManagePageList<ClassesList, StaffMemberOf>.GetList(_dataSource, _callMethod, para);

            var result = from s in list
                         where s.ClassCode == "04-05/1"
                         select s.ClassName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Geoup Member Student type  . ");
        }
        [TestMethod()]
        public void GetList_GetStaffAppGroupInfo_ReturnStaffAppGroupInof()
        {
            // Arrange 
            var para = new
            {
                Operate = "APP",
                UserID = "Tester",
                UserRole = "Test",
                SchoolCode = "0354",
                SchoolYear = "20202021",
                CPNum = "00050347"
            };

            string expect = "Grade 05 Students";

            //Act 

            var list = ManagePageList<GroupList, StaffMemberOf>.GetList(_dataSource, _callMethod, para);

            var result = from s in list
                         where s.MemberID == "05"
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Geoup Member Student type  . ");
        }

    }
}