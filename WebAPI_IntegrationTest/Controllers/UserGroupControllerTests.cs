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
    public class UserGroupControllerTests
    {
         private int _ids = 0;
        private UserGroup _para = new UserGroup();
        private readonly IActionApp<UserGroup> _action = new ActionAppUserGroup("SQL");

        private readonly ActionAppUserGroup _apiAction = new ActionAppUserGroup("API");

        [TestInitialize]
        public void Setup()
        {
            _para.Operate = "Get";
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
        public void GetAllUserGroupbySchool_ReturnAllGroupList_Test()
        {
            // Arrange 
            string uri = "usergroup/list";
             string qStr = "/0354"; 
            var expect = "All School Students Group";

            //Act 
            var list = _apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetUserGoupListbySchoolandApp_ReturnAllUserSchoolGroupList_Test()
        {
            //Arrange
            string uri = "usergroup/list";
            string qStr = "/0354/SIC";
            var expect = "All School Students Group";

            //Act  
            var list = _apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetUserGroyupbyID_ReturnUserGroup_Test()
        {
            //Arrange
            var expect = "All School Students Group";
 
            string uri = "usergroup/";
            int qStr = 1;

            //Act 
            var list = _apiAction.GetObjByID(uri, qStr);

             var result = from s in list
                         where s.GroupID == "All Students Work Group"
                         select s.GroupName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void Post_AddNewUserGroup_Test()
        {
            // Arrange 
            string uri = "usergroup";
            var expect = "Successfully";
            _para.IDs = "0";
            _para.Operate = "Add";
            _para.UserID = "API_Add_Test_UserGroup";

            //Act
           // var apiAction = new ActionAppsUserGroup("API");
            var result = _apiAction.AddObj("Add", uri, _para);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" User  Group  contain {result} ");
 
        }

        [TestMethod()]
        public void Put_EditUserGroup_Test()
        {
            // Arrange 
            PerpareForTest("Edit");
            string uri = "usergroup";
            var expect = "Successfully";
            _para.IDs = _ids.ToString();
            _para.Operate = "Edit";
            _para.Comments = "Unit Test from WEb APi Call";

            //Act
             var result = _apiAction.EditObj("Edit", uri, _para);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" App Model contain {result} ");
        }

        [TestMethod()]
        public void Delete_DeleteUserGroupbyID_Test()
        {
            // Arrange 
            PerpareForTest("Delete");
            string uri = "usergroup";
            var expect = "Successfully";

            //Act
             var result = _apiAction.DeleteObj("Delete", uri, _ids);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" App Model contain {result} ");
        }

        [TestCleanup]
        public void TestCleanup()
        {
            try
            {
                if (_ids != 0 )
                    _action.DeleteObj(_ids);
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
                var result = _action.AddObj(_para).Replace("Successfully", "");
                _para.IDs = result;
                _ids = int.Parse(result);
            }
            catch (Exception)
            {
                _ids = 0;
            }
        }
    }
}