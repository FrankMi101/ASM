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
    public class ActionAppListTests
    {
        [TestMethod()]
        public void GetObjList2_GetAllUserGroupListItmsbyParame_ReturnUserGroupList()
        {
            //Arrange
            var expect = "Grade 05 Work Group";
            var para = new { Operate = "GetListbyApp", UserID = "asm", UserRole = "admin", SchoolCode = "0354", AppID = "SIC" };
            //Act 
             //  DataOperateService<GroupList> dataOperateService = (DataOperateService<GroupList>)MapClass<GroupList>.DBSource("SQL");

            var cAction = new ActionAppList<GroupList,UserGroup>("SQL"); // new ActionAppUserGroup());
            //var sp = cAction.GetSPName("Read");

            var list = cAction.GetObjList("ClassCall", para);

            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group  {list.Count}");
        }
        [TestMethod()]
        public void GetObjList2_GetAllUserGroupListItmsbyAPI_ReturnUserGroupList()
        {
            //Arrange
            var expect = "Grade 05 Work Group";
            string uri = "usergroup/list";
            string qStr = "/0354/SIC";

            //Act 
          //  DataOperateService<GroupList> dataOperateService = (DataOperateService<GroupList>)MapClass<GroupList>.DBSource("API");

            var cAction = new ActionAppList<GroupList, UserGroup>("API"); // new ActionAppUserGroup());

           // var cAction = new ActionAppList<GroupList, UserGroup>(); // new ActionAppUserGroup());
            var list = cAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.GroupID == "Grade 05 Work Group"
                         select s.GroupID;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" User work Group  {list.Count}");
        }

        [TestMethod()]
        public void SPNameG_AppRole_Test()
        {
            var cAction = new ActionGet<AppRole>(new ActionAppRole());
            var sp = cAction.GetSPName("Read");
            Assert.IsNotNull(sp);
        }
        [TestMethod()]
        public void SPNameG_UseGroup_Test()
        {
            var cAction = new ActionGet<UserGroup>(new ActionAppUserGroup());
            var sp = cAction.GetSPName("Read");
            Assert.IsNotNull(sp);
        }
    }
}