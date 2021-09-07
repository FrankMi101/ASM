using Microsoft.VisualStudio.TestTools.UnitTesting;
using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;
using ASMBLL_IntegrationTest;

namespace ASMBLL.Tests
{
    [TestClass()]
    public class ActionAppRoleTests
    {
        private int _ids = 0;
        private AppRole _para = new AppRole();
        //private readonly ActionAppRole   _action = new ActionAppRole();
        private readonly IActionApp<AppRole> _action = new ActionAppRole("SQL");
       // private readonly IGet<AppRole> _get = new ActionGet<AppRole>(new ActionAppRole());
        //  private readonly IAction<AppRole> _action = new FakeAppAction<AppRole>(new ActionAppRole());


        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.IDs = "0";
            _para.UserID = "tester";
            _para.AppID = "SIC";
            _para.RoleID = "UnitTester";
            _para.RoleName = "Test User Group for Unit Tester";
            _para.RoleType = "APP";
            _para.RolePriority = "199";
            _para.AccessScope = "School";
            _para.Permission = "Update";
            _para.Comments = " Test purpose new unit test role testing";
        }

        // Test Method Name:
        // MethodName_Condition_Expectation

        [TestMethod()]
        public void GetSPNameTest()
        {
            //Arrange
            var expect = "dbo.SIC_asm_AppRole_Read";
            
            // act
            var actual = _action.GetSPName("Read");

            //Assert
            Assert.AreEqual(expect, actual,"");
        }

        [TestMethod()]
        public void GetObjList_All_ReturnAllAppRoleListItem()
        {
            //Arrange
            var expect = "Application Admin";
            var para = new { Operate = "GetListAll" };

            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.RoleID == "Admin"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetObjList_AllRolebyRoleType_ReturnAllAppRoleListbyType()
        {
            //Arrange
            var expect = "Special Education Teacher";
            var para = new { Operate = "GetListbyType", IDs = "0", UserID = "tester", UserRole = "admin", RoleType = "SAP" };

            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.RoleID == "SeTeacher"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }
        [TestMethod()]
        public void GetObjList_byRoleID_ReturnOneAppRoleRecord()
        {
            //Arrange
            var expect = "Application Other Role";
            var para = new { Operate = "GetListbyRoleID", IDs = "0", UserID = "tester", UserRole = "admin", RoleType = "", RoleID = "AppOther" };
            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.RoleID == "AppOther"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" App role list has items count {list.Count} . ");

        }
        [TestMethod()]
        public void GetObjByID_GetAppRoleByID_ReturnSignalAppRole()
        {
            //Arrange
            var expect = "Application Other Role";
            int ids = 31;
            //Act 
            var list = _action.GetObjByID(ids);

            //Assert
            Assert.AreEqual(expect, list[0].RoleName, $" Application role item by id has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetObjByID_GetAppRoleByInvaildID_ReturnNull()
        {
            //Arrange
            var expect = "";
            int ids = 0;
            //Act 
            var list = _action.GetObjByID(ids);

            //Assert
            Assert.IsNull(list, $" No Application role return ");

        }

        [TestMethod()]
        public void AddObj_AddNewAppRole_ReturnSuccessfully()
        {
            //Arrange
            var expect = "Successfully";
            int ids = 0;
            //Act 
            // var roleList = new List<AppRole> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));
        }

        [TestMethod()]
        public void AddObj_AddNewAppRolebutRoleIDisNull_ReturnInvailedRoleIDMessage()
        {
            //Arrange
            var expect = "Invalid Role ID";
            int ids = 0;
            _para.RoleID = null;
            //Act 
            // var roleList = new List<AppRole> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role by Null Role ID {result} . ");

        }
        [TestMethod()]
        public void AddObj_AddNewAppRolebutRoleIDisBlank_ReturnInvailedRoleIDMessage()
        {
            //Arrange
            var expect = "Invalid Role ID";
            int ids = 0;
            _para.RoleID = "";
            //Act 
            // var roleList = new List<AppRole> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role by Null Role ID {result} . ");

        }
        [TestMethod()]
        public void AddObj_TrytoAddExistAppRoleNewRecord_ReturnMessage()
        {
            //Arrange
            PerpareForTest("Add");
            var expect = "Role name " + _para.RoleID + " exists in the system already";

            //Act 
            //  var roleList = new List<AppRole> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role {result} . ");

        }
        [TestMethod()]
        public void EditObj_UpdateAppRoleRecord_ReturnSuccessafully()
        {
            //Arrange
            PerpareForTest("Edit");
            var expect = "Successfully";
            _para.IDs = _ids.ToString();
            _para.Comments = "Unit Test Role for Edit role testing";

            //Act 
            // var appRole = new List<AppRole> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }
        [TestMethod()]
        public void EditObj_UpdateAppRoleRecordbyNullRoleID_ReturnInvalidMessage()
        {
            //Arrange
            var expect = "Invalid Role ID";
            _para.IDs = "0";
            _para.RoleID = null;
            _para.Comments = "Update app role testing in 34 id ";

            //Act 
            // appRole = new List<AppRole> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role invailed role ID test {result} . ");
        }

        [TestMethod()]
        public void RemoveObj_DeleteRolebyToleID_ReturnSuccessfully()
        {
            //Arrange
            PerpareForTest("Remove");
            var expect = "Successfully";

            //Act 
            ///  var appRole = new List<AppRole> { _para };
            var result = _action.RemoveObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteAppRoleRecord_ReturnSuccessfully()
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
        public void DeleteObj_DeleteAppRoleRecordNoExist_ReturnNotExistMessage()
        {
            //Arrange
            int id = 999;
            var expect = "Role name " + id + " does not exists in the system"; // "There is no such role named " + "39" + " In the system' as rValue";

            //Act 
            var result = _action.DeleteObj(id);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }
        [TestMethod()]
        public void DeleteObj_DeleteAppRolebyZeroID_ReturnInvalidMessage()
        {
            //Arrange

            var expect = "Invalid Role ID"; // "There is no such role named " + "39" + " In the system' as rValue";
                                            //Act 
            var result = _action.DeleteObj(0);

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
                _para.RoleID = "UnitTester_" + action;
                // var roleList = new List<AppRole> { _para };
                var result = _action.AddObj(_para).Replace("Successfully", "");
                _ids = int.Parse(result);
            }
            catch (Exception)
            {
                _ids = 0;
            }

        }

     
    }
}