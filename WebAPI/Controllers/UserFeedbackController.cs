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
    public class UserFeedbackController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<Feedback> _action = new ActionAppsFeedback(_dataSource);

   
        // GET: api/UserFeedback
        [HttpGet]
        [Route("api/UserFeedback")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList" };
            var result =  _action.GetObjList(para);
            return CheckGetResult(result);
        }

        // GET: api/UserFeedback/roleType
        [HttpGet]
        [Route("api/UserFeedback/{appID}")]
        public IHttpActionResult Get(string appID)
        {
             var para = new { Operate = "GetListbyAppID", UserID = "asm", IDs = "0", UserRole = "Admin", AppID = appID };

            var result = _action.GetObjList(para);

            return  CheckGetResult(result);
        }

       
        // GET: api/UserFeedback/5
        [HttpGet]
        [Route("api/UserFeedback/{id}")]
        public IHttpActionResult GetbyID(int id)
        {     
            var result =  _action.GetObjByID(id);

            return CheckGetResult(result);
        }

        [HttpPost]
        [Route("api/UserFeedback")]
        public IHttpActionResult Post([FromBody] Feedback UserFeedback)
        {
            if (UserFeedback.ModelID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");
 
            var result = _action.AddObj(UserFeedback);

            return CheckActionResult(result);

        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/UserFeedback")]
        public IHttpActionResult Put([FromBody] Feedback UserFeedback)
        {
            if (UserFeedback.ModelID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            return CheckActionResult(_action.EditObj(UserFeedback));
        }

        // DELETE: api/apprle/5
        [HttpDelete]
        [Route("api/UserFeedback/{id}")]
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
        private IHttpActionResult CheckGetResult(List<Feedback> result)
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
