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
    public class ActionAppStaffWorkingRolesTests
    {
        private int _ids = 0;
        private StaffWorkingRoles _para = new StaffWorkingRoles();
        private readonly IActionApp<StaffWorkingRoles> _action = new ActionAppStaffWorkingRoles("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.StaffUserID = "bonavoj";
            _para.WorkingRole = "Section23";
            _para.StaffName = "Giuseppe Bonavota";
            _para.StartDate = "2021-09-01";
            _para.EndDate = "2022-06-30";
            _para.ActiveFlag = "x";
            _para.Comments = "Unit Test add usr to New App role test ";
        }

       
        [TestMethod()]
        public void GetObjByID_ReturnAppRolebyID_()
        {   //Arrange
            int ids = 166;
            string expect = "Teacher";

            //Act
            var list = _action.GetObjByID(ids);
            var result = from s in list
                         where s.IDs == ids.ToString()
                         select s.WorkingRole;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }

        [TestMethod()]
        public void AddObj_AddUserToNewRole_ReturnSuccessuflly_Test()
        {
            //Arrange
            var expect = "Successfully";
            _para.IDs = "0";
            _para.Operate = "Add";
            //Act    
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role Permission {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void EditObj_EditUserWorkingRole_ReturnSeccessfully_Test()
        {
            //Arrange
            PerpareForTest("Edit");
            _para.IDs = _ids.ToString();
            _para.Comments = "Test Edit App role";
            var expect = "Successfully";
            //Act 
            //  var roleList = new List<UserGroup> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Add New App role {result} . ");
        }

     
        [TestMethod()]
        public void DeleteObj_DeleteWorkingRole_ReturnSuccessfully_Test()
        {
            //Arrange
            PerpareForTest("Delete");
            var expect = "Successfully"; 

            //Act 
            var result = _action.DeleteObj(_ids);

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