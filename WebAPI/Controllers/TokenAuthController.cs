
using BLL;
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

namespace AuthAPI.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*")]
    public class TokenAuthController : ApiController
    {


        [HttpPost]
        [Route("api/tokenAuth")]
        public IHttpActionResult Post([FromBody] AuthUser user)
        {
            var auth = Authentication.AuthenticateResult("", user.UserName, user.Password);
            if (auth == "true")
            {
                var result = JwtManager.GenerateToken(user);
                //  var result = JwtManager.GenerateToken(user.UserName, user.UserRole);
                return Ok(result);
            }
            else
                return null;
        }

    }
}
