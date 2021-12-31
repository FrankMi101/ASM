
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
    public class TokenController : ApiController
    {
        // GET api/token
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/token/5
        public string Get(int id)
        {
            return "value";
        }

       

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
