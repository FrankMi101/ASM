using Microsoft.VisualStudio.TestTools.UnitTesting;
using ASMBLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL.Tests
{
    [TestClass()]
    public class ConsumeRepositoryTests
    {
       
        [TestMethod()]
        public void ActionXMLDatabaseTest()
        {
            ConsumeRepository.ActionXMLDatabase();
        }

        [TestMethod()]
        public void ActionSQLDatbaseTest()
        {
            ConsumeRepository.ActionSQLDatbase();
        }

        [TestMethod()]
        public void GetXMLDataTest()
        {
            var expect = "XML Database";
            var result = ConsumeRepository.GetXMLData();
            Assert.AreEqual(expect, result);
        }

        [TestMethod()]
        public void GetSQLDataTest()
        {
            var expect = "SQL Database";
            var result = ConsumeRepository.GetSQLData();
            Assert.AreEqual(expect, result);
        }
    }
}