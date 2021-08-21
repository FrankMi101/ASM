using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CommonSP
    {
        public virtual string GetSPandParametersByOverride(string action)
        {       
            {
                switch (SPSource.SPFile)
                {
                    case "JsonFile":
                        return GetSPFrom.JsonFile(action);
                    case "DBTable":
                        return GetSPFrom.DbTable(action, "AppraisalPageHelp");
                    default:
                        return GetSPInClass(action);
                }
            }
        }
        private static string GetSPInClass(string action)
        {
            string parameter = " @Operate,@UserID,@UserRole,@SchoolYear,@SchoolCode";

            switch (action)
            {
                case "TabList":
                    return "dbo.SIC_sys_ListItemsTab" + parameter;
                default:
                    return action;
            }

        }
 
    }
}
