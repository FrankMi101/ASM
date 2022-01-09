using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ASMBLL
{
    // This is a class factory 
    // Concreate class DataOperateServiceSQL, DataOperateServiceAPI, ... inherited IDataOperateService<T>
    // At the Run time, whitch Concerate class will instantiate base on the dbType  
    public class MapClassForDB<T>
    {
        private static readonly string _dbType = "SQL";

        public static IDataOperateService<T> DBSource()
        {
            return DBSource(_dbType);
        }
        public static IDataOperateService<T> DBSource(string dbType)
        {
            switch (dbType)
            {
                case "MySQL":
                    return new DataOperateServiceMySQL<T>();
                case "SQL":
                    return new DataOperateServiceSQL<T>();
                case "ORA":
                    return new DataOperateServiceORA<T>();
                case "API":
                    return new DataOperateServiceAPI<T>();
                default:
                    return new DataOperateServiceSQL<T>();
            }

        }     
    }
}
