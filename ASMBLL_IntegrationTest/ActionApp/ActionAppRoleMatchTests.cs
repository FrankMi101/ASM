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
    public class ActionAppRoleMatchTests
    {
        private int _ids = 0;
        private AppRoleMatch _para = new AppRoleMatch();

        private readonly IActionApp<AppRoleMatch> _action = new ActionAppRoleMatch("SQL");
  

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.IDs = "0";
            _para.UserID = "tester";
            _para.AppID = "SIC";
            _para.RoleID = "UnitTester";
            _para.RoleType ="Other";
            _para.MatchRole = "APP";
            _para.MatchDesc = "199";
            _para.MatchScope = "School"; 
            _para.Comments = " Test purpose new unit test role testing";
        }

        // Test Method Name:
        // MethodName_Condition_Expectation

        [TestMethod()]
        public void GetSPName_Test()
        {
            //Arrange
            var expect = "dbo.SIC_asm_AppRoleMatch_Read";

            // act
            var actual = _action.GetSPName("Read");

            //Assert
            Assert.AreEqual(expect, actual, "");
        }

        [TestMethod()]
        public void GetObjList_TeacherRole_ReturnAllPositionDecrption_test()
        {
            //Arrange
            var expect = "School";
            var para = new { Operate = "GetList",UserID="tester",UserRole ="admin", RoleID="Teacher" ,RoleType= "PositionDesc" };

            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.MatchRole == "Teacher"
                         select s.MatchScope;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetObjList_AllRolebyRoleType_ReturnAllAppRoleListbyType()
        {
            //Arrange
            var expect = "Pending";
            var para = new { Operate = "GetList", UserID = "tester", UserRole = "admin", RoleID = "Other", RoleType = "PositionDesc" };

            //Act 
            var list = _action.GetObjList(para);

            var result = from s in list
                         where s.MatchRole == "Pending"
                         select s.MatchScope;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");


        }
        
        [TestMethod()]
        public void EditObj_MatchRoleWithPositionDescPending_ReturnSuccessafully()
        {
            //Arrange 
            var expect = "Successfully";
            var para = new AppRoleMatch()
            {
                Operate = "Edit",
                UserID = "tester",
                RoleID = "admin",
                RoleType = "PositionDesc",
                MatchDesc = "Msgr. Fraser Insturctor - Adult Ed.",
                MatchRole = "Teacher",
                MatchScope = "School"
            };
             
            //Act        
            var result = _action.EditObj(para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role  test {result} . ");
        }

        [TestMethod()]
        public void EditObj_MatchRoleWithPositionDescPending_ReturnInvalidMessage()
        {
            //Arrange
            var para = new AppRoleMatch()
            {
                Operate = "Edit",
                UserID = "tester",
                RoleID = "admin",
                RoleType = "PositionDesc",
                MatchDesc = "Msgr. Fraser Insturctor - Adult Ed. Not Exists Position Descrption",
                MatchRole = "Teacher",
                MatchScope = "School"
            };
            var expect = para.MatchDesc  +  " does not exist in the system";

            //Act        
            var result = _action.EditObj(para);

            //Assert
            Assert.AreEqual(expect, result, $" Update App role invailed role ID test {result} . ");
        }

       
        [TestCleanup]
        public void TestCleanup()
        {
            try
            { if (_ids != 0 )
                _action.DeleteObj(_ids);
            }
            catch (Exception)
            {
                throw;
            }
        }
 
    }
}