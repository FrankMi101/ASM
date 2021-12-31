using AuthAPI.Models;
using ClassLibrary;
using JwtAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace AuthAPI.Controllers
{
    public class ValidatetokenController : ApiController
    {
        [HttpPost]
        [Route("api/Validatetoken")]
        public IHttpActionResult Post([FromBody] AuthUser users)
        {
            try
            {
                //var scheme = Request.Headers.Authorization.Scheme;
                //var token = Request.Headers.Authorization.Parameter;

                var result = JwtManager.ValidateToken(Request);

                if (result)
                    return Ok(result);
                else
                    return new HttpActionResult(HttpStatusCode.BadRequest, "Invalidate Json Web Token"); // can use any HTTP status code
                                                                                                    
            }
            catch (Exception)
            {
                return ResponseMessage(Request.CreateErrorResponse(HttpStatusCode.NotAcceptable, "Invalidate Json Web Token"));
            }
        }

    }

}