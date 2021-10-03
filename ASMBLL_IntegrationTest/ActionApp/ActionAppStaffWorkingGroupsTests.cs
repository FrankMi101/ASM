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
    public class ActionAppStaffWorkingGroupsTests
    {
        private int _ids = 0;
        private StaffWorkingGroups _para = new StaffWorkingGroups();
        private readonly IActionApp<StaffWorkingGroups> _action = new ActionAppStaffWorkingGroups("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "Grade 3/4 Work Group";
            _para.MemberID = "bonavoj";
            _para.StartDate = "2021-09-01";
            _para.EndDate = "2022-06-30";
             _para.Comments = "Unit Test add usr to New App Group test ";
        }


        [TestMethod()]
        public void GetObjByID_ReturnAppGroupbyID_()
        {   //Arrange
            int ids = 5163;
            string expect = "bonavoj";

            //Act
            var list = _action.GetObjByID(ids);
            var result = from s in list
                         where s.IDs == ids.ToString()
                         select s.MemberID;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }

        [TestMethod()]
        public void AddObj_AddUserToNewGRoup_ReturnSuccessuflly_Test()
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
        public void EditObj_EditUserWorkingGRoup_ReturnSeccessfully_Test()
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
        public void DeleteObj_DeleteWorkingGroup_ReturnSuccessfully_Test()
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