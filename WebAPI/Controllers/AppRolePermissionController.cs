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
    public class AppRolePermissionController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<AppRolePermission> _action = new ActionAppRolePermission(_dataSource);

   
        // GET: api/AppRole
        [HttpGet]
        [Route("api/AppRolePermission")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin", AppID= "SIC", RoleID="All", RoleType="Admin" };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }

        // GET: api/AppRolePermission/roleType
        [HttpGet]
        [Route("api/AppRolePermission/{appID}/{userRole}/{RoleType}")]
        public IHttpActionResult Get(string AppID, string UserRole, string RoleType)
        {
             var para = new { Operate = "GetList", UserID = "asm",  UserRole, AppID, RoleID="0", RoleType };

            var result = _action.GetObjList(para);

            return  CheckGetResult(result);
        }

        // GET: api/AppRolePermission/roleType
        [HttpGet]
        [Route("api/AppRolePermission/{appID}/{userRole}/{RoleType}/{RoleID}")]
        public IHttpActionResult Get(string AppID,string UserRole,string RoleType, string RoleID)
        {
            var para = new { Operate = "Get",  UserID = "asm", UserRole, AppID, RoleID, RoleType };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }
         

        [HttpPost]
        [Route("api/AppRolePermission")]
        public IHttpActionResult Post([FromBody] AppRolePermission appRole)
        {
            if (appRole.RoleID == "")
                return BadRequest("Invalid  Role permission ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

        }

        [HttpPut]
        [Route("api/AppRolePermission")]
        public IHttpActionResult Put([FromBody] AppRolePermission appRole)
        {
            if (appRole.RoleID == "")
                return BadRequest("Invalid  Role permission ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

        }

        // DELETE: api/apprle/5
        [HttpDelete]
        [Route("api/AppRolePermission/{id}")]
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

        private IHttpActionResult CheckGetResult(List<AppRolePermission> result)
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
