
using ClassLibrary;
using JwtAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Runtime.Remoting.Messaging;
using System.Web.Http;
using System.Web.Http.Cors;

namespace WebAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class TokenController : ApiController
    {
        [HttpPost]
        [Route("api/token")]
        public IHttpActionResult Post([FromBody] AuthUser user)
        {

            var result = JwtManager.GenerateToken(user);
          //  var result = JwtManager.GenerateToken(user.UserName, user.UserRole);

            return Ok(result);


        }
 
    }
}
