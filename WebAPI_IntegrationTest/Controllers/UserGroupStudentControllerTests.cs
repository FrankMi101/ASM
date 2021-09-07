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
    public class UserGroupStudentControllerTests
    {
       
        private UserGroupMemberStudent _para = new UserGroupMemberStudent();
        private int _ids = 0;
        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional
            _para.Operate = "Edit";
            _para.UserID = "tester";
            _para.IDs = "6935";
            _para.SchoolCode = "0354";
            _para.AppID = "SIC";
            _para.GroupID = "Junior Students Work Group";
            _para.MemberID = "04";
            _para.GroupType = "Grade";
            _para.StartDate = "2020/09/01";
            _para.EndDate = "2021/06/30";
            _para.Comments = "Unit Test Add Grade 05 to School user Group Testing  9999 ";
        }

        [TestMethod()]
        public void GetTest()
        {
            Assert.Fail();
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
            // Arrange 
            string uri = "UserGroupStudent";
             
            string expect = "Successfully";

            //Act 
            var iAction = new ActionApp<UserGroupMemberStudent>(); // new ActionAppUserGroup());
            var result = iAction.ActionsObj(uri, _para);


            Assert.AreEqual(expect, result.Substring(0, 12), $" Add New App role {result} . ");
            _ids = int.Parse(result.Replace("Successfully", ""));
         
        }

        [TestMethod()]
        public void PutTest()
        {
            // Arrange 
            string uri = "UserGroupStudent";

            string expect = "Successfully";

            //Act 
            var iAction = new ActionApp<UserGroupMemberStudent>(); // new ActionAppUserGroup());
            var result = iAction.ActionsObj(uri, _para);


            Assert.AreEqual(expect, result.Substring(0, 12), $" Edit New App role {result} . ");
         
        }

        [TestMethod()]
        public void DeleteTest()
        {
            Assert.Fail();
        }
    }
}