using Microsoft.VisualStudio.TestTools.UnitTesting;
using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;

namespace ASMBLL.Tests
{
    [TestClass()]
    public class ActionAppServiceTests
    {
        private int _ids = 0;
       // private UserGroup _para = new UserGroup();
        //  private readonly IAction<UserGroup> _action = new ActionAppUserGroup();
        private readonly ActionAppService<UserGroup> _action = new ActionAppService<UserGroup>();
  

        [TestInitialize]
        

        [TestMethod()]
        public void GetObjList_GetUserGroupListbySchool_ReturnAllUserGroup()
        {
            //Arrange
            var expect = "Grade 05 Work Group";
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = "0354" };
            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group  {list.Count} . ");

        }
        [TestMethod()]
        public void GetObjList_GetAppUserGroupListbySchool_ReturnAllUserGroup_Test()
        {
            //Arrange
            var expect = "Grade 05 Work Group";
            var para = new { Operate = "GetListbyApp", UserID = "asm", UserRole = "admin", SchoolCode = "0354", AppID = "SIC" };
            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group  {list.Count} . ");

        }

        [TestMethod()]
        public void GetObjByID_GetaUserGroupByID_ReturnSignalRecord_Test()
        {
            //Arrange
            var expect = "Primary Student Work group";
            int ids = 99;

            //Act 
            var list = _action.GetObjByID(ids);

            //Assert
            Assert.AreEqual(expect, list[0].GroupID, $" User work groyp  items count {list[0].GroupID } . ");

        }

        [TestMethod()]
        public void AddObj_AddNewUserGroup_ReturnSuccessfully_Test()
        {
            //Arrange
            var para = new
            {
                Operate = "Add",
                UserID = "tester",
                IDs = "0",
                SchoolCode = "0354",
                AppID = "SIC",
                GroupID = "UnitTestGroup-Add",
                GroupType = "School",
                GroupName = "Unit Test New Group Name",
                Permission = "Update",
                IsActive = "X",
                Comments = "Unit Test User Group Testing "
            };
            var expect = "Successfully";
            
            //Act 
  
            var result = _action.AddObj(para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void AddObj_TrytoAddExistUserGroupInSameSchool_RetrunMessage_Test()
        {
            //Arrange
            
            object para = GetPerpareForTestObj("Add");
            var expect = "Group name";

            //Act 
            //  var roleList = new List<UserGroup> { _para };
            var result = _action.AddObj(para);

            //Assert
            StringAssert.Contains(result, expect, $" Add New App role {result}  ");

        }
        [TestMethod()]
        public void EditObj_UpdateUserGroupRecord_Test()
        {
            //Arrange
            var expect = "Successfully";
            object para = GetPerpareForTestObj("Edit");

            //Act 
            //  var appRole = new List<UserGroup> { _para };
            var result = _action.EditObj(para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteUserGroup_Test()
        {
            //Arrange
            object para = GetPerpareForTestObj("Delete");
            var expect = "Successfully";

            //Act 
            var result = _action.DeleteObj(_ids);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteUserGroupNotExist_ReturnNotExistsMessage()
        {
            //Arrange
 
            var expect = "Group name " + "9999" + " does not exists in the system";
            //Act 
            var result = _action.DeleteObj(9999);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }
        [TestCleanup]
        public void TestCleanup()
        {
            try
            {
                _action.DeleteObj(_ids);
            }
            catch (Exception)
            {
                throw;
            }
        }
        private object GetPerpareForTestObj(string action) {
            try
            {
                var testObj = new
                {
                    Operate = "Add",
                    UserID = "tester",
                    IDs = "0",
                    SchoolCode = "0354",
                    AppID = "SIC",
                    GroupID = "UnitTestGroup " + action,
                    GroupType = "School",
                    GroupName = "Unit Test New Group Name",
                    Permission = "Update",
                    IsActive = "X",
                    Comments = "Unit Test User Group Testing "
                };
                //  var pList = new List<UserGroup> { _para };
                var result = _action.AddObj(testObj).Replace("Successfully", "");
                _ids = int.Parse(result);
                var newObj = new
                {
                    Operate = action,
                    UserID = "tester",
                    IDs = result,
                    SchoolCode = "0354",
                    AppID = "SIC",
                    GroupID = "UnitTestGroup " + action,
                    GroupType = "School",
                    GroupName = "Unit Test New Group Name",
                    Permission = "Read",
                    IsActive = "X",
                    Comments = "Unit Test User Group Testing " + action +  " new update"
                };
                return newObj;
            }
            catch (Exception)
            {
                return null;
            }
        }
 
    }
}