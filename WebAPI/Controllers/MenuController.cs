
using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class MenuController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<MenuItems> _action = new ActionMenuItem(_dataSource);


      //  private ActionMenuItem _action = new ActionMenuItem();
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
        public IEnumerable<MenuItems> Get(string Operate, string UserID, string UserRole)
        {
            var parameter = new { Operate, UserID, UserRole};
            return _action.GetObjList(parameter);
        }
        public IEnumerable<MenuItems> Get(string Operate, string UserID, string UserRole, string SchoolYear, string SchoolCode)
        {
            var parameter = new { Operate, UserID, UserRole, SchoolYear, SchoolCode };
            return _action.GetObjList(parameter);
        }
        public IEnumerable<MenuItems> Get(string Operate, string UserID, string UserRole, string SchoolYear, string SchoolCode, string TabID, string ObjID, string AppID)
        {
            var parameter = new { Operate, UserID, UserRole, SchoolYear, SchoolCode, TabID, ObjID, AppID };
            return _action.GetObjList(parameter);
        }

    }
}
