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
    public class ManageFormSaveTests
    {
        private int _ids = 0;
        private UserGroup _para = new UserGroup();
        private readonly string _obj = typeof(UserGroup).Name;
        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0000";
            _para.AppID = "SIC";
            _para.GroupID = "UnitTestGroup";
            _para.GroupType = "School";
            _para.GroupName = "Unit Test New Group Name";
            _para.Permission = "Update";
            _para.IsActive = "X";
            _para.Comments = "Unit Test User Group Testing ";
        }

        [TestMethod()]
        public void SaveFormContent_AddNewUserGroup_ReturnSuccessfully()
        {
            var expect = "Successfully";
             var result = ManageFormSave<UserGroup>.SaveFormContent("Add", _obj, _para);
            Assert.AreEqual(expect, result.Substring(0,12), $"Add User Group action {result}" );
            _ids = int.Parse(result.Replace("Successfully", ""));
        }

        [TestMethod()]
        public void SaveFormContent_EditUserGroup_ReturnSuccessfully()
        {
            var expect = "Successfully";
            PerpareForTest("Add");
            var result = ManageFormSave<UserGroup>.SaveFormContent("Edit", _obj, _para);
            Assert.AreEqual(expect, result, $"Add User Group action {result}");
        }
        [TestMethod()]
        public void SaveFormContent_RemoveUserGroup_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
             var result = ManageFormSave<UserGroup>.SaveFormContent("Remove", _obj, _para);
            Assert.AreEqual(expect, result, $"Add User Group action {result}");
        }
        [TestMethod()]
        public void SaveFormContent_DeleteUserGroup_ReturnSuccessfully()
        {
            PerpareForTest("Add");

            var expect = "Successfully";
             var result = ManageFormSave<UserGroup>.DeleteFormContent(_ids, _obj, _para);
            Assert.AreEqual(expect, result, $"Add User Group action {result}");
        }
        [TestCleanup]
        public void TestCleanup()
        {
            try
            {
                ManageFormSave<UserGroup>.DeleteFormContent(_ids, _obj, _para);
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
                _para.IDs = "0";
                _para.GroupID = "UnitTestGroup_" + action;
                //  var pList = new List<UserGroup> { _para };
                var result = ManageFormSave<UserGroup>.SaveFormContent("Add", _obj, _para);
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