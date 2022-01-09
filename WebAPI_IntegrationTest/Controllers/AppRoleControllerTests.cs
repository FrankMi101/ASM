using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ASMBLL;
using ClassLibrary;

namespace WebAPI.Controllers.Tests
{
    [TestClass()]
    public class AppRoleControllerTests
    {
        private int _ids = 0;
        private AppRole _para = new AppRole();

        private readonly IActionApp<AppRole> _apiAction = new ActionAppRole("API");
        private readonly IActionApp<AppRole> _action = new ActionAppRole("SQL");

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _para.Operate = "Get";
            _para.UserID = "tester";
            _para.IDs = "0";
            _para.RoleID = "NewRole";
            _para.RoleName = "New Role Name";
            _para.RoleType = "App";
        }


        [TestMethod()]
        public void GetAllRoleList_ReturnAll_Test()
        {
            // Arrange 
            string uri = "approle";
            var para = new { Operate = "GetListAll", SearchBy = "SurName", SearchValue = "Pa", Scope = "Board" };
            string qStr = ""; // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;

           var expect = "Application Admin";
 
            //Act 
            var list = _apiAction.GetObjList(uri, qStr);
 
            var result = from s in list
                         where s.RoleID == "Admin"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetRoleListbySAP_ReturnAllSAPRoleList_Test()
        {
            //Arrange
            string uri = "approle";
            var para = new { Operate = "GetListbyType", AppID="SIC", RoleType = "SAP" };
            string qStr = "/" + para.AppID + "/" + para.RoleType; // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;
            
            var expect = "Vice Principal";

            //Act  
            var list = _apiAction.GetObjList(uri, qStr);
 
            var result = from s in list
                         where s.RoleID == "VP"
                         select s.RoleName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void GetRolebyID_ReturnRoleListofID_Test()
        {
            //Arrange
            var expect = "Board Department Staff";
            var para = new { Operate = "GetListbyType", UserID = "asm", IDs = "26" };

            string uri = "approle/";
            int qStr =     int.Parse(para.IDs); // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;
     
            //Act 
             var list = _apiAction.GetObjByID(uri, qStr);
             
            var result = from s in list
                         where s.RoleID == "Educator"
                         select s.RoleName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }        
    }
}