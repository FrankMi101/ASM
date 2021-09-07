using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ASMBLL;

namespace WebAPI.Controllers.Tests
{
    [TestClass()]
    public class AppRoleControllerTests
    {
        private ActionAppRole _action = new ActionAppRole();

        [TestMethod()]
        public void GetAllRoleList_ReturnAll_Test()
        {
            // Arrange 
            string uri = "approle";
            var para = new { Operate = "GetListAll", SearchBy = "SurName", SearchValue = "Pa", Scope = "Board" };
            string qStr = ""; // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;

           var expect = "Application Admin";
 
            //Act 

            var iAction = new ActionAppRole("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);
 
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
            var para = new { Operate = "GetListbyType", RoleType = "SAP"};
            string qStr = "/" + para.RoleType ; // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;
            var expect = "Vice Principal";

            //Act 
            var iAction = new ActionAppRole("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjList(uri, qStr);
 
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

            string uri = "approle/{id}";
            int qStr =  int.Parse(para.IDs); // "/" + para.SchoolCode + "/" + para.SearchBy + "/" + para.SearchValue + "/" + para.Scope;
     
            //Act 
            var iAction = new ActionAppRole("API"); // new ActionAppUserGroup());
            var list = iAction.GetObjByID(uri, qStr);
             
            var result = from s in list
                         where s.RoleID == "Educator"
                         select s.RoleName;
            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");

        }

        [TestMethod()]
        public void PostTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void PutTest()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void DeleteTest()
        {
            Assert.Fail();
        }
    }
}