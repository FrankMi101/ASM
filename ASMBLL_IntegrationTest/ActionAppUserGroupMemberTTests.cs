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
    public class ActionAppUserGroupMemberTTests
    {
        private int _ids = 0;
        private UserGroupMemberTeacher _para = new UserGroupMemberTeacher();
        //  private readonly IAction<UserGroup> _action = new ActionAppUserGroup();
        private readonly IActionApp<UserGroupMemberTeacher> _action =new ActionAppUserGroupMemberT("SQL");
      //  private readonly IGet<UserGroupMember> _get = new ActionGet<UserGroupMember>(new ActionAppUserGroupMemberT());


        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "Junior Students Work Group";
            _para.MemberID = "testID";
            _para.StartDate = "2020/09/01";
            _para.EndDate = "2021/06/30";
            _para.Comments = "Unit Test Add Grade 05 to School user Group Testing ";
        }

        [TestMethod()]
        public void GetObjList_GetUserGroupMemberListbyGroupID_ReturnAllUserGroupMember()
        {
            //Arrange
            int expect = 2;
            var para = new { Operate = "GetMemberListbyGroup", UserID = "asm", UserRole = "admin", SchoolCode = "0000", AppID = "SIC", GroupID = "All Board Schools" };

            //Act 
            var list = _action.GetObjList(para);

            //Assert
            Assert.AreEqual(expect, list.Count, $" User work Group  {list.Count} . ");

        }

        [TestMethod()]
        public void GetObjList_GetUserGroupMemberListbyMemberID_ReturnGroupMemberRecord()
        {
            //Arrange
            var expect = "landac";
            var para = new { Operate = "GetMember", UserID = "asm", UserRole = "admin", SchoolCode = "0000", AppID = "SIC", GroupID = "All Board Schools", MemberID = "landac" };

            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.MemberID == "landac"
                         select s.MemberID;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group Member {list.Count} . ");

        }



        [TestMethod()]
        public void AddObj_AddNewMemberToUserGroup_ReturnSuccessfully()
        {
            //Arrange
            var expect = "Successfully";

            //Act 
           // var roleList = new List<UserGroupMember> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void AddObj_TrytoAddExistMemberToGroup_RetrunExistsMessage()
        {
            //Arrange
            PerpareForTest("Add");
            var expect = "Group member " + _para.MemberID + " exists in the system already";

            //Act 
          //  var roleList = new List<UserGroupMember> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role {result} . ");

        }
        [TestMethod()]
        public void EditObj_UpdateUserGroupMemberRecord_ReturnSuccessfully()
        {
            //Arrange
            var expect = "Successfully";
            PerpareForTest("Edit");
            _para.Comments = "Update app role testing in 34 id ";

            //Act 
            // appRole = new List<UserGroupMember> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void RemoveObj_DeleteGroupMember_ReturnSuccessfully()
        {
            //Arrange
            PerpareForTest("Remove");
            var expect = "Successfully";

            //Act 
           // var appRole = new List<UserGroupMember> { _para };
            var result = _action.RemoveObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }


        [TestMethod()]
        public void DeleteObj_DeleteUserGroupMember_ReturnSeccessfully()
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

            var expect = "Group member " + "9999" + " does not exists in the system";
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
                _para.GroupID = "Junior Students Work Group";
                _para.MemberID = "testerID";
               // var pList = new List<UserGroupMember> { _para };
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