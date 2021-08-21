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
    public class ActionListItemTests
    {
        private CommonListParameter _clParameter = new CommonListParameter();
       // private readonly ActionListItem action = new ActionListItem();
        private readonly ActionGet<NameValueList> _action = new ActionGet<NameValueList>(new ActionListItem());

 

        [TestInitialize]
        public void Setup()
        {
            // Runs before each test. (Optional)
            _clParameter.Operate = "";
            _clParameter.UserID = "mif";
            _clParameter.Para1 = "Admin";
            _clParameter.Para2 = "20192020";
            _clParameter.Para3 = "0501";
            _clParameter.Para4 = "";
        }

        [TestMethod()]
        [DataRow("UserRole", "Admin")]
        public void GetObjList_InputParamater_ReturnUserRoleItemList_Test(string ddlControlCategory, string expect)
        {
            //Arrange
            _clParameter.Operate = ddlControlCategory;
            //Act 
            var list = _action.GetObjList(_clParameter);

            var result = from s in list
                         where s.Value == "Admin"
                         select s.Name;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" list control {ddlControlCategory} has items count {list.Count} . ");
        }
        [TestMethod()]
        [DataRow("UserRole", 29)]
        public void GetObjList_InputParamater_ReturnUserRoleItemList_CountItems_Test(string ddlControlCategory, int expect)
        {
            //Arrange
            _clParameter.Operate = ddlControlCategory;

            //Act 
            var list = _action.GetObjList(_clParameter);
            int result = list.Count;
            //Assert
            Assert.AreEqual(expect, result, $" Assembling list control {ddlControlCategory} has items count {result} . ");
        }
        [TestMethod()]
        [DataRow("Age", 2)]
        [DataRow("AppsName", 6)]
        [DataRow("Grade", 4)]
        [DataRow("ListSchool", 256)]
        [DataRow("SchoolArea", 12)]
        [DataRow("SchoolYear", 12)]
        [DataRow("UserRole", 29)]
        public void GetObjList_GroupInputParamater_ReturnList_CountItems_Test(string ddlControlCategory, int expect)
        {
            //Arrange
            _clParameter.Operate = ddlControlCategory;

            //Act 
             var list = _action.GetObjList(_clParameter);
            int result = list.Count;
            //Assert
            Assert.AreEqual(expect, result, $" Assembling list control {ddlControlCategory} has items count {result} . ");
        }

        [TestMethod()]
        [DataRow("Age", "19", "19")]
        [DataRow("AppsName", "SIC", "School Information Center")]
        [DataRow("Grade", "11", "Gr.11")]
        [DataRow("ListSchool", "0501", "Notre Dame High School")]
        [DataRow("SchoolArea", "Area 05", "Area 05")]
        [DataRow("SchoolYear", "20192020", "20192020")]
        [DataRow("UserRole", "SeTeacher", "SeTeacher")]
        public void GetObjList_GroupInputParamater_ReturnInitialItemName_Test(string ddlControlCategory, string initialValue, string expect)
        {
            //Arrange
            _clParameter.Operate = ddlControlCategory;
            //Act 
             var list = _action.GetObjList(_clParameter);

            var result = from s in list
                         where s.Value == initialValue
                         select s.Name;

            //Assert
            Assert.AreEqual(expect, result.FirstOrDefault(), $" list control {ddlControlCategory} has items count {list.Count} . ");
        }

    }
}