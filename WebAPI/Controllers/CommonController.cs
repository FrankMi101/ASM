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
{/// <summary>
/// this generic API does not work. WebAPI controllers dose notsupport the Generice type in the controler  
/// </summary>
/// <typeparam name="T"></typeparam>
    [EnableCors(origins: "*", headers: "*", methods: "*")]

    public class CommonController<T>: ApiController where T : class, new()
     //public class GenericApiController<TEntity> : BaseApiController where TEntity : class, new() 
    {
    private readonly ActionAppService<T> _action = new ActionAppService<T>();
        // GET: api/Common
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
        // GET: api/UserGroup?
        [HttpGet]
        [Route("api/usergroup/list/{schoolcode}")]
        public IList<T> Get(string roleType)
        {
            var para = new { Operate = "GetListbyType", IDs = "0", UserID = "asm", UserRole = "admin", RoleType = roleType };

            return _action.GetObjList(para);
        }
         
    }
}
