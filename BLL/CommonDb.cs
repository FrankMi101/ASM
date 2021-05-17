using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL
{
    public class CommonDb
    {
        public static string SPName(string className, string action, object parameter)
        {
            try
            {
                string sp = GetSPbyClassAndAction(className, action);
                return GetParamerters(sp, parameter);
            }
            catch (Exception ex)
            {
                return className + " " + action;
            }
        }

        public static List<T> CommonList<T>(string db, string sp, object parameter)
        {
            try
            {
                // string sp = GetSP(action,"GeneralList");
                var myList = new CommonOperate<T>();
                return myList.ListOfT(db, sp, parameter);

            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }
        public static List<T> CommonList<T>(string db, string className, string action, object parameter)
        {
            try
            {
                string sp = SPName(className, action, parameter);
                return CommonList<T>(db, sp, parameter);
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }

        }
        public static T CommonValue<T>(string db, string sp, object parameter)
        {
            try
            {
               // string sp = GetSP(action, "GeneralValue");
                var myValue = new CommonOperate<T>();
                return myValue.ValueOfT(db, sp, parameter);

            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }
        public static T CommonValue<T>(string db,string className, string action, object parameter)
        {
            try
            {
                string sp = SPName(className, action, parameter);
                return CommonValue<T>(db, sp, parameter);             
            }
            catch (Exception ex)
            {
                string em = ex.StackTrace;
                throw;
            }
        }

        private static string GetSPbyClassAndAction(string className, string action)
        {
            try
            {
                switch (className)
                {
                    case "GeneralList":
                        return GeneralList.GetSP(action);
                    case "CommentsBank":
                        return CommentsBank.GetSP(action);
                    case "AppsPageHelp":
                        return AppsPageHelp.GetSP(action);
                    default:
                        return AppsPageHelp.GetSP(action);
                }
            }
            catch (Exception ex)
            {
                return className + " " + action;
            }
        }

        //private static string GetSPInClass(string action)
        //{
        //    string parameter = " @Operate,@UserID,@Type";
        //    switch (action)
        //    {
        //        case "General":
        //            return "dbo.SIC_sys_GeneralList" + parameter;

        //        case "DDList":
        //            return "dbo.SIC_sys_ListsValuePara" + parameter;
        //        case "SchoolList":
        //            return "dbo.SIC_sys_SchoolList" + parameter;
        //        default:
        //            return action;

        //    }
        //}

        private static string GetParamerters(string sp, object obj)
        {
            if (sp.Contains("@"))
                return sp;
            else
                return sp + GetParameterStrFromParameterObj(obj);
        }

        private static string GetParameterStrFromParameterObj(object obj)
        {
            var myP = PropertiesOfType<string>(obj);
            int x = 0;
            var para = "";
            foreach (var item in myP)
            {
                if (item.Value != null)
                {
                    if (x == 0)
                        para = " @" + item.Key;
                    else
                        para = para + ",@" + item.Key;
                    x++;
                }

            };
            return para;
        }
        private static IEnumerable<KeyValuePair<string, T>> PropertiesOfType<T>(object obj)
        {
            return from p in obj.GetType().GetProperties()
                   where p.PropertyType == typeof(T)
                   select new KeyValuePair<string, T>(p.Name, (T)p.GetValue(obj));
        }

    }
}
