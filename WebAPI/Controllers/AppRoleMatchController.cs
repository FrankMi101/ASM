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
    public class AppRoleMatchController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<AppRoleMatch> _action = new ActionAppRoleMatch(_dataSource);

   
        // GET: api/AppRole
        [HttpGet]
        [Route("api/AppRoleMatch")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList", UserID = "asm", UserRole = "Admin", RoleID="All", RoleType="PositionDesc" };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }

        // GET: api/AppRoleMatch/roleType
        [HttpGet]
        [Route("api/AppRoleMatch/{roleType}/{roleID}")]
        public IHttpActionResult Get(string RoleType,string RoleID)
        {
             var para = new { Operate = "GetList", UserID = "asm",  UserRole = "Admin", RoleID, RoleType };

            var result = _action.GetObjList(para);

            return  CheckGetResult(result);
        }

        // GET: api/AppRoleMatch/roleType
        [HttpGet]
        [Route("api/AppRoleMatch/{roleType}/{roleID}/{matchDesc}")]
        public IHttpActionResult Get(string RoleType, string RoleID, string MatchDesc)
        {
            var para = new { Operate = "Get", UserID = "asm", UserRole = "Admin", RoleID, RoleType,MatchDesc };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }
         

        [HttpPost]
        [Route("api/AppRoleMatch")]
        public IHttpActionResult Post([FromBody] AppRoleMatch appRole)
        {
            if (appRole.MatchRole == "")
                return BadRequest("Invalid SAP match Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.AddObj(appRole);

            return CheckActionResult(result);

        }
        [HttpPut]
        [Route("api/AppRoleMatch")]
        public IHttpActionResult Put([FromBody] AppRoleMatch appRole)
        {
            if (appRole.MatchRole == "")
                return BadRequest("Invalid SAP match Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var result = _action.EditObj(appRole);

            return CheckActionResult(result);

        }
        private IHttpActionResult CheckGetResult(List<AppRoleMatch> result)
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
