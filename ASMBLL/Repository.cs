using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{

    public class Repository 
    {
        private readonly IDatabase idatabase;
        public Repository(IDatabase database)
        {
            this.idatabase = database;
        }
        public void Add(string CustomerName)
        {
            idatabase.AddRow("Customer", CustomerName);
            var esult = idatabase.UpdateRow("", "");
        }

        public void AddRow(string Table, string Value)
        {
            idatabase.AddRow("Customer", Table);
            var esult = idatabase.UpdateRow("", "");
        }

        public string UpdateRow(string Table, string Value)
        {
            idatabase.AddRow("Customer", Table);
            var esult = idatabase.UpdateRow("", "");
            return esult;
        }
    }


    public interface IDatabase
    {
        void AddRow(string Table, string Value);
        string UpdateRow(string Table, string Value);
    }
    public class SqlDatabase : IDatabase
    {
        public void AddRow(string Table, string Value)
        {
            //Logic to add new customer in sql table  
        }

        public string UpdateRow(string Table, string Value)
        {
            return "SQL Database";
        }
    }
    public class XMLDatabase : IDatabase
    {
        public void AddRow(string Table, string Value)
        {
            //Logic to add new customer in XML Document  
        }

        public string UpdateRow(string Table, string Value)
        {
            return "XML Database";
        }
    }

    public class ConsumeRepository
    {
 
        public static void ActionXMLDatabase()
        {
 
            Repository myRep = new Repository(new XMLDatabase());
            myRep.AddRow("", "");
            myRep.Add("");
            var result = myRep.UpdateRow("", "");


        }
        public static void ActionSQLDatbase()
        {
            var myRep = new Repository(new SqlDatabase());
            myRep.AddRow("", "");
           var result =  myRep.UpdateRow("", "");
        }
        public static string GetXMLData()
        {
            Repository myRep = new Repository(new XMLDatabase());
   
            return  myRep.UpdateRow("", "");
        }
        public static string GetSQLData()
        {
            Repository myRep = new Repository(new SqlDatabase());

            return myRep.UpdateRow("", "");
        }
    }
}
