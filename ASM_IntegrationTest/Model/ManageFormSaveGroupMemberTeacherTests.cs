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
    public class ManageFormSaveGroupMemberTeacherTests
    {
        private int _ids = 0;
        private UserGroupMemberTeacher _para = new UserGroupMemberTeacher();
        private readonly string _obj = "UserGroupTeacher";
        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "Grade 05 Work Group";
            _para.MemberID = "rodrigs03"; // 00051449
            _para.Comments = "Unit Test User Group Teacher Member Testing ";
            _para.StartDate = "2020-09-01";
            _para.EndDate = "2021-06-30";
        }
        [TestMethod()]
        public void SaveFormContent_AddNewTeacherGroupMember_ReturnSuccessfully()
        {
            // Arrange
            _para.Operate ="Add";
            var expect = "Successfully";
             
            //Act
           var  result = ManageFormSave<UserGroupMemberTeacher>.SaveFormContent("Add", _obj, _para);

            var id = result.Replace("Successfully", "");
            _para.IDs = id;
            _ids = int.Parse(id);
            //Assert
            StringAssert.Contains(result, expect, $"Add User Group teacher member action {result}");
        }
        [TestMethod()]
        public void SaveFormContent_UpdateTeacherGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
            var result = ManageFormSave<UserGroupMemberTeacher>.SaveFormContent("Edit", _obj, _para);
            Assert.AreEqual(expect, result, $"Edit User Group teacher member  action {result}");
        }

        [TestMethod()]
        public void SaveFormContent_RemoveTeacherGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
             var result = ManageFormSave<UserGroupMemberTeacher>.SaveFormContent("Remove", _obj, _para);
            Assert.AreEqual(expect, result, $"Remove User Group  teacher member action {result}");
        }
        [TestMethod()]
        public void SaveFormContent_DeleteTeacherGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
             var result = ManageFormSave<UserGroupMemberTeacher>.DeleteFormContent(_ids, _obj, _para);
            Assert.AreEqual(expect, result, $"Delete User Group teacher member  action {result}");
        }
        [TestCleanup]
        public void TestCleanup()
        {
            try
            {
                ManageFormSave<UserGroupMemberTeacher>.DeleteFormContent(_ids, _obj, _para);
            }
            catch (Exception)
            {
                throw;
            }
        }

        private void PerpareForTest(string action)
        {
            try
            {
                _para.Operate = action;
                _para.IDs = "0";
                //_para.GroupID = "UnitTestGroup_" + action;
                //  var pList = new List<UserGroup> { _para };
                var result = ManageFormSave<UserGroupMemberTeacher>.SaveFormContent("Add", _obj, _para);
                var id = result.Replace("Successfully", "");
                _para.IDs = id;
                _ids = int.Parse(id);
            }
            catch (Exception)
            {
                _ids = 0;
            }

        }

    }
}