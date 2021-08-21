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
    public class UserGroupStudentController : ApiController
    {
        private ActionAppUserGroupMemberS _action = new ActionAppUserGroupMemberS();
 
        // GET: api/UserGroupMembe
        [HttpGet]
        [Route("api/UserGroupStudent/{schoolCode}/{appID}")]
        public IHttpActionResult Get(string schoolCode, string appID)
        {
             IList<UserGroupMemberStudent> result = null;
            var para = new { Operate = "GroupListbyApp", UserID = "asm", UserRole = "admin", SchoolCode = schoolCode, AppID = appID };
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }


        // GET: api/UserGroupMembe?
        [HttpGet]
        [Route("api/UserGroupStudent/{schoolCode}/{appID}/{groupID}")]
        public IHttpActionResult Get(string schoolCode,string appID, string groupID)
        {
             IList<UserGroupMemberStudent> result = null;
            var para = new { Operate = "GroupListbyGroup", UserID = "asm", UserRole = "admin", SchoolCode = schoolCode, AppID=appID,GroupID=groupID};
            result = _action.GetObjList(para);

            if (result.Count == 0)
                return NotFound();
            else
                return Ok(result);
        }

        // GET: api/usergroup/5
        [HttpGet]
        [Route("api/UserGroupStudent/{id}")]
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
        [Route("api/UserGroupStudent")]
        public IHttpActionResult Post([FromBody] UserGroupMemberStudent userGroup)
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
 


        // PUT: api/usergroup/5
        [HttpPut]
        [Route("api/UserGroupStudent")]
        public IHttpActionResult Put([FromBody] UserGroupMemberStudent userGroup)
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
        [Route("api/UserGroupStudent/{id}")]
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
