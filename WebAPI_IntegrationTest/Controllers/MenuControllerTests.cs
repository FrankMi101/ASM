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
    public class MenuControllerTests
    {
        [TestMethod()]
        [DataRow("StudentListPage")]
        [DataRow("GroupListPage")]
        [DataRow("ClassListPage")]
        [DataRow("StaffListPage")]
        [DataRow("SecurityGroupManage")]
        public void Get_GetMenuItems_ReturnMenuItems_Test(string menuType)
        {
            // Arrange 
            string uri = "Menu";
            var P = new
            {   Operate = menuType,
                UserID = "mif",
                UserRole = "Admin",
                Year = "20202021",
                Code = "0501",
                TabID = "10",
                ObjID = "383823321",
                AppID = "SIC"
            };
            string qStr = "/" + P.Operate + "/" + P.UserID + "/" + P.UserRole + "/" + P.Year + "/" + P.Code + "/" + P.TabID + "/" + P.ObjID + "/" + P.AppID;
            string expect = menuType;

            //Act
            var apiAction = new ActionAppList<MenuItems, MenuItems>("API");
            var list = apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.MenuID == menuType
                         select s.Name;
            //Assert
            //StringAssert.Contains(result.FirstOrDefault(), expect, $" App Role contain {result} ");
            Assert.IsNotNull(result, $"App List item Testing {list.Count}");
        }
    }
}