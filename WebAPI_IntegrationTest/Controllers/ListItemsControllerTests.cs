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
    public class ListItemsControllerTests
    {
        [TestMethod()]
        public void Get_GenericListitembyCategory_ReturnListItems_Test()
        {
            //Arrange                                            
            var parameter = new
            {
                Operate = "Get",
                UserID = "mif",
                Para1 = "Admin",
                Para2 = "20202021",
                Para3 = "0501",
                Para4 = "Grade"
            };
            var sp = "dbo.SIC_sys_ListItems";

            //Act
            var _iapiaction = new APIAction<NameValueList>();
            var result = _iapiaction.ListOfT("ListItem", sp, parameter);

            // var result = APIListofT<Student>.CeneralList("StudentList", sp, parameter);

            //Assert
            Assert.IsNotNull(result, $"Search Student List Testing {result.Count}");
        }
    }
}