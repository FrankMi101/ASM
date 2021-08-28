using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI
{
    public class DataSource
    {
        private readonly static string _dataSourceType = "SQL";
        public static string Type()
        {
            return _dataSourceType;
        } 
    }
}