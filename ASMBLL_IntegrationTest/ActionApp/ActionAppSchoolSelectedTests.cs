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
    public class ActionAppStaffWorkingSchoolsTests
    {
        private int _ids = 0;
        private StaffWorkingSchools _para = new StaffWorkingSchools();
        private readonly IActionApp<StaffWorkingSchools> _action = new ActionAppStaffWorkingSchools("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolYear = "20212022";
            _para.SchoolCode = "0354";
            _para.StaffUserID = "riccia";
        }

        [TestMethod()]
        public void GetSPName_ReturnReadSP_Test()
        {   //Arrange
            var action = "Read";
            var expect = "dbo.SIC_asm_AppStaffWorkingSchools_" + action;

            //Act
            string result = _action.GetSPName(action);

            //
            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void GetSPName_ReturnEditSP_Test()
        {
            //Arrange
            var action = "Edit";
            var expect = "dbo.SIC_asm_AppStaffWorkingSchools_" + action;

            //Act
            string result = _action.GetSPName(action);

            //
            Assert.AreEqual(expect, result);
        }


        [TestMethod()]
        public void GetObjList_StaffSchoolSelectedList_ReturnAllSchoolList_Test()
        {
            //Arrange
            int expect = 218;
            var para = new { Operate = "List", };
            //Act
            var result = _action.GetObjList(para);
            int count = result.Count;

            Assert.AreEqual(expect, count);
        }

        [TestMethod()]
        public void GetObjList_RangerStaffSchoolSelectedList_ReturnRangerSchoolList_Test()
        {
            //Arrange
            int expect = 52;
            var para = new { Operate = "ListbyRanger", UserID = "tester", UserRole = "admin", SchoolYear = "20212022", SchoolCode = "North" };
            //Act
            var result = _action.GetObjList(para);
            int count = result.Count;

            Assert.AreEqual(expect, count);
        }

        [TestMethod()]
        public void AddObj_AddSelectedSchoolToStaffWorkingSchoolList_ReturnSuccessfully_Test()
        {
            //Arrange
            var expect = "Successfully";
            int ids = 0;
            _para.Operate = "Edit";
            //Act 
            // var roleList = new List<AppRole> { _para };
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));
        }

        [TestMethod()]
        public void EditObjTest()
        {
            //Arrange
            PerpareForTest("Edit");
            var expect = "Successfully";
            _para.IDs = _ids.ToString();

            //Act 
            // var appRole = new List<AppRole> { _para };
            var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
            // _ids = int.Parse(result.Replace("Successfully", ""));
        }


        [TestMethod()]
        public void DeleteObjTest()
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
                _para.Operate = action;

                // var roleList = new List<AppRole> { _para };
                var result = _action.AddObj(_para).Replace("Successfully", "");
                _ids = int.Parse(result);
            }
            catch (Exception ex)
            {
                _ids = 0;
            }

        }
    }
}