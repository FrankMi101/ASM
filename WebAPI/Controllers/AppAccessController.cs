using ASMBLL;
using ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Cors;
using WebAPI.Models;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class AppAccessController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<AppAccess> _action = new ActionAppsAccess(_dataSource);
 

        // GET: api/AppAccess/role
        [HttpGet]
        [Route("api/AppAccess/{userID}/{appID}")]
        public IHttpActionResult Get(string UserID,string AppID)
        {
            var para = new { Operate = "AppRole", UserID, AppID};

            var result = _action.GetValue(para);

            return CheckActionResult(result);
        }

        // GET: api/AppAccess/Scope
        [HttpGet]
        [Route("api/AppAccess/{userID}/{appID}/{userRole}")]
        public IHttpActionResult Get(string UserID, string AppID, string UserRole)
        {
            var para = new { Operate = "Scope", UserID , AppID ,UserRole};

            var result = _action.GetValue(para);

            return CheckActionResult(result);
        }
        
        // GET: api/AppAccess/permission
        [HttpGet]
        [Route("api/AppAccess/{userID}/{appID}/{userRole}/{modelID}")]
        public IHttpActionResult Get(string UserID, string AppID,string UserRole, string ModelID)
        {
            var para = new { Operate = "Permission", UserID, AppID, UserRole, ModelID};
            var result = _action.GetValue(para);
            return CheckActionResult(result);
        }
    
        private IHttpActionResult CheckActionResult(string result)
        {
            if (result == "Failed")
                return new ReturnMessage(result, Request);
            else
                return Ok(result);
        }
    }
}
