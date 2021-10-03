using System.Collections.Generic;
using System.Linq;

namespace BLL
{
    public class CheckStoreProcedureParameters
    {
        public static string GetParamerters(string sp, object obj)
        {
            if (sp.Contains("@"))
                return sp;
            else
                return sp + GetParameterStrFromParameterObj(obj);
        }
        public static string GetObjType(object obj)
        {
            var myP = PropertiesOfType<string>(obj);

            foreach (var item in myP)
            {
                if (item.Key == "ObjType") return item.Value;
            };
            return "";
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
                    if (item.Key != "ObjType")
                    {
                        if (x == 0)
                            para = " @" + item.Key;
                        else
                            para = para + ",@" + item.Key;
                        x++;
                    }
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
