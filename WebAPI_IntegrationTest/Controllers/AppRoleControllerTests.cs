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
        public void GetTest()
        {
            //Arrange
            var expect = "Application Admin";
            var para = new { Operate = "GetListAll" };

            //Act 
               var list =  _action.GetObjList(para);
 
            var result = from s in list
                         where s.RoleID == "Admin"
                         select s.RoleName;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Application role list has items count {list.Count} . ");


        }

        [TestMethod()]
        public void GetTest1()
        {
            Assert.Fail();
        }

        [TestMethod()]
        public void GetTest2()
        {
            Assert.Fail();
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