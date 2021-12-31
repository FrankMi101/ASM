using AuthAPI.Models;
using ClassLibrary;
using JwtAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Remoting.Messaging;
using System.Web.Http;

namespace AuthAPI.Controllers
{
    [AllowAnonymous]
    public class ValuesController : ApiController
    {
        // GET api/values
        [Authorize]
        [HttpGet]
        [Route("api/values")]
        public IHttpActionResult Get()
        {
            try
            {             
                var result = JwtManager.ValidateToken(Request);
                if (result)
                {
                    return Ok(new string[] { "value1", "value2" });
                }
                else
                    return Unauthorized();
            }
            catch (Exception)
            {

                throw new Exception("No JWT Tokan provide" );
            }

        }

        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        //// POST api/values
        //public void Post([FromBody] string value)
        //{

        //}

        // PUT api/values/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }


        [Authorize]
        [HttpPost]
        [Route("api/values")]
        public IHttpActionResult Post([FromBody] AuthUser users)
        {
           // var token = Request.Headers.Authorization.Parameter;

            var result = JwtManager.ValidateToken(Request);
            if (result)
                return Ok(result);
            else
                return Unauthorized();

        }

      
        //private IHttpActionResult CheckActionResult(string result)
        //{
        //    if (result == "Failed")
        //        return new ReturnMessage(result, Request);
        //    else
        //        return Ok(result);
        //}
    }
}
