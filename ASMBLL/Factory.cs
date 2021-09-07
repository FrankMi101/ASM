using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL;
using ClassLibrary;
using Newtonsoft.Json;

namespace ASMBLL
{

    public static class Factory
    {
        public static T Get<T>() where T : class
        {
            var tName = typeof(T).ToString();
            //  string typeName = ConfigurationManager.AppSettings[tName];
            Type resolvedType = Type.GetType(tName);
            object instance = Activator.CreateInstance(resolvedType);
            return instance as T;
        }
        public static string SPandParameter(string sp, object para)
        {
            return CheckStoreProcedureParameters.GetParamerters(sp, para);
        }
        public static string GetObjType(object para)
        {
            return CheckStoreProcedureParameters.GetObjType( para);
        }
    }
    public class ObjClassFactory
    {
         
    }

    public static class AnonymousExtension
    {
        public static T Anonymize<T>( object value, T targetType)
        {
            return (T)value;
        }

        public static object Anonymize2(object inObject, object anayType)
        {

            string resultBody = JsonConvert.SerializeObject(inObject);
             var anonObject = JsonConvert.DeserializeAnonymousType(resultBody, anayType);
            return anonObject;
        }
    }
}
