using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ClassLibrary;

namespace WebAPI.Tests
{
    [TestClass()]
    public class APIActionTests
    {
        [TestMethod()]
        public void CeneralList_GetGenricListByCategory_ReturnListbyCategoryTest()
        {
            //Arrange                                            
            var parameter = new
            {
                Operate = "Get",
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                SchoolCode = "0501",
                Grade = "10",
                SearchBy = "",
                SearchValue = "",
                Scope = "School"
            };
            var sp = "dbo.SIC_sys_ListofStudents";

            //Act
            var apiAction  = new APIAction<Student>();
            var result = apiAction.ListOfT("StudentList", sp, parameter);

            // var result = APIListofT<Student>.CeneralList("StudentList", sp, parameter);

            //Assert
            Assert.IsNotNull(result, $"Search Student List Testing {result.Count}");
        }

        [TestMethod()]
        public void CeneralVAlue_APIAction_ReturnAPIActionResult_Test()
        {
            //Arrange                                            
            var parameter = new
            {
                Operate = "Update",
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                StudentID = "00028123131298",
                Exceptionality = "110",
                Placement = "03",
                Program = "01",
            };
            var sp = "dbo.SIC_sys_StudentSpedProfile";
            var expect = "Successfully";
            //Act
 
            var apiAction = new APIAction<string>();
            var result = apiAction.ValueOfT("APIaction", sp, parameter);
 
 
             //Assert
            Assert.AreEqual(expect, result, $"API Action result testing {result}");
       }
    }
}