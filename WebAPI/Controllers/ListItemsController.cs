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
    public class ListItemsController : ApiController
    {
        private ActionListItem _action = new ActionListItem();
     
        // GET: api/ListItems
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
        [HttpGet]
        [Route("api/ListItems/{Operate}/{UserID}/{UserRole}")]
        public IEnumerable<NameValueList> Get(string Operate, string UserID, string UserRole)
        {
            var parameter = new { Operate, UserID, UserRole};
             return _action.GetObjList(parameter);
        }
        [HttpGet]
        [Route("api/ListItems/{Operate}/{UserID}/{UserRole}/{Para1}")]
        public IEnumerable<NameValueList> Get(string Operate, string UserID, string UserRole, string Para1)
        {
            var parameter = new { Operate, UserID, UserRole, Para1};
            return _action.GetObjList(parameter);
        }
        [HttpGet]
        [Route("api/ListItems/{Operate}/{UserID}/{UserRole}/{Para1}/{Para2}/{Para3}/{Para4}")]
        public IEnumerable<NameValueList> Get(string Operate, string UserID, string UserRole, string Para1, string Para2, string Para3, string Para4)
        {
            var parameter = new { Operate, UserID, UserRole, Para1, Para2, Para3, Para4 };
            return _action.GetObjList(parameter);
        }
    }
}
