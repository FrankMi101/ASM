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
    public class ListItemsControllerTests
    {
        [TestMethod()]
        public void Get_GenericListitembyCategory_ReturnListItems_Test()
        {
            // Arrange 
            string uri = "ListItems";
            string qStr = "/AppRole/tester/admin/1/2/3/4"; 
            string expect = "Principal";

            //Act
            var apiAction = new ActionAppList<NameValueList, NameValueList>("API");
            var list = apiAction.GetObjList(uri, qStr);

            var result = from s in list
                         where s.Value == "Principal"
                         select s.Name;
            //Assert
             StringAssert.Contains(result.FirstOrDefault(), expect, $" App Role contain {result} ");
           //  Assert.AreEqual(expect,result, $"App List item Testing {list.Count}");
        }
    }
}