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
    public class WorkingGroupController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<StaffWorkingGroups> _action = new ActionAppStaffWorkingGroups(_dataSource);


        // GET: api/UserGroup
        [HttpGet]
        [Route("api/WorkingGroup/list")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin"};
            var result = _action.GetObjList(para);
            return CheckGetResult(result);
        }
        // GET: api/usergroup
        [HttpGet]
        [Route("api/WorkingGroup/{memberID}")]
        public IHttpActionResult Get( string MemberID)
        {
            var para = new { Operate = "GetWorkingRole", UserID = "asm", UserRole = "Admin", MemberID };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }

        // GET: api/usergroup/5
        [HttpGet]
        [Route("api/WorkingGroup/{id}")]
        public IHttpActionResult Get(int id)
        {
            var result = _action.GetObjByID(id);

            return CheckGetResult(result);
        }

        // POST: api/usergroup
        [HttpPost]
        [Route("api/WorkingGroup")]
        public IHttpActionResult Post([FromBody] StaffWorkingGroups para)
        {
            if (para.GroupID == "")
                return BadRequest("Invalid User Group data.");
              var result = _action.AddObj(para);
            return CheckActionResult(result);
    
        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/WorkingGroup")]
        public IHttpActionResult Put([FromBody] StaffWorkingGroups para)
        {
            if (para.GroupID == "")
                return BadRequest("Invalid User Group data.");  

            var result = _action.EditObj(para);
            return CheckActionResult(result);
        }

        // DELETE: api/usergroup/5
        [HttpDelete]
        [Route("api/WorkingGroup/{id}")]
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

        private IHttpActionResult CheckGetResult(IList<StaffWorkingGroups> result)
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
