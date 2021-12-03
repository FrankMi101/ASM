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
    public class ActionAppAppsTests
    {
        private int _ids = 0;
        private Apps _para = new Apps();
        private readonly IActionApp<Apps> _action = new ActionApps("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.AppID = "IEP2";
            _para.AppName = "Individual Education Plan 2";
            _para.Owners = "IEP Committee";
            _para.Developer = "Frank Mi";
            _para.ActiveFlag = true;
            _para.AppUrl = "Https://web.tcdsb.org/IEP";
            _para.AppUrlTest = "Https://web.tcdsb.org/QA/IEP";
            _para.AppUrlTrain = "Https://web.tcdsb.org/QT/IEP";
            _para.StartDate = "2021-09-01"; 
            _para.Comments = "Unit Test add new Appstest ";

        }

        [TestMethod()]
        public void GetObjList_ReturnAppList_Test()
        {   //Arrange
            string expect = "School Information Center";
            var para = new { Operate = "GetList", UserID = "asm", IDs = "0", UserRole = "admin" };

            //Act
            var list = _action.GetObjList(para);
            var result = from s in list
                         where s.AppID == "SIC"
                         select s.AppName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }

        [TestMethod()]
        public void GetObjByID_ReturnAppNamebyID_Test()
        {   //Arrange
            int ids = 1;
            string expect = "IEP";

            //Act
            var list = _action.GetObjByID(ids);
            var result = from s in list
                         where s.IDs == ids.ToString()
                         select s.AppID;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }

        [TestMethod()]
        public void AddObj_AddNewApp_ReturnSuccessuflly_Test()
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
        public void EditObj_EditApp_ReturnSeccessfully_Test()
        {
            //Arrange
            PerpareForTest("Edit");
            _para.IDs = _ids.ToString();
            _para.Comments = "Test Edit App Name 999999 ";
            var expect = "Successfully";

            //Act 
             var result = _action.EditObj(_para);

            //Assert
            Assert.AreEqual(expect, result, $" Edit New App role {result} . ");
        }

        [TestMethod()]
        public void DeleteObj_DeleteApps_ReturnSuccessfully_Test()
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