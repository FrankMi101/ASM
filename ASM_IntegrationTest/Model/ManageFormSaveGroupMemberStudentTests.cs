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
    public class ManageFormSaveGroupMemberStudentTests
    {
        private int _ids = 0;
        private UserGroupMemberStudent _para = new UserGroupMemberStudent();
        private readonly string _obj = "UserGroupStudent";
        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "Junior Students Work Group";
            _para.GroupType = "Grade";
            _para.MemberID = "06";  
            _para.StartDate = "2020-09-01";
            _para.EndDate = "2021-06-30";
            _para.Comments = "Unit Test User Group Student Member Testing ";
        }
        [TestMethod()]
        public void SaveFormContent_AddNewStudentGroupMember_ReturnSuccessfully()
        {
            // Arrange
            _para.Operate = "Add";
            var expect = "Successfully";
          //  PerpareForTest("Add");

            //Act
            var result = ManageFormSave<UserGroupMemberStudent>.SaveFormContent("Add", _obj, _para);

            var id = result.Replace("Successfully", "");
            _para.IDs = id;
            _ids = int.Parse(id);
            //Assert
            StringAssert.Contains(result,  expect,  $"Add User Group student member action {result}");
        }
        [TestMethod()]
        public void SaveFormContent_UpdateStudentGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");
            _para.Comments = _para + " Update Student group member test";
            var expect = "Successfully";
            var result = ManageFormSave<UserGroupMemberStudent>.SaveFormContent("Edit", _obj, _para);
            Assert.AreEqual(expect, result, $"Edit User Group student member action {result}");
        }

        [TestMethod()]
        public void SaveFormContent_RemoveStudentGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
            var result = ManageFormSave<UserGroupMemberStudent>.SaveFormContent("Remove", _obj, _para);
            Assert.AreEqual(expect, result, $"Remove User Group student member action {result}");
        }

        [TestMethod()]
        public void SaveFormContent_DeleteStudentGroupMember_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
            var result = ManageFormSave<UserGroupMemberStudent>.DeleteFormContent(_ids, _obj, _para);
            Assert.AreEqual(expect, result, $"Delete User Group Student Member action {result}");
        }
        [TestCleanup]
        public void TestCleanup()
        {
            try
            {
                ManageFormSave<UserGroupMemberStudent>.DeleteFormContent(_ids, _obj, _para);
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
                var result = ManageFormSave<UserGroupMemberStudent>.SaveFormContent("Add", _obj, _para);
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