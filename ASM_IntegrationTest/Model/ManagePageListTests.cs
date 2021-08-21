using ASMBLL;
using ClassLibrary;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;

namespace ASM.Tests
{
    [TestClass()]
    public class ManagePageListTests
    {
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
            var list = ManagePageList<GroupList, UserGroup>.GetList("UserGroup", para);


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
            var list = ManagePageList<GroupList, UserGroup>.GetList("UserGroup", para);


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
            var mapClass = new ActionApp<UserGroup>(new ActionAppUserGroup());
            var list = ManagePageList<GroupList, UserGroup>.GetList(mapClass, para);

            var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListby_GetUserGroupMemberStudentbyPara_returnMemberofStudent()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListStudent", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var list = ManagePageList<GroupList, UserGroupMemberStudent>.GetList("UserGroupStudent", para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupMemberStudentbyIDPassMapClass_returnMemberofStudent()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListStudent", UserID = "tester", UserRole = "Admin", SchoolCode = "0000", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var mapClass = new ActionApp<UserGroupMemberStudent>(new ActionAppUserGroupMemberS());
            var list = ManagePageList<GroupList, UserGroupMemberStudent>.GetList(mapClass, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListby_GetUserGroupMemberTeacherbyID_returnMemberofTeacher()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListTeacher", UserID = "tester", UserRole = "Admin", SchoolCode = "0354", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var list = ManagePageList<GroupList, UserGroupMemberTeacher>.GetList("UserGroupTeacher", para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetListby_GetUserGroupMemberTeacherbyIDPassMapClass_returnMemberofTeacher()
        {
            //Arrange
            int expect = 3;
            var para = new { Operate = "GroupListTeacher", UserID = "tester", UserRole = "Admin", SchoolCode = "0354", AppID = "SIC", GroupID = "Primary Student Work group" };
            //Act 
            var actionClass = new ActionApp<UserGroupMemberTeacher>(new ActionAppUserGroupMemberT());
            var list = ManagePageList<GroupList, UserGroupMemberTeacher>.GetList(actionClass, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }

        [TestMethod()]
        public void GetList_StaffListbySurName_ReturnStaffListStartwithP()
        {
            // Arrange
            var para  = new
            {
                Operate = "SecurityStaffList",
                UserID ="tester",
                UserRole = "admin",
                SchoolCode = "0000",
                SearchBy = "SurName",
                SearchValue = "Pas",
                Scope = "Board" // ddlType.SelectedValue
            };

            string expect = "Pas";

             //Act 
            var list = ManagePageList<StaffList, StaffListSearch>.GetList("StaffListSearch", para);

            var result = from s in list
                         where s.LastName.Substring(0,3) == para.SearchValue
                         select s.LastName;

 
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault().Substring(0,3), $" Geoup Member Student type  . ");
 
        }

        [TestMethod()]
        public void GetListbyT2_GetStaffDefaultSAPProfile_ReturnStaffSAPProfile()
        {
            // Arrange 
            var para = new
            {
                Operate = "SAP",
                UserID ="Tester",
                UserRole = "Test",
                SchoolYear = "20202021",
                SchoolCode = "0000",
                CPNum = ""
            };

            string expect = "Pas";

            //Act 
            
            var list = ManagePageList<StaffList, StaffMemberOf>.GetListbyT2(para.Operate, para);

            var result = from s in list
                         where s.CPNum == para.CPNum
                         select s.FirstName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault().Substring(0, 3), $" Geoup Member Student type  . ");
        }
        [TestMethod()]
        public void GetListbyT2_GetStaffSISInformation_ReturnStaffSISClassInfo()
        {
            // Arrange 
            var para = new
            {
                Operate = "SIS",
                UserID = "Tester",
                UserRole = "Test",
                SchoolYear = "20202021",
                SchoolCode = "0000",
                CPNum = ""
            };

            string expect = "ClassName";

            //Act 

            var list = ManagePageList<ClassesList, StaffMemberOf>.GetListbyT2(para.Operate, para);

            var result = from s in list
                         where s.ClassCode == "MEM4D1"
                         select s.ClassName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault().Substring(0, 3), $" Geoup Member Student type  . ");
        }
        [TestMethod()]
        public void GetListbyT2_GetStaffAppGroupInfo_ReturnStaffAppGroupInof()
        {
            // Arrange 
            var para = new
            {
                Operate = "APP",
                UserID = "Tester",
                UserRole = "Test",
                SchoolYear = "20202021",
                SchoolCode = "0000",
                CPNum = ""
            };

            string expect = "Pas";

            //Act 

            var list = ManagePageList<GroupList, StaffMemberOf>.GetListbyT2(para.Operate, para);

            var result = from s in list
                         where s.GroupID  == ""
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault().Substring(0, 3), $" Geoup Member Student type  . ");
        }
    }
}