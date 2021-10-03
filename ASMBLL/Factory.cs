using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BLL;
using ClassLibrary;
using Microsoft.Extensions.DependencyInjection;
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
    public class ActionFactory
    {
        private readonly IServiceProvider serviceProvider;

        public ActionFactory(IServiceProvider serviceProvider)
        {
            this.serviceProvider = serviceProvider;
        }

        public IActionApp<T> GetClassService<T>(string objType)
        {
          
            switch (objType)
            {
                case "AppRolePermission":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(AppRolePermission));
                case "UserGroupPermission":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionUserGroupPermission));
                case "UserGroup":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppUserGroup));
                case "UserGroupPush":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppUserGroupPush));
                case "GroupListStudent":
                case "UserGroupStudent":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppUserGroupMemberS));

                case "GroupListTeacher":
                case "UserGroupTeacher":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppUserGroupMemberT));
                case "ActionAppList":
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppList<T, T>));
                default:
                    return (IActionApp<T>)serviceProvider.GetService(typeof(ActionAppUserGroup));

            }

        }

    }
    public class RegistrationServices<T>
    {
        public void ConfigureServices(IServiceCollection services)
        {
           // services.AddMvc();

            services.AddScoped<ActionFactory>();

            services.AddScoped<NetflixStreamService>()
                        .AddScoped<IStreamService, NetflixStreamService>(s => s.GetService<NetflixStreamService>());

            services.AddScoped<AmazonStreamService>()
                        .AddScoped<IStreamService, AmazonStreamService>(s => s.GetService<AmazonStreamService>());
        }
    }

    public class NetflixStreamService : IStreamService
    {
        public string[] ShowMovies()
        {
            throw new NotImplementedException();
        }
    }

    public class AmazonStreamService : IStreamService
    {
        public string[] ShowMovies()
        {
            throw new NotImplementedException();
        }
    }
    public interface IStreamService
    {
        string[] ShowMovies();
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
