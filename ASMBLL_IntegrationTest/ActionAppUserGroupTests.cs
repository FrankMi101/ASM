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
    public class ActionAppUserGroupTests
    {
        private int _ids = 0;
        private UserGroup _para = new UserGroup();
        //  private readonly IAction<UserGroup> _action = new ActionAppUserGroup();
        private readonly ActionApp<UserGroup> _action = new ActionApp<UserGroup>(new ActionAppUserGroup());
      //  private readonly IGet<UserGroup> _get = new ActionGet<UserGroup>(new ActionAppUserGroup());
        //  private readonly IAction<UserGroup> _action = new FakeAppAction<UserGroup>(new ActionAppUserGroup());


        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
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
            var expect = "Successfully";
       
            //Act 
           // var roleList = new List<UserGroup> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void AddObj_TrytoAddExistUserGroupInSameSchool_RetrunMessage_Test()
        {
            //Arrange
            PerpareForTest("Add");
            var expect = "Group name " + _para.GroupID + " exists in the system already";

            //Act 
          //  var roleList = new List<UserGroup> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role {result} . ");

        }
        [TestMethod()]
        public void EditObj_UpdateUserGroupRecord_Test()
        {
            //Arrange
            var expect = "Successfully";
            PerpareForTest("Edit");
            _para.Comments = "Update app role testing in 34 id ";

            //Act 
          //  var appRole = new List<UserGroup> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteUserGroup_Test()
        {
            //Arrange
            PerpareForTest("Delete");
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

        private void PerpareForTest(string action)
        {
            try
            {
                _para.IDs = "0";
                _para.GroupID = "UnitTestGroup_" + action;
              //  var pList = new List<UserGroup> { _para };
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
