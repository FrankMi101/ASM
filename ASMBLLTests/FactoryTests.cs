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
    public class FactoryTests
    {
      
        [TestMethod()]
        public void SPandParameter_inputwithoutParameter_ReturnSPOnly_Test()
        {
            // Arrange
            string sp = "dbo.SIC_asm_SP";
            var para = new { }; 
            string expect = "dbo.SIC_asm_SP"; 

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }
        [TestMethod()]
        public void SPandParameter_inputwithoutParameterAndSP_ReturnBlank_Test()
        {
            // Arrange
            string sp = "";
            var para = new { };
            string expect = "";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }
        [TestMethod()]
        public void SPandParameter_inputWithObjType_ReturnParametrWithoutObjType_Test()
        {
            // Arrange
            string sp = "dbo.SIC_asm_SP";
            var para = new { ObjType = "UserGroup", Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@RoleID";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }
        [TestMethod()]
        public void SPandParameter_inputWithoutObjType_ReturnParametrWithoutObjType_Test()
        {
            // Arrange
            string sp = "dbo.SIC_asm_SP";
            var para = new {Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@RoleID";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void SPandParameter_inputSPandParameters_ReturnOriginalValue_Test()
        {
            // Arrange
            string sp = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@RoleID,@RoleName";
            var para = new { ObjType = "UserGroup", Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@RoleID,@RoleName";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }
        [TestMethod()]
        public void SPandParameter_inputParametersOnly_ReturnParameter_Test()
        {
            // Arrange
            string sp = "";
            var para = new { ObjType = "UserGroup", Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = " @Operate,@UserID,@IDs,@RoleID";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void SPandParameter_inputAnonmnosObjet_ReturnParameter_Test()
        {
            // Arrange
            var para = new //UserGroupMemberStudent()
            {
                Operate = "Get",
                UserID = "tester",
                IDs = "0",
                SchoolCode = "0354",
                AppID = "SIC",
                GroupID = "Junior Students Work Group"
            };
            string sp = "dbo.SIC_asm_SP";
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@SchoolCode,@AppID,@GroupID";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void SPandParameter_inputInstenceObjet_ReturnNoNullValueParameter_Test()
        {
            // Arrange
            var paraObj = new UserGroupMemberStudent()
            {
                Operate = "Get",
                UserID = "tester",
                IDs = "0",
                SchoolCode = "0354",
                AppID = "SIC",
                GroupID = "Junior Students Work Group"
            };
            var anony = new {
            };
        

          //  var anonyPara =   AnonymousExtension.Anonymize(paraObj, anony);
             var anonyPara = AnonymousExtension.Anonymize2(paraObj, anony);



            string sp = "dbo.SIC_asm_SP";
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@SchoolCode,@AppID,@GroupID";

            //Act
            var result = Factory.SPandParameter(sp, anonyPara);

            //Assert

            Assert.AreEqual(expect, result);
        }
        [TestMethod()]
        public void SPandParameter_inputInstenceObjet2_ReturnNoNullValueParameter_Test()
        {
            // Arrange
            var para = new UserGroupMemberStudent()
            {
                Operate = "Get",
                UserID = "tester",
                IDs = "0",
                SchoolCode = "0354",
                AppID = "SIC",
                GroupID = "Junior Students Work Group",
                MemberID = "08",
                GroupType = "Grade",
                StartDate = "2020/09/01",
                EndDate = "2021/06/30",
                Comments = "Unit Test Add Grade 05 to School user Group Testing "
            };
            string sp = "dbo.SIC_asm_SP";
            string expect = "dbo.SIC_asm_SP @Operate,@UserID,@IDs,@SchoolCode,@AppID,@GroupID,@MemberID,@GroupType,@StartDate,@EndDate,@Comments";

            //Act
            var result = Factory.SPandParameter(sp, para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void GetObjType_InputParameterIncludeObjType_ReturnObjType_Test()
        {
            // Arrange
             var para = new { ObjType = "UserGroup", Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = "UserGroup";

            //Act
            var result = Factory.GetObjType(para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void GetObjType_inputParameterWithoutObjType_ReturnBlank_Test()
        {
            // Arrange
            var para = new { Operate = "Add", UserID = "tester", IDs = "0", RoleID = "Principal" };
            string expect = "";

            //Act
            var result = Factory.GetObjType(para);

            //Assert

            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void GetObjType_inputNoParameter_ReturnBlank_Test()
        {
            // Arrange
            var para = new { };
            string expect = "";

            //Act
            var result = Factory.GetObjType(para);

            //Assert

            Assert.AreEqual(expect, result);
        }


        //private static T CastTo<T>(object value, T targetType)
        //{
        //    // targetType above is just for compiler magic
        //    // to infer the type to cast value to
        //    return (T)value;
        //}

    }
}