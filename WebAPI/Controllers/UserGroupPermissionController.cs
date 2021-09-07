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
    public class UserGroupPermissionController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<UserGroupPermission> _action = new ActionUserGroupPermission(_dataSource);

   
        // GET: api/UserGroup
        [HttpGet]
        [Route("api/UserGroupPermission")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin", SchoolCode ="0000", AppID= "SIC" };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }

        // GET: api/UserGroupPermission/appid/schoolCode
        [HttpGet]
        [Route("api/UserGroupPermission/{appID}/{schoolCode}")]
        public IHttpActionResult Get(string AppID, string SchoolCode )
        {
             var para = new { Operate = "GetList", UserID = "asm",  UserRole="admin",SchoolCode, AppID  };

            var result = _action.GetObjList(para);

            return  CheckGetResult(result);
        }

        // GET: api/UserGroupPermission/appid/schoolCode
        [HttpGet]
        [Route("api/UserGroupPermission/{appID}/{schoolCode}/{groupID}")]
        public IHttpActionResult Get(string AppID, string SchoolCode, string GroupID)
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode, AppID ,GroupID};

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }
       

        [HttpPost]
        [Route("api/UserGroupPermission")]
        public IHttpActionResult Post([FromBody] UserGroupPermission appRole)
        {
            if (appRole.GroupID == "")
                return BadRequest("Invalid  User Group permission ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

        }

        [HttpPut]
        [Route("api/UserGroupPermission")]
        public IHttpActionResult Put([FromBody] UserGroupPermission appRole)
        {
            if (appRole.GroupID == "")
                return BadRequest("Invalid  Role permission ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

        }

        // DELETE: api/apprle/5
        [HttpDelete]
        [Route("api/UserGroupPermission/{id}")]
        public HttpResponseMessage Delete(int id)
        {
            if (id <= 0) //   return new ReturnMessage(id.ToString(), Request);

                return Request.CreateResponse(HttpStatusCode.BadRequest, " ID Can not be blank");

            var result = _action.DeleteObj(id);

            if (result == "Failed")
                return Request.CreateResponse(HttpStatusCode.NotFound, id);
            else
                return Request.CreateResponse(HttpStatusCode.Accepted, result); // return Request.CreateResponse(HttpStatusCode.Accepted, result);
        }

        private IHttpActionResult CheckGetResult(List<UserGroupPermission> result)
        {
            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
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
