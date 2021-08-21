using Microsoft.VisualStudio.TestTools.UnitTesting;
using WebAPI;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL;
using ClassLibrary;

namespace WebAPI.Tests
{
    [TestClass()]
    public class APIListofTTests
    {
        [TestMethod()]
        public void CeneralList_provideDataAndStudentObject_returnObjectList_Test()
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
            var sp = "SIC_sys_ListofStudents";

            //Act
            var result =    GeneralList.CommonList<Student>(sp, parameter);
 
            //Assert
            Assert.IsNotNull(result, $"Stufent  List Testing {result.Count}");
         }

        [TestMethod()]
        public void CeneralValueTest()
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
            var result = GeneralValue.CommonValue<string>(sp, parameter);

            //Assert
            Assert.AreEqual(expect, result, $"Stufent  List Testing {result}");
        }
    }
}