using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;
using ASMBLL;

namespace WebAPI.Controllers.Tests
{
    [TestClass()]
    public class AppsModelControllerTests
    {

        private int _ids = 0;
        private AppsModel _para = new AppsModel();
        private readonly IActionApp<AppsModel> _action = new ActionAppsModel("SQL");
        private readonly IActionApp<AppsModel> apiAction = new ActionAppsModel("API");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.AppID = "ASM";
            _para.ModelID = "SelfRequest";
            _para.ModelName = "New Model in ASM self Request test Application";
            _para.Developer = "Frank Mi";
            _para.Owners = "ICT Service";
            _para.StartDate = "2021-09-01";
            _para.EndDate = "2021-11-30";
            _para.Comments = "Unit Test add new Apps Model";

        }


        [TestMethod()]
        public void Get_ReturnAllAppModels_Test()
        {
            // Arrange 
            string uri = "AppsModel";
            string qStr = ""; // "/" + para.SchoolCode + "/" + para.AppID;
            string expect = "All Application Pages";

            //Act
           // var apiAction = new ActionAppList<AppsModelList,AppsModel>("API");  
            var list = apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.ModelID == "Pages"
                         select s.ModelName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" App Model contain {result} ");

        }

        [TestMethod()]
        public void Get_ReturnAppModelbyAppID_Test()
        {
            // Arrange 
            string uri = "AppsModel";
            string qStr = "/" + "IEP" +"/" + "0";
            string expect = "TPH COVID90 Student List Extract";

            //Act
           // var apiAction = new ActionAppList<AppsModelList, AppsModel>("API");
            var list = apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.ModelID == "COVID90"
                         select s.ModelName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" App Model contain {result} ");
        }

        [TestMethod()]
        public void GetbyID_Return_an_AppModelbyID_Test()
        {
            // Arrange 
            string uri = "AppsModel";
            string qStr = "/" +"8";
            string expect = "SIC-School Basic Information";

            //Act
           // var apiAction = new ActionAppList<AppsModelList, AppsModel>("API");
            var list = apiAction.GetObjList(uri, qStr);

            var result = from s in list
                          select  s.AppID + "-" + s.ModelName;
            //Assert
            StringAssert.Contains(result.FirstOrDefault(), expect, $" App Model contain {result} ");
        }

        [TestMethod()]
        public void Post_AddNewAppsModel_Test()
        {
            // Arrange 
            string uri = "AppsModel";
            var expect = "Successfully";
            _para.IDs = "0";
            _para.Operate = "Add";
            _para.UserID = "API_Add_Test_UserID";

            //Act
           // var apiAction = new ActionAppsModel("API");
            var result = apiAction.AddObj("Add",uri, _para);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" App Model contain {result} ");
            string id = resultStr.Replace("Successfully", "");
  
            Int32.TryParse(id, out _ids); 

            //_ids = int.Parse(newIDs);
        }

        [TestMethod()]
        public void Put_EditAppModel_Test()
        {
         // Arrange 
             PerpareForTest("Add");
           string uri = "AppsModel";
            var expect = "Successfully";
            _para.IDs = _ids.ToString();
            _para.Operate = "Edit";
            _para.Comments = "Unit Test from WEb APi Call";

            //Act
           // var apiAction = new ActionAppsModel("API");
            var result = apiAction.EditObj("Edit", uri, _para);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" App Model contain {result} ");
         }

        [TestMethod()]
        public void Delete_DeleteModelbyID_Test()
        {
            // Arrange 
            PerpareForTest("Add");
            string uri = "AppsModel";
            var expect = "Successfully";
 
            //Act
           // var apiAction = new ActionAppsModel("API");
            var result = apiAction.DeleteObj("Delete", uri, _ids);

            //Assert
            string resultStr = result.ToString();
            StringAssert.Contains(resultStr, expect, $" App Model contain {result} ");
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