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

        // GET: api/ListItems/5
        public string Get(int id)
        {
            return "value";
        }
        public IEnumerable<NameValueList> Get(string Operate, string UserID, string Para1, string Para2, string Para3, string Para4 )
        {
            var parameter = new { Operate, UserID, Para1, Para2, Para3, Para4 };
             return _action.GetObjList(parameter);
        }
       
    }
}
