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
    public class ActionAppAppsModelTests
    {
        private int _ids = 0;
        private AppsModel _para = new AppsModel();
        private readonly IActionApp<AppsModel> _action = new ActionAppsModel("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.AppID = "IEP";
            _para.ModelID = "IEP2";
            _para.ModelName = "New Model in IEP";
            _para.Owners = "IEP Committee";
            _para.Developer = "Frank Mi";
            _para.StartDate = "2021-09-01";
            _para.EndDate = "2021-11-30";
            _para.Comments = "Unit Test add new Appstest ";

        }


        [TestMethod()]
        public void GetObjList_ReturnAppModelList_Test()
        {   //Arrange
             string expect = "All Application Pages";
            var para = new { Operate = "GetList", UserID = "asm", IDs ="0", UserRole = "admin", AppID = "IEP" };

            //Act
            var list = _action.GetObjList(para);
            var result = from s in list
                         where s.ModelID == "Pages"
                         select s.ModelName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }
        [TestMethod()]
        public void GetObjByID_ReturnAppModelNamebyID_Test()
        {   //Arrange
            int ids = 9;
            string expect = "TPH CCM List Excel File Extract";

            //Act
            var list = _action.GetObjByID(ids);
            var result = from s in list
                         where s.IDs == ids.ToString()
                         select s.ModelName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" test {result.FirstOrDefault()} ");

        }

        [TestMethod()]
        public void AddObj_AddNewAppModel_ReturnSuccessuflly_Test()
        {
            //Arrange
            var expect = "Successfully";
            _para.IDs = "0";
            _para.Operate = "Add";
            _para.UserID = "tester";
            //Act    
            var result = _action.AddObj(_para);

            //Assert
            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role Permission {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));

        }

        [TestMethod()]
        public void EditObj_EditAppModel_ReturnSeccessfully_Test()
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
        public void DeleteObj_DeleteAppsModel_ReturnSuccessfully_Test()
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