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
    public class SearchTeacherControllerTests
    {
        [TestMethod()]
        public void Get_SearchAppraisalTeacherListbySearchCondition_ReturnTeacherList_Test()
        {
            //Arrange                                            
            var parameter = new
            {
                Operate = "Get",
                UserID = "mif",
                UserRole = "Admin",
                SchoolYear = "20202021",
                SchoolCode = "0501",
                Grade = "TPA",
                SearchBy = "",
                SearchValue = "",
                Scope = "School"
            };
            var sp = "dbo.SIC_sys_ListofAppraisal";

            //Act
            var _iapiaction = new APIAction<AppRole>();
            var result = _iapiaction.ListOfT("AppRole", sp, parameter);
         //   var result = APIListofT<AppraisalList>.CeneralList("TeacherAppraisalList", sp, parameter);

            //Assert
            Assert.IsNotNull(result, $"Appraisal Teacher List Testing {result.Count}");
        }
    }
}