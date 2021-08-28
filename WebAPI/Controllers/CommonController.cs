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
    public class CommonController : ApiController
    {
        private readonly string _dataSource = DataSource.Type();
        // GET: api/Common
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }
  

        // GET: api/UserGroup
        [HttpGet]
        [Route("api/common/grouplist/{schoolCode}/{appID}")]
        public IHttpActionResult Get(string SchoolCode, string AppID)
        {
            var _action = new ActionAppList<GroupList,UserGroup>(_dataSource);
            IList<GroupList> result = null;
            var para = new { Operate = "GroupList", UserID = "asm", UserRole = "admin", SchoolCode, AppID };
            result = _action.GetObjList( para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        [HttpGet]
        [Route("api/common/stafflist/{schoolCode}/{searchBy}/{searchValue}/{scope}")]
        public IHttpActionResult Get(string SchoolCode, string Searchby, string SearchValue, string Scope)
        {
            var _action = new ActionAppList<StaffListSearch,StaffList>(_dataSource);
            IList<StaffListSearch> result = null;
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode, Searchby, SearchValue, Scope };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }
    }
}
