using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ASMBLL_IntegrationTest
{
    [TestClass]
    public class UnitTest1
    {
      //  private NorthwindEntities context;

        [TestInitialize]
        public void TestInitialize()
        {
           // this.context = "";// new NorthwindEntities();
        }

        [TestMethod]
        public void TestMethod1()
        {
         //   Assert.AreEqual(92, this.context.Customers.Count());
        }

        [TestCleanup]
        public void TestCleanup()
        {
          //  this.context.Dispose();
        }
    }
}
