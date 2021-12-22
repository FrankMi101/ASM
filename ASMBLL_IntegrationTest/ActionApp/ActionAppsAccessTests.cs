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
    public class ActionAppsAccessTests
    {

        private readonly IActionApp<AppAccess> _action = new ActionAppsAccess("SQL");

        [TestInitialize]
        public void Setup()
        {

        }

        [TestMethod()]
        [DataRow("addesam02", "SocialWorker")]
        [DataRow("banchet", "Guidance")]
        [DataRow("borgesa02", "SeTeacher")]
        [DataRow("corradn", "APT")]
        [DataRow("defiguo", "Principal")]
        [DataRow("gogginr", "Secretary")]
        [DataRow("martine", "Other")]
        [DataRow("maurice", "ESLTeacher")]
        [DataRow("mousers", "ITFTeacher")]
        [DataRow("rigatte", "EA")]
        [DataRow("wahban", "CYW")]
        [DataRow("yaremkb", "Teacher")]
        public void GetValue_InputUserIDandAppID_IEP_ReturnRole_Test(string UserID, string checkRole)
        {
            //Arrange
            string expect = checkRole;
            var para = new { Operate = "AppRole", UserID, AppID = "IEP" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "SocialWorker")]
        [DataRow("banchet", "Guidance")]
        [DataRow("borgesa02", "SeTeacher")]
        [DataRow("corradn", "APT")]
        [DataRow("defiguo", "Principal")]
        [DataRow("gogginr", "Secretary")]
        [DataRow("martine", "Other")]
        [DataRow("maurice", "ESLTeacher")]
        [DataRow("mousers", "ITFTeacher")]
        [DataRow("rigatte", "EA")]
        [DataRow("wahban", "CYW")]
        [DataRow("yaremkb", "Teacher")]
        public void GetValue_InputUserIDandAppID_SAM_ReturnRole_Test(string UserID, string checkRole)
        {
            //Arrange
            string expect = checkRole;
            var para = new{ Operate = "AppRole", UserID , AppID = "ASM" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "Teacher")]
        [DataRow("banchet", "Teacher")]
        [DataRow("borgesa02", "Teacher")]
        [DataRow("corradn", "Teacher")]
        [DataRow("defiguo", "Principal")]
        [DataRow("friestj", "Teacher")]
        [DataRow("frigom", "Teacher")]
        [DataRow("gogginr", "Other")]
        [DataRow("martine", "Other")]
        [DataRow("maurice", "Teacher")]
        [DataRow("mousers", "Teacher")]
        [DataRow("rigatte", "Teacher")]
        [DataRow("wahban", "Teacher")]
        [DataRow("yaremkb", "Teacher")]
        public void GetValue_InputUserIDandAppID_LTO_ReturnRole_Test(string UserID, string checkRole)
        {
            //Arrange
            string expect = checkRole;
            var para = new { Operate = "AppRole", UserID, AppID = "LTO" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "Teacher")]
        [DataRow("banchet", "Teacher")]
        [DataRow("borgesa02", "Teacher")]
        [DataRow("corradn", "Teacher")]
        [DataRow("defiguo", "Principal")]
        [DataRow("gogginr", "Other")]
        [DataRow("martine", "Other")]
        [DataRow("maurice", "Teacher")]
        [DataRow("mousers", "Teacher")]
        [DataRow("rigatte", "Teacher")]
        [DataRow("wahban", "Other")]
        [DataRow("yaremkb", "Teacher")]
        public void GetValue_InputUserIDandAppID_TPA_ReturnRole_Test(string UserID, string checkRole)
        {
            //Arrange
            string expect = checkRole;
            var para = new { Operate = "AppRole", UserID, AppID = "TPA" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "SocialWorker", "Read")]
        [DataRow("banchet", "Guidance", "Update")]
        [DataRow("borgesa02", "SeTeacher", "Update")]
        [DataRow("corradn", "APT", "Update")]
        [DataRow("defiguo", "Principal", "Super")]
        [DataRow("gogginr", "Secretary", "Update")]
        [DataRow("martine", "Other", "Deny")]
        [DataRow("maurice", "ESLTeacher", "Update")]
        [DataRow("mousers", "ITFTeacher", "Update")]
        [DataRow("rigatte", "EA", "Update")]
        [DataRow("wahban", "CYW", "Read")]
        [DataRow("yaremkb", "Teacher", "Update")]
        public void GetValue_InputUserIDandUserRole_IEP_ReturnPermission_Test(string userID, string checkRole, string permission)
        {
            //Arrange
            string expect = permission;
            var para = new  { Operate = "Permission", UserID = userID, AppID = "IEP", UserRole = checkRole, ModelID = "Pages" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "Teacher", "Deny")]
        [DataRow("banchet", "Teacher", "Deny")]
        [DataRow("borgesa02", "Teacher", "Deny")]
        [DataRow("corradn", "Teacher", "Deny")]
        [DataRow("defiguo", "Principal", "Update")]
        [DataRow("friestj", "Teacher", "Deny")]
        [DataRow("frigom", "Teacher", "Deny")]
        [DataRow("gogginr", "Other", "Deny")]
        [DataRow("martine", "Other", "Deny")]
        [DataRow("maurice", "Teacher", "Deny")]
        [DataRow("mousers", "Teacher", "Deny")]
        [DataRow("rigatte", "Teacher", "Deny")]
        [DataRow("wahban", "Teacher", "Deny")]
        [DataRow("yaremkb", "Teacher", "Deny")]
        public void GetValue_InputUserIDandUserRole_IEP_COVID19_ReturnPermission_Test(string userID, string checkRole, string permission)
        {
            //Arrange
            string expect = permission;
            var para = new { Operate = "Permission", UserID = userID, AppID = "IEP", UserRole = checkRole, ModelID = "COVID90" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "Teacher", "Deny")]
        [DataRow("banchet", "Teacher", "Deny")]
        [DataRow("borgesa02", "Teacher", "Deny")]
        [DataRow("corradn", "Teacher", "Deny")]
        [DataRow("defiguo", "Principal", "Update")]
        [DataRow("friestj", "Teacher", "Deny")]
        [DataRow("frigom", "Teacher", "Deny")]
        [DataRow("gogginr", "Other", "Deny")]
        [DataRow("martine", "Other", "Deny")]
        [DataRow("maurice", "Teacher", "Deny")]
        [DataRow("mousers", "Teacher", "Deny")]
        [DataRow("rigatte", "Teacher", "Deny")]
        [DataRow("wahban", "Teacher", "Deny")]
        [DataRow("yaremkb", "Teacher", "Deny")]
        public void GetValue_InputUserIDandUserRole_SAM_ReturnPermission_Test(string userID, string checkRole, string permission)
        {
            //Arrange
            string expect = permission;
            var para = new { Operate = "Permission", UserID = userID, AppID = "ASM", UserRole = checkRole, ModelID = "Pages" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }
        [TestMethod()]
        [DataRow("addesam02", "Teacher","Deny")]
        [DataRow("banchet", "Teacher","Deny")]
        [DataRow("borgesa02", "Teacher", "Deny")]
        [DataRow("corradn", "Teacher","Deny")]
        [DataRow("defiguo", "Principal", "Update")]
        [DataRow("friestj", "Teacher","Update")]
        [DataRow("frigom", "Teacher", "Update")]
        [DataRow("gogginr", "Other","Deny")]
        [DataRow("martine", "Other","Deny")]
        [DataRow("maurice", "Teacher", "Deny")]
        [DataRow("mousers", "Teacher", "Deny")]
        [DataRow("rigatte", "Teacher", "Deny")]
        [DataRow("wahban", "Teacher", "Deny")]
        [DataRow("yaremkb", "Teacher", "Deny")]
        public void GetValue_InputUserIDandUserRole_LTO_ReturnPromission_Test(string userID, string checkRole, string permission)
        {
            //Arrange
            string expect = permission;
            var para = new  { Operate = "Permission", UserID = userID, AppID = "LTO", UserRole = checkRole, ModelID = "Pages" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "Teacher", "Update")]
        [DataRow("banchet", "Teacher", "Update")]
        [DataRow("borgesa02", "Teacher", "Update")]
        [DataRow("corradn", "Teacher", "Update")]
        [DataRow("defiguo", "Principal", "Super")]
        [DataRow("gogginr", "Other", "Deny")]
        [DataRow("martine", "Other", "Deny")]
        [DataRow("maurice", "Teacher", "Update")]
        [DataRow("mousers", "Teacher", "Update")]
        [DataRow("rigatte", "Teacher", "Update")]
        [DataRow("wahban", "Other", "Deny")]
        [DataRow("yaremkb", "Teacher", "Update")]
        public void GetValue_InputUserIDandUserRole_TPA_ReturnPermission_Test(string userID, string checkRole, string permission)
        {
            //Arrange
            string expect = permission;
            var para = new { Operate = "Permission", UserID = userID, AppID = "TPA", UserRole = checkRole, ModelID = "Pages" };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }

        [TestMethod()]
        [DataRow("addesam02", "SocialWorker","Area")]
        [DataRow("banchet", "Guidance","School")]
        [DataRow("borgesa02", "SeTeacher","School")]
        [DataRow("corradn", "APT","Area")]
        [DataRow("defiguo", "Principal","School")]
        [DataRow("gogginr", "Secretary","School")]
        [DataRow("martine", "Other", "School")]
        [DataRow("maurice", "ESLTeacher","School")]
        [DataRow("mousers", "ITFTeacher","Feeders")]
        [DataRow("rigatte", "EA","School")]
        [DataRow("wahban", "CYW","School")]
        [DataRow("yaremkb", "Teacher","Class")]
        public void GetValue_InputUserIDandUserRole_IEP_ReturnAccessScope_Test(string userID, string userRole,string checkScope)
        {
            //Arrange
            string expect = checkScope;
            var para = new  { Operate = "Scope", UserID = userID, AppID = "IEP",UserRole = userRole };

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }


        [TestMethod()]
        [DataRow("addesam02", "Area")]
        [DataRow("banchet",  "School")]
        [DataRow("borgesa02",  "School")]
        [DataRow("corradn",  "Area")]
        [DataRow("defiguo",  "School")]
        [DataRow("gogginr",  "School")]
        [DataRow("martine",  "School")]
        [DataRow("maurice",  "School")]
        [DataRow("mousers",  "Feeders")]
        [DataRow("rigatte", "School")]
        [DataRow("wahban", "School")]
        [DataRow("yaremkb",  "Class")]
        public void GetValue_InputUserIDandCalUserRole_IEP_ReturnAccessScope_Test(string UserID,  string checkScope)
        {
            //Arrange
            string expect = checkScope;

            var paraForRole = new { Operate = "AppRole", UserID, AppID = "ASM" };

            //Act
            var UserRole = _action.GetValue(paraForRole);

            var para = new { Operate = "Scope", UserID, AppID = "IEP", UserRole};

            //Act
            var result = _action.GetValue(para);

            //Assert
            Assert.AreEqual(expect, result, $" test {result} ");

        }
    }
}