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
    public class UserGroupControllerTests
    {
        private ActionAppUserGroup _action = new ActionAppUserGroup();
        [TestMethod()]
        public void Get_AllUserGroup_ReturnAllGroupList()
        {
            // Arrange
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = "0354" };
            var expect = "Grade 3/4 Students";

            // Act
            var result = _action.GetObjList(para);

            //Assert
            Assert.AreEqual(expect, result[1].GroupName, $" User Group add  {result.Count}  ");
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
        public void GetTest3()
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