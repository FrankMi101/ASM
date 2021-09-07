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
    public class AppRoleController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<AppRole> _action = new ActionAppRole(_dataSource);

   
        // GET: api/AppRole
        [HttpGet]
        [Route("api/AppRole")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetListAll" };
            var result =  _action.GetObjList(para);
            return CheckGetResult(result);
        }

        // GET: api/AppRole/roleType
        [HttpGet]
        [Route("api/AppRole/{appID}/{roleType}")]
        public IHttpActionResult Get(string AppID,string RoleType)
        {
             var para = new { Operate = "GetListbyType", UserID = "asm", IDs = "0", UserRole = "Admin", RoleType };

            var result = _action.GetObjList(para);

            return  CheckGetResult(result);
        }

        // GET: api/AppRole/roleType
        [HttpGet]
        [Route("api/AppRole/{appID}/{roleType}/{roleID}")]
        public IHttpActionResult Get(string AppID,string RoleType, string RoleID)
        {
            var para = new { Operate = "GetListbyRoleID", UserID = "asm", IDs = "0", UserRole = "Admin", RoleType, RoleID,AppID};

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }

        // GET: api/AppRole/5
        [HttpGet]
        [Route("api/AppRole/{id}")]
        public IHttpActionResult GetbyID(int id)
        {     
            var result =  _action.GetObjByID(id);

            return CheckGetResult(result);
        }

        [HttpPost]
        [Route("api/AppRole")]
        public IHttpActionResult Post([FromBody] AppRole appRole)
        {
            if (appRole.RoleID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");
 
            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

            //if (result == "Failed")
            //    return new ReturnMessage(result, Request);
            //else
            //    return Ok(result); 

        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/AppRole")]
        public IHttpActionResult Put([FromBody] AppRole appRole)
        {
            if (appRole.RoleID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            return CheckActionResult(_action.EditObj(appRole));
        }

        // DELETE: api/apprle/5
        [HttpDelete]
        [Route("api/AppRole/{id}")]
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
        private IHttpActionResult CheckGetResult(List<AppRole> result)
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
