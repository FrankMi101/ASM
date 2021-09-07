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
    public class ActionAppRolePermissionTests
    {
        private int _ids = 0;
        private AppRolePermission _para = new AppRolePermission();
        private readonly IActionApp<AppRolePermission> _action = new ActionAppRolePermission("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.AppID = "TPA";
            _para.RoleID = "ITFTeacher";
            _para.ModelID = "SignOff";
            _para.RoleType = "SAP";
            _para.Permission = "Update";
            _para.AccessScope = "School";
            _para.Comments = "Unit Test App role permission Testing ";
 

        }

        [TestMethod()]
        public void GetSPName_Return_ReadActionSPName_Test()
        {
            // Arrange
            string expect = "dbo.SIC_asm_AppRolePermission_Read";
            //Act
           
            var result = _action.GetSPName("Read");
            //Assert
            Assert.AreEqual(expect , result,$" test {result} ") ;
        }
        [TestMethod()]
        public void GetSPName_Return_EditActionSPName_Test()
        {
            // Arrange
            string expect = "dbo.SIC_asm_AppRolePermission_Edit";
            //Act

            var result = _action.GetSPName("Edit");
            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");
        }


        [TestMethod()]
        public void GetObjList_byRoleID_ReturnAppRolePermissionList_Test()
        {
            // Arrange
            var para = new { Operate = "GetListbyRoleID", UserID = "tester", UserRole = "admin", RoleID = "ITFTeacher", RoleType = "SAP" };

            string expect = "School Information Center";
            //Act
            var list = _action.GetObjList(para);
            var result = from s in list
                         where s.AppID == "SIC"
                         select s.AppName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");
        }

        [TestMethod()]
        public void GetObjByID_ReturnAppRolePermissionbyID_Test()
        {
            // Arrange
         //   var para = new { Operate = "GetListbyRoleID", UserID = "tester", UserRole = "admin", RoleID = "ITFTeacher", RoleType = "SAP" };
            int ids = 20;
            string expect = "Gift/ ITF Teacher";
            //Act
            var list = _action.GetObjByID(ids);

            var result = from s in list
                         where s.AppID == "SIC"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");
        }
        [TestMethod()]
        public void AddObj_AddNewRolePermission_ReturnSuccessfully_Test()
        {
            //Arrange
            var expect = "Successfully";

            //Act    
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role Permission {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void AddObj_TrytoAddExistRolePermission_RetrunMessage_Test()
        {
            //Arrange
            PerpareForTest("Add");
            var expect = "Role Permission " + _para.RoleID + " in " +  _para.AppID + " exists in the system already";

            //Act 
            //  var roleList = new List<UserGroup> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role {result} . ");

        }
        [TestMethod()]
        public void EditObj_UpdateRolePermission_ReturnSuccessfuley_Test()
        {
            //Arrange
            var expect = "Successfully";
            PerpareForTest("Edit");
            _para.Comments = "Update role permission app role testing in 34 id ";

            //Act 
            //  var appRole = new List<UserGroup> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteRolePermission_Test()
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
        public void DeleteObj_DeleteRolePermissionNotExist_ReturnNotExistsMessage()
        {
            //Arrange
            int id = 9999;
            var expect = "There is no Role Permission setup for IDs " + id.ToString();
            //Act 
            var result = _action.DeleteObj(id);

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