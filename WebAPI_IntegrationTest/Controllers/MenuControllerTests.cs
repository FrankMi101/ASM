using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;

namespace WebAPI.Controllers.Tests
{
    [TestClass()]
    public class MenuControllerTests
    {
        [TestMethod()]
        public void Get_GetStudentListMenuItems_ReturnMenuItems_Test()
        {
            //Arrange                                            
            var parameter = new
            {
                Operate = "StudentListPage",
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                SchoolCode = "0501",
                TabID = "10",
                ObjID = "0000",
                AppID = "SIC",
            };
            var sp = "dbo.SIC_sys_ActionMenuList";

            //Act
            var _iapiaction = new APIAction<MenuItems>();
            var result = _iapiaction.ListOfT("StudentMenuItems", sp, parameter);

            // var result = APIListofT<Student>.CeneralList("StudentList", sp, parameter);

            //Assert
            Assert.IsNotNull(result, $"Search Student List Testing {result.Count}");
        }
    }
}