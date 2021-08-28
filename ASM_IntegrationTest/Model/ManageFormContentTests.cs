using Microsoft.VisualStudio.TestTools.UnitTesting;
using ASM;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;
using ASMBLL;

namespace ASM.Tests
{
    [TestClass()]
    public class ManageFormContentTests
    {

        private UserGroup _para = new UserGroup();

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "UnitTestGroup";
            _para.GroupType = "School";
            _para.GroupName = "Unit Test New Group Name";
            _para.Permission = "Update";
            _para.IsActive = "X";
            _para.Comments = "Unit Test User Group Testing ";
        }

        [TestMethod()]
        public void GetListbyID_GetUserGroupContentbyID_returnID28UserGroup()
        {
            //Arrange
            var expect = "All Board Schools";
            int para = 28; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var list = ManageFormContent<UserGroup>.GetListbyID("UserGroup", para);

            var result = list[0].GroupID;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupContentbyID_returnList()
        {
            //Arrange
            var expect = "All Board Schools";
            int para = 28; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var list = ManageFormContent<UserGroup>.GetListbyID("UserGroup", para);

            var result = list[0].GroupID;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupContentbyIDPassMapClass_returnZeroRecordCount()
        {
            //Arrange
            int expect = 0;
            int para = 9999; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var actionClass =  new ActionAppUserGroup();
            var list = ManageFormContent<UserGroup>.GetListbyID(actionClass, para);

            var result = list.Count;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupMemberStudentbyID_returnMemberofStudent()
        {
            //Arrange
            string expect = "0000";
            int para = 6932; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var list = ManageFormContent<UserGroupMemberStudent>.GetListbyID("UserGroupStudent", para);

            var result = list[0].MemberID;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupMemberStudentbyIDPassMapClass_returnMemberofStudent()
        {
            //Arrange
            string expect = "0000";
            int para = 6932; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var actionClass = new ActionAppUserGroupMemberS();
            var list = ManageFormContent<UserGroupMemberStudent>.GetListbyID(actionClass, para);

            var result = list[0].MemberID;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupMemberTeacherbyID_returnMemberofTeacher()
        {
            //Arrange
            string expect = "felicid";
            int para = 5130; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var list = ManageFormContent<UserGroupMemberTeacher>.GetListbyID("UserGroupTeacher", para);

            var result = list[0].MemberID;

            //Assert
            Assert.AreEqual(expect, result, $" Geoup Member Student type  . ");

        }
        [TestMethod()]
        public void GetListbyID_GetUserGroupMemberTeacherbyIDPassMapClass_returnMemberofTeacher()
        {
            //Arrange
            string expect = "felicid";
            int para = 5130; // new { Operate = "Get", UserID = "asm", IDs = "28" };
            //Act 
            var actionClass = new ActionAppUserGroupMemberT();
            var list = ManageFormContent<UserGroupMemberTeacher>.GetListbyID(actionClass, para);

            var result = list[0].MemberID;

            //Assert
            Assert.AreEqual(expect, result, $" User work Group   . ");

        }
 
    }
}