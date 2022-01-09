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
    public class ActionMenuItemTests
    {
        private MenuListParameter _spParamater = new MenuListParameter();
        // private readonly ActionMenuItem action = new ActionMenuItem();
        private readonly IActionGet<MenuItems> action = new ActionMenuItem();

        [TestInitialize]
        public void Setup()
        {
            _spParamater.UserID = "mif";
            _spParamater.UserRole = "Admin";
            _spParamater.SchoolYear = "20202021";
            _spParamater.SchoolCode = "0501";
            _spParamater.TabID = "10";
            _spParamater.ObjID = "383823321";
            _spParamater.AppID = "SIC";
        }


        [TestMethod()]
        [DataRow("StudentListPage")]
        [DataRow("GroupListPage")]
        [DataRow("ClassListPage")]
        [DataRow("StaffListPage")]
        [DataRow("SecurityGroupManage")]
        public void GetObjList_SublistMeniItembyCategory_ReturnDetailMenuList_Test(string category)
        {
            //Arrange 
            _spParamater.Operate = category;
            var expect = category;

            var para = new
            {
                Operate = category,
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                SchoolCode = "0501",
                TabID = "10",
                ObjID = "383823321",
                AppID = "SIC"
            };
            // Act  
             var list = action.GetObjList(para);
            var result = from s in list
                         where s.Area == category
                         select s.Area;

            //Assert
            Assert.IsNotNull(result, $"Get menu List by Generic class category count {list.Count} ");
            Assert.AreEqual(expect, result.FirstOrDefault(), $" Count menu item in menu list {list.Count} ");
        }
    }
}