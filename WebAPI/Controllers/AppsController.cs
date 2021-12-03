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
    public class AppsController : ApiController
    {
        private readonly static string _dataSource = DataSource.Type();
        private IActionApp<Apps> _action = new ActionApps(_dataSource);

   
        // GET: api/Apps
        [HttpGet]
        [Route("api/Apps")]
        public IHttpActionResult Get()
        {
            var para = new { Operate = "GetList" };
            var result =  _action.GetObjList(para);
            return CheckGetResult(result);
        }
 
        // GET: api/Apps/5
        [HttpGet]
        [Route("api/Apps/{id}")]
        public IHttpActionResult GetbyID(int id)
        {     
            var result =  _action.GetObjByID(id);

            return CheckGetResult(result);
        }

        [HttpPost]
        [Route("api/Apps")]
        public IHttpActionResult Post([FromBody] Apps apps)
        {
            if (apps.AppID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");
 
            var result = _action.AddObj(apps);

            return CheckActionResult(result);

            //if (result == "Failed")
            //    return new ReturnMessage(result, Request);
            //else
            //    return Ok(result); 

        }

        // PUT: api/usergroup/
        [HttpPut]
        [Route("api/Apps")]
        public IHttpActionResult Put([FromBody] Apps apps)
        {
            if (apps.AppID == "")
                return BadRequest("Invalid Application Role ID data."); // return Request.CreateResponse(HttpStatusCode.BadRequest, "Group ID Can not be blank");

            return CheckActionResult(_action.EditObj(apps));
        }

        // DELETE: api/apprle/5
        [HttpDelete]
        [Route("api/Apps/{id}")]
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
        private IHttpActionResult CheckGetResult(List<Apps> result)
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
