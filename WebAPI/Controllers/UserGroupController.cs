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
    public class UserGroupController : ApiController
    {
        private ActionAppUserGroup _action = new ActionAppUserGroup();

        // GET: api/UserGroup

        //public IEnumerable<UserGroup> Get()
        //{
        //     var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = "0354" };
        //    return _action.GetObjList(para);
        //}

        // GET: api/UserGroup
        [HttpGet]
        [Route("api/usergroup/list")]
        public IHttpActionResult Get()
        {
            IList<UserGroup> result = null;
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = "0354" };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        //public IEnumerable<UserGroup> Get(string schoolCode)
        //{
        //    var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = schoolCode };
        //    return _action.GetObjList(para);
        //}

        // GET: api/UserGroup?
        [HttpGet]
        [Route("api/usergroup/list/{schoolcode}")]
        public IHttpActionResult Get(string schoolCode)
        {
            IList<UserGroup> result = null;
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "admin", SchoolCode = schoolCode };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/usergroup
        [HttpGet]
        [Route("api/usergroup/list/{schoolcode}/{appID}")]
        public IHttpActionResult Get(string schoolCode, string appID)
        {
            var para = new { Operate = "GetListbyApp", UserID = "asm", UserRole = "admin", SchoolCode = schoolCode, AppID = appID };

            var result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/usergroup/5
        [HttpGet]
        [Route("api/usergroup/{id}")]
        public IHttpActionResult Get(int id)
        {
            var result = _action.GetObjByID(id);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // POST: api/usergroup
        [HttpPost]
        [Route("api/usergroup")]
        public IHttpActionResult Post([FromBody] UserGroup userGroup)
        {
            if (userGroup.GroupID == "")
                return BadRequest("Invalid User Group data.");
            // return Request.CreateResponse(HttpStatusCode.BadRequest,"Group ID Can not be blank");

            var result = _action.AddObj(userGroup);

            if (result.Substring(0, 12) == "Successfully")
                return Ok(result); // Request.CreateResponse(HttpStatusCode.Created, result);
            else
                return new ReturnMessage("Add User Group Failed", Request);
            //return Request.CreateResponse(HttpStatusCode.NotAcceptable, result);
        }

        // POST: api/usergroup/push
        [HttpPost]
        [Route("api/usergroup/push")]
        public IHttpActionResult Post([FromBody] UserGroupPush userGroup)
        {
            if (userGroup.GroupID == "")
                return BadRequest("Invalid User Group data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");
 
            var action = new ActionAppUserGroupPush();
            var result = action.AddObj(userGroup);

            if (result == "Failed")
                return new ReturnMessage(result, Request);
            else 
                return Ok(result); // return Request.CreateResponse(HttpStatusCode.Accepted, result);

        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/usergroup")]
        public IHttpActionResult Put([FromBody] UserGroup userGroup)
        {
            if (userGroup.GroupID == "")
                return BadRequest("Invalid User Group data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.EditObj(userGroup);

            if (result == "Failed")
                return new ReturnMessage(result, Request);
            else
                 return Ok(result); // return Request.CreateResponse(HttpStatusCode.Accepted, result);
  
            // return Request.CreateResponse(HttpStatusCode.NotAcceptable, result);
        }

        // DELETE: api/usergroup/5
        [HttpDelete]
        [Route("api/usergroup/{id}")]
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
    }
}
