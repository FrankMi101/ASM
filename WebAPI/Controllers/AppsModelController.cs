using ASMBLL;
using ClassLibrary;
using JwtAuth;
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
    [AllowAnonymous]
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class AppsModelController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<AppsModel> _action = new ActionAppsModel(_dataSource);


        // GET: api/AppsModel
        [Authorize]
        [HttpGet]
        [Route("api/AppsModel")]
        public IHttpActionResult Get()
        {
            var authResult = JwtManager.ValidateToken(Request);
            if (authResult)
            {
                var para = new { Operate = "GetList" };
                var result = _action.GetObjList(para);
                return CheckGetResult(result);
            }
            else
                return Unauthorized();
        }

        // GET: api/AppsModel/roleType
        [Authorize]
        [HttpGet]
        [Route("api/AppsModel/{appID}/{ids}")]
        public IHttpActionResult Get(string appID, string IDs)
        {
            var para = new { Operate = "GetListbyAppID", UserID = "asm", IDs = "0", UserRole = "Admin", AppID = appID };

            var result = _action.GetObjList(para);

            return CheckGetResult(result);
        }


        // GET: api/AppsModel/5
        [HttpGet]
        [Route("api/AppsModel/{id}")]
        public IHttpActionResult GetbyID(int id)
        {
            var result = _action.GetObjByID(id);

            return CheckGetResult(result);
        }

        [Authorize]
        [HttpPost]
        [Route("api/AppsModel")]
        public HttpResponseMessage Post([FromBody] AppsModel appsmodel)
        {
            if (appsmodel.ModelID == "")
                return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            var authResult = JwtManager.ValidateToken(Request);

            if (authResult)
            {
                var result = _action.AddObj(appsmodel);
                return CheckResultMessage( HttpStatusCode.OK, result );// CheckActionResult(result);
            }
            else
                return Request.CreateResponse(HttpStatusCode.Unauthorized, "Invalidate Json Web Token");
        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/AppsModel")]
        public IHttpActionResult Put([FromBody] AppsModel appsmodel)
        {
            if (appsmodel.ModelID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            return CheckActionResult(_action.EditObj(appsmodel));
        }

        // DELETE: api/apprle/5
        [Authorize]
        [HttpDelete]
        [Route("api/AppsModel/{id}")]
        public HttpResponseMessage Delete(int id)
        {
            if (id <= 0) //   return new ReturnMessage(id.ToString(), Request);

                return CheckResultMessage(HttpStatusCode.BadRequest, " ID Can not be blank");

            var authResult = JwtManager.ValidateToken(Request);

            if (authResult)
            {
                var result = _action.DeleteObj(id);

                if (result == "Failed")
                    return CheckResultMessage(HttpStatusCode.NotFound, id.ToString());
                else
                    return CheckResultMessage(HttpStatusCode.Accepted, result); // return Request.CreateResponse(HttpStatusCode.Accepted, result);
            }
            else
                return CheckResultMessage(HttpStatusCode.Unauthorized, "Invalidate Json Web Token");
        }
        private IHttpActionResult CheckGetResult(List<AppsModel> result)
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
        private HttpResponseMessage CheckResultMessage(HttpStatusCode statusCode, string message)
        {
            return Request.CreateResponse(statusCode, message);
        }
    }
}
